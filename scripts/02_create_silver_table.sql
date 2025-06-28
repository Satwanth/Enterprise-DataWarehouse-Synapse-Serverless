IF NOT EXISTS (
    SELECT * FROM sys.tables t 
    JOIN sys.schemas s 
    ON t.schema_id = s.schema_id
    WHERE t.name = 'SilverTable' and s.name = 'silver'
)
BEGIN
CREATE EXTERNAL TABLE silver.SilverTable (
    OrderID VARCHAR(100),  
    OrderDate DATE,  
    CustomerID VARCHAR(100),  
    CustomerName VARCHAR(100),  
    CustomerEmail VARCHAR(100),  
    ProductID VARCHAR(100),  
    ProductName VARCHAR(100),
    RegionID VARCHAR(100),  
    ProductCategory VARCHAR(100),
    Country VARCHAR(100),
    Quantity INT,  
    UnitPrice INT,  
    TotalAmount INT,  
    Domain VARCHAR(100)
)
WITH (
    LOCATION = 'transformedSales',
    DATA_SOURCE = silver_src,
    FILE_FORMAT = parquet
)
END;
