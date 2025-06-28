IF NOT EXISTS (
    SELECT * FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name = 'DimOrders' AND s.name = 'gold'
)
BEGIN
CREATE EXTERNAL TABLE gold.DimOrders
WITH (
    LOCATION = 'DimOrders',
    DATA_SOURCE = gold_src,
    FILE_FORMAT = parquet
)
AS
SELECT *,
ROW_NUMBER() OVER (ORDER BY y.CustomerID) AS OrderKey
FROM (
    SELECT DISTINCT
        OrderID, OrderDate,
        CustomerID, CustomerName, CustomerEmail, Domain,
        ProductID, ProductName, ProductCategory,
        RegionID, Country
    FROM silver.SilverTable
) y
END;
