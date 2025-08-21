-- Create table for Excel data with 10 columns
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