-- Create ExcelData table for storing uploaded Excel data
CREATE TABLE ExcelData (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyID NVARCHAR(50) NULL,
    DivisionID NVARCHAR(50) NULL,
    DepartmentID NVARCHAR(50) NULL,
    Column1 NVARCHAR(255) NULL,
    Column2 NVARCHAR(255) NULL,
    Column3 NVARCHAR(255) NULL,
    Column4 NVARCHAR(255) NULL,
    Column5 NVARCHAR(255) NULL,
    Column6 NVARCHAR(255) NULL,
    Column7 NVARCHAR(255) NULL,
    Column8 NVARCHAR(255) NULL,
    Column9 NVARCHAR(255) NULL,
    Column10 NVARCHAR(255) NULL,
    UploadedBy NVARCHAR(100) NULL,
    UploadedDate DATETIME NULL
);

-- Create index for better performance
CREATE INDEX IX_ExcelData_CompanyID_DivisionID ON ExcelData (CompanyID, DivisionID);
CREATE INDEX IX_ExcelData_UploadedDate ON ExcelData (UploadedDate DESC);