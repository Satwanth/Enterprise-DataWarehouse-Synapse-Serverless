IF NOT EXISTS (
    SELECT * FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name = 'DimProduct' AND s.name = 'gold'
)
BEGIN
CREATE EXTERNAL TABLE gold.DimProduct
WITH (
    LOCATION = 'DimProduct',
    DATA_SOURCE = gold_src,
    FILE_FORMAT = parquet
)
AS
SELECT *,
ROW_NUMBER() OVER (ORDER BY p.ProductID) AS ProdKey
FROM (
    SELECT DISTINCT ProductID, ProductName, ProductCategory
    FROM silver.SilverTable
) p
END;
