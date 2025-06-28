IF NOT EXISTS (
    SELECT * FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name = 'DimRegion' AND s.name = 'gold'
)
BEGIN
CREATE EXTERNAL TABLE gold.DimRegion
WITH (
    LOCATION = 'DimRegion',
    DATA_SOURCE = gold_src,
    FILE_FORMAT = parquet
)
AS
SELECT *,
ROW_NUMBER() OVER (ORDER BY x.RegionID) AS RegionKey
FROM (
    SELECT DISTINCT RegionID, Country
    FROM silver.SilverTable
) x
END;
