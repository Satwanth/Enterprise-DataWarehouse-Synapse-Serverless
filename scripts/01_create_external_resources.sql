CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'SynapseDW@29';

CREATE DATABASE SCOPED CREDENTIAL ext_creds
WITH IDENTITY = 'Managed Identity';

CREATE EXTERNAL DATA SOURCE silver_src
WITH (
    LOCATION = 'https://azuredwlake.dfs.core.windows.net/silver/',
    CREDENTIAL = ext_creds
);

CREATE EXTERNAL DATA SOURCE gold_src
WITH (
    LOCATION = 'https://azuredwlake.dfs.core.windows.net/gold/',
    CREDENTIAL = ext_creds
);

CREATE EXTERNAL FILE FORMAT parquet
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);

CREATE EXTERNAL FILE FORMAT delta
WITH (
    FORMAT_TYPE = DELTA
);
