Imports System.Data.SqlClient
Imports System.Data
Imports System.IO
Imports System.Data.OleDb
Imports ClosedXML.Excel

Partial Class reports_ExcelUpload
    Inherits System.Web.UI.Page
    Dim ConnectionString As String = ""
    Dim CompanyID As String = ""
    Dim DivisionID As String = ""
    Dim DepartmentID As String = ""
    Dim EmployeeID As String = ""
    Dim strSQL As String

    Function Connection() As SqlConnection
        Dim context As HttpContext = HttpContext.Current
        Dim myConnection As SqlConnection = CType(context.Items("SqlConnection"), SqlConnection)
        If Not myConnection Is Nothing Then
            If myConnection.State = ConnectionState.Open Then
                Return myConnection
            End If
        End If
        myConnection = New SqlConnection(ConnectionString)
        myConnection.Open()
        context.Items("SqlConnection") = myConnection
        Return myConnection
        myConnection.Close()
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim SessionKey As Hashtable = CType(Session("SessionKey"), Hashtable)
        If Session("SessionKey") Is Nothing Then
            Response.Redirect("~/Login.aspx")
        End If
        ConnectionString = EnterpriseCommon.Configuration.ConfigSettings.ConnectionString
        CompanyID = SessionKey("CompanyID").ToString
        DivisionID = SessionKey("DivisionID").ToString
        DepartmentID = SessionKey("DepartmentID").ToString
        EmployeeID = Session("EmployeeUserName").ToString

        If Not IsPostBack Then
            LoadExcelData()
        End If
    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs)
        Try
            If fileUpload.HasFile Then
                Dim fileName As String = fileUpload.FileName
                Dim fileExtension As String = Path.GetExtension(fileName).ToLower()
                
                ' Validate file extension
                If fileExtension = ".xlsx" Or fileExtension = ".xls" Then
                    ' Save file temporarily
                    Dim tempPath As String = Server.MapPath("~/TempFiles/")
                    If Not Directory.Exists(tempPath) Then
                        Directory.CreateDirectory(tempPath)
                    End If
                    
                    Dim filePath As String = tempPath & fileName
                    fileUpload.SaveAs(filePath)
                    
                    ' Read Excel data and save to database
                    Dim rowsInserted As Integer = ReadExcelAndSaveToDatabase(filePath)
                    
                    ' Delete temporary file
                    If File.Exists(filePath) Then
                        File.Delete(filePath)
                    End If
                    
                    If rowsInserted > 0 Then
                        ShowMessage("Success! " & rowsInserted.ToString() & " records uploaded successfully.", "alert-success")
                        LoadExcelData() ' Refresh the display
                    Else
                        ShowMessage("No data found in the Excel file.", "alert-warning")
                    End If
                Else
                    ShowMessage("Please select a valid Excel file (.xlsx or .xls)", "alert-danger")
                End If
            Else
                ShowMessage("Please select a file to upload.", "alert-warning")
            End If
        Catch ex As Exception
            ShowMessage("Error: " & ex.Message, "alert-danger")
        End Try
    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs)
        Try
            ClearAllData()
            ShowMessage("All data cleared successfully.", "alert-success")
            LoadExcelData() ' Refresh the display
        Catch ex As Exception
            ShowMessage("Error clearing data: " & ex.Message, "alert-danger")
        End Try
    End Sub

    Private Function ReadExcelAndSaveToDatabase(filePath As String) As Integer
        Dim rowsInserted As Integer = 0
        
        Try
            Using workbook As New XLWorkbook(filePath)
                Dim worksheet = workbook.Worksheet(1) ' Get first worksheet
                Dim lastRow As Integer = worksheet.LastRowUsed().RowNumber()
                
                ' Start from row 2 (assuming row 1 has headers)
                For row As Integer = 2 To lastRow
                    Dim values(9) As String ' Array for 10 columns
                    
                    ' Read data from 10 columns
                    For col As Integer = 1 To 10
                        Dim cellValue = worksheet.Cell(row, col).Value.ToString().Trim()
                        values(col - 1) = If(String.IsNullOrEmpty(cellValue), "", cellValue)
                    Next
                    
                    ' Insert into database
                    If InsertExcelDataRow(values) Then
                        rowsInserted += 1
                    End If
                Next
            End Using
        Catch ex As Exception
            ' If ClosedXML fails, try OleDb method
            rowsInserted = ReadExcelUsingOleDb(filePath)
        End Try
        
        Return rowsInserted
    End Function

    Private Function ReadExcelUsingOleDb(filePath As String) As Integer
        Dim rowsInserted As Integer = 0
        Dim connectionString As String = ""
        
        Try
            Dim fileExtension As String = Path.GetExtension(filePath).ToLower()
            
            If fileExtension = ".xlsx" Then
                connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & filePath & ";Extended Properties=""Excel 12.0 Xml;HDR=YES;IMEX=1"""
            Else
                connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & filePath & ";Extended Properties=""Excel 8.0;HDR=YES;IMEX=1"""
            End If
            
            Using oleConnection As New OleDbConnection(connectionString)
                oleConnection.Open()
                
                ' Get sheet names
                Dim schemaTable As DataTable = oleConnection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, Nothing)
                Dim sheetName As String = schemaTable.Rows(0)("TABLE_NAME").ToString()
                
                ' Read data from Excel
                Dim query As String = "SELECT * FROM [" & sheetName & "]"
                Using oleCommand As New OleDbCommand(query, oleConnection)
                    Using oleAdapter As New OleDbDataAdapter(oleCommand)
                        Dim dataTable As New DataTable()
                        oleAdapter.Fill(dataTable)
                        
                        ' Process each row
                        For Each row As DataRow In dataTable.Rows
                            Dim values(9) As String ' Array for 10 columns
                            
                            For i As Integer = 0 To Math.Min(9, dataTable.Columns.Count - 1)
                                values(i) = If(row(i) IsNot DBNull.Value, row(i).ToString().Trim(), "")
                            Next
                            
                            ' Fill remaining columns with empty strings if Excel has fewer than 10 columns
                            For i As Integer = dataTable.Columns.Count To 9
                                values(i) = ""
                            Next
                            
                            If InsertExcelDataRow(values) Then
                                rowsInserted += 1
                            End If
                        Next
                    End Using
                End Using
            End Using
        Catch ex As Exception
            Throw New Exception("Error reading Excel file: " & ex.Message)
        End Try
        
        Return rowsInserted
    End Function

    Private Function InsertExcelDataRow(values() As String) As Boolean
        Try
            strSQL = "INSERT INTO ExcelData (Column1, Column2, Column3, Column4, Column5, " &
                    "Column6, Column7, Column8, Column9, Column10, UploadedBy, UploadedDate) " &
                    "VALUES (@Col1, @Col2, @Col3, @Col4, @Col5, @Col6, @Col7, @Col8, @Col9, @Col10, @UploadedBy, @UploadedDate)"
            
            Using cmd As New SqlCommand(strSQL, Connection())
                cmd.Parameters.AddWithValue("@Col1", values(0))
                cmd.Parameters.AddWithValue("@Col2", values(1))
                cmd.Parameters.AddWithValue("@Col3", values(2))
                cmd.Parameters.AddWithValue("@Col4", values(3))
                cmd.Parameters.AddWithValue("@Col5", values(4))
                cmd.Parameters.AddWithValue("@Col6", values(5))
                cmd.Parameters.AddWithValue("@Col7", values(6))
                cmd.Parameters.AddWithValue("@Col8", values(7))
                cmd.Parameters.AddWithValue("@Col9", values(8))
                cmd.Parameters.AddWithValue("@Col10", values(9))
                cmd.Parameters.AddWithValue("@UploadedBy", EmployeeID)
                cmd.Parameters.AddWithValue("@UploadedDate", DateTime.Now)
                
                cmd.ExecuteNonQuery()
            End Using
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Sub LoadExcelData()
        Try
            strSQL = "SELECT * FROM ExcelData ORDER BY UploadedDate DESC"
            
            Using cmd As New SqlCommand(strSQL, Connection())
                Using adapter As New SqlDataAdapter(cmd)
                    Dim dataTable As New DataTable()
                    adapter.Fill(dataTable)
                    
                    If dataTable.Rows.Count > 0 Then
                        rptExcelData.DataSource = dataTable
                        rptExcelData.DataBind()
                        
                        lblRecordCount.Text = "Total Records: " & dataTable.Rows.Count.ToString()
                        pnlData.Visible = True
                        pnlNoData.Visible = False
                    Else
                        pnlData.Visible = False
                        pnlNoData.Visible = True
                    End If
                End Using
            End Using
        Catch ex As Exception
            ShowMessage("Error loading data: " & ex.Message, "alert-danger")
            pnlData.Visible = False
            pnlNoData.Visible = True
        End Try
    End Sub

    Private Sub ClearAllData()
        strSQL = "DELETE FROM ExcelData"
        Using cmd As New SqlCommand(strSQL, Connection())
            cmd.ExecuteNonQuery()
        End Using
    End Sub

    Private Sub ShowMessage(message As String, cssClass As String)
        lblMessage.Text = message
        lblMessage.CssClass = "alert " & cssClass
        lblMessage.Visible = True
    End Sub
End Class