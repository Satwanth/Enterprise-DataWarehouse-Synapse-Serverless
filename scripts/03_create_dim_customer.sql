IF NOT EXISTS (
    SELECT * FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name = 'DimCustomer' AND s.name = 'gold'
)
BEGIN
CREATE EXTERNAL TABLE gold.DimCustomer
WITH (
    LOCATION = 'DimCustomer',
    DATA_SOURCE = gold_src,
    FILE_FORMAT = parquet
)
AS
SELECT *,
ROW_NUMBER() OVER (ORDER BY v.CustomerID) AS CustKey
FROM (
    SELECT DISTINCT CustomerID, CustomerName, CustomerEmail, Domain
    FROM silver.SilverTable
) v
END;
