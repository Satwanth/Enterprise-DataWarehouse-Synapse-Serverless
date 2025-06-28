IF NOT EXISTS (
    SELECT * FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name = 'FactTable' AND s.name = 'gold'
)
BEGIN
CREATE EXTERNAL TABLE gold.FactTable
WITH (
    LOCATION = 'FactTable',
    DATA_SOURCE = gold_src,
    FILE_FORMAT = parquet
)
AS
SELECT
    c.CustKey,
    p.ProdKey,
    r.RegionKey,
    o.OrderKey,
    f.Quantity,
    f.UnitPrice,
    f.TotalAmount
FROM silver.SilverTable f
LEFT JOIN gold.DimCustomer c ON f.CustomerID = c.CustomerID
LEFT JOIN gold.DimProduct p ON f.ProductID = p.ProductID
LEFT JOIN gold.DimRegion r ON f.RegionID = r.RegionID AND f.Country = r.Country
LEFT JOIN gold.DimOrders o ON f.OrderID = o.OrderID
END;
