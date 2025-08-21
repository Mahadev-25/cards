# Excel Upload ASP.NET VB Application

This ASP.NET VB application allows users to upload Excel files and save the data to a SQL Server database, then display the data in a repeater control.

## Features

- Upload Excel files (.xlsx, .xls)
- Automatically read data from 10 columns
- Save data to SQL Server database
- Display uploaded data in a responsive table
- Clear all data functionality
- Bootstrap styling for modern UI

## Setup Instructions

### 1. Database Setup
Run the SQL script `CreateExcelDataTable.sql` to create the required table:

```sql
CREATE TABLE ExcelData (
    ID int IDENTITY(1,1) PRIMARY KEY,
    Column1 nvarchar(255),
    Column2 nvarchar(255),
    Column3 nvarchar(255),
    Column4 nvarchar(255),
    Column5 nvarchar(255),
    Column6 nvarchar(255),
    Column7 nvarchar(255),
    Column8 nvarchar(255),
    Column9 nvarchar(255),
    Column10 nvarchar(255),
    UploadedBy nvarchar(100),
    UploadedDate datetime DEFAULT GETDATE()
);
```

### 2. NuGet Packages
Install the following NuGet packages or use the provided `packages.config`:

- ClosedXML (for reading Excel files)
- DocumentFormat.OpenXml
- ExcelNumberFormat

### 3. Web.config Configuration
Update your web.config with the following settings:

```xml
<system.web>
    <httpRuntime maxRequestLength="51200" executionTimeout="3600" />
</system.web>

<system.webServer>
    <security>
        <requestFiltering>
            <requestLimits maxAllowedContentLength="52428800" />
        </requestFiltering>
    </security>
</system.webServer>
```

### 4. Folder Structure
Create a `TempFiles` folder in your application root for temporary file storage.

## File Structure

- `ExcelUpload.aspx` - Main page with file upload and data display
- `ExcelUpload.aspx.vb` - Code-behind with Excel processing logic
- `CreateExcelDataTable.sql` - Database table creation script
- `web.config.example` - Example web.config settings
- `packages.config` - NuGet package references

## How It Works

1. **File Upload**: User selects an Excel file using the file upload control
2. **Data Processing**: The application reads the Excel file using ClosedXML library
3. **Database Storage**: Data from the first 10 columns is saved to the SQL Server table
4. **Data Display**: The uploaded data is displayed in a responsive table using a Repeater control
5. **Error Handling**: Comprehensive error handling with user-friendly messages

## Key Features in Code

### Excel Reading Methods
- Primary method uses ClosedXML for modern Excel files
- Fallback to OleDb for compatibility with older systems
- Handles both .xlsx and .xls file formats

### Database Operations
- Parameterized queries to prevent SQL injection
- Connection management using existing connection infrastructure
- Bulk insert operations for efficiency

### User Interface
- Bootstrap-styled responsive design
- Real-time status messages
- Data pagination ready (can be extended)
- Clear data functionality

## Error Handling

The application includes comprehensive error handling for:
- Invalid file formats
- Empty files
- Database connection issues
- File access permissions
- Large file uploads

## Security Features

- File extension validation
- Parameterized SQL queries
- Session-based authentication (inherited from existing system)
- Temporary file cleanup
- Request size limitations

## Browser Compatibility

The application works with all modern browsers and includes:
- Bootstrap 4 styling
- jQuery for enhanced functionality
- Select2 for improved dropdowns (ready for future enhancements)

## Future Enhancements

Potential improvements:
- Column mapping interface
- Data validation rules
- Export functionality
- Batch processing for large files
- Progress indicators for large uploads