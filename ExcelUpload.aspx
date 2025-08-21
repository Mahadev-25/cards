<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ExcelUpload.aspx.vb" Inherits="reports_ExcelUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Excel Upload</title>

    <link href="../Bootstrap2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="../Bootstrap2/js/jquery3.3.1.min.js"></script>
    <script src="../Bootstrap2/js/bootstrap.min.js"></script>
    <link href="../Bootstrap2/css/Select2.min.css" rel="stylesheet" />
    <script src="../Bootstrap2/js/Select2.min.js"></script>

    <script>
        $(document).ready(function () {
            $('.js-example-basic-single').select2();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>Excel File Upload</h4>
                        </div>
                        <div class="card-body">
                            <!-- File Upload Section -->
                            <div class="form-group">
                                <label for="fileUpload">Select Excel File:</label>
                                <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control" accept=".xlsx,.xls" />
                                <small class="form-text text-muted">Please select an Excel file (.xlsx or .xls)</small>
                            </div>
                            
                            <div class="form-group mt-3">
                                <asp:Button ID="btnUpload" runat="server" Text="Upload and Save Data" 
                                    CssClass="btn btn-primary" OnClick="btnUpload_Click" />
                                <asp:Button ID="btnClear" runat="server" Text="Clear Data" 
                                    CssClass="btn btn-secondary ml-2" OnClick="btnClear_Click" />
                            </div>
                            
                            <!-- Status Messages -->
                            <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Data Display Section -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>Uploaded Data</h4>
                        </div>
                        <div class="card-body">
                            <asp:Panel ID="pnlData" runat="server" Visible="false">
                                <div class="table-responsive">
                                    <asp:Repeater ID="rptExcelData" runat="server">
                                        <HeaderTemplate>
                                            <table class="table table-striped table-bordered">
                                                <thead class="thead-dark">
                                                    <tr>
                                                        <th>S.No</th>
                                                        <th>Column 1</th>
                                                        <th>Column 2</th>
                                                        <th>Column 3</th>
                                                        <th>Column 4</th>
                                                        <th>Column 5</th>
                                                        <th>Column 6</th>
                                                        <th>Column 7</th>
                                                        <th>Column 8</th>
                                                        <th>Column 9</th>
                                                        <th>Column 10</th>
                                                        <th>Uploaded Date</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("Column1") %></td>
                                                <td><%# Eval("Column2") %></td>
                                                <td><%# Eval("Column3") %></td>
                                                <td><%# Eval("Column4") %></td>
                                                <td><%# Eval("Column5") %></td>
                                                <td><%# Eval("Column6") %></td>
                                                <td><%# Eval("Column7") %></td>
                                                <td><%# Eval("Column8") %></td>
                                                <td><%# Eval("Column9") %></td>
                                                <td><%# Eval("Column10") %></td>
                                                <td><%# Eval("UploadedDate", "{0:dd/MM/yyyy HH:mm}") %></td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                                </tbody>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                                
                                <!-- Summary -->
                                <div class="mt-3">
                                    <asp:Label ID="lblRecordCount" runat="server" CssClass="badge badge-info"></asp:Label>
                                </div>
                            </asp:Panel>
                            
                            <asp:Panel ID="pnlNoData" runat="server" Visible="true">
                                <div class="alert alert-info">
                                    <i class="fa fa-info-circle"></i> No data available. Please upload an Excel file to see the data.
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>