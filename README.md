# 📊 Enterprise Data Warehouse on Azure Synapse (Serverless)

This project showcases a complete end-to-end data solution fully implemented within **Azure Synapse Analytics**. From ingesting a raw CSV file, transforming it using Synapse Data Flows, and storing curated data in Azure Data Lake Gen2, to building a **serverless SQL-based data warehouse with dimensional modeling**, surrogate keys, and organized fact and dimension tables ready for analysis and reporting. The solution demonstrates how Synapse can serve as a unified platform for data extraction, transformation, loading, and modeling—without relying on any external services.

---

## 🚀 Project Overview

This implementation includes:

- **Azure Synapse Workspace** provisioning
- **Azure Data Lake Gen2 Storage** configured as the default storage account
- **Managed Identity-based authentication** between Synapse and Data Lake
- **ETL pipelines** transforming raw CSV data into curated parquet files
- **External tables** over the data lake for SQL-based querying
- **Dimensional modeling** with surrogate keys
- A final **fact table** joining all dimensions

---

## 🏗️ End-to-End Process

Below are the main steps performed:

---

### 1️⃣ Synapse Workspace and Storage Setup

- Created an **Azure Synapse Analytics workspace**.
- Provisioned **Azure Data Lake Storage Gen2** containers:
  - `silver` container for curated data
  - `gold` container for dimensional and fact data
- Configured **Managed Identity access**:
  - Assigned **Storage Blob Data Contributor** role to the Synapse workspace's managed identity.
  - Enabled seamless access without storing keys.

---

### 2️⃣ External Resources Configuration

In Synapse serverless SQL pools:

- Created a **master key** to encrypt credentials.
- Created **database scoped credentials** using managed identity.
- Created **external data sources**:
  - `silver_src` for silver layer files
  - `gold_src` for gold layer files
- Created **external file formats** for:
  - Parquet files (main format)
  - Delta format (reference only)

**Reference script:**  
`01_create_external_resources.sql`

---

### 3️⃣ Silver Layer Table Creation

- Built a **Synapse Pipeline**:
  - Ingested raw CSV data.
  - Transformed it to a clean, standardized schema.
  - Stored output as Parquet files in the **silver layer**.
- Added a **Script Activity** after the dataflow to create the external table if it didn’t exist:
  - `silver.SilverTable`

**Reference script:**  
`02_create_silver_table.sql`

---

### 4️⃣ Gold Layer Dimensional Tables

Created **dimension tables** over the silver data to enable dimensional modeling:

- `DimCustomer`: Customer attributes
- `DimProduct`: Product attributes
- `DimRegion`: Regional attributes
- `DimOrders`: Flattened dimension with descriptive order columns

**Deduplication & Surrogate Keys:**
- Used `SELECT DISTINCT` to ensure unique rows.
- Added `ROW_NUMBER()` to generate surrogate keys.

**Reference scripts:**
- `03_create_dim_customer.sql`
- `04_create_dim_product.sql`
- `05_create_dim_region.sql`
- `06_create_dim_orders.sql`

---

### 5️⃣ Gold Layer Fact Table

Created a **fact table** combining the dimension tables and numeric measures:

- Joined silver data to dimension tables on business keys.
- Selected surrogate keys and measure columns.
- Stored output as Parquet files in the **gold layer**.

**Reference script:**  
`07_create_fact_table.sql`

---

### 6️⃣ Final Validation and Querying

- Verified row counts for all tables.
- Queried the fact table with joins to dimensions.
- Confirmed no duplicate keys.

---

## ✨ Highlights

✅ Modern data warehouse design with **bronze, silver, and gold layers**  
✅ Fully **serverless** architecture — no dedicated SQL pools  
✅ **Managed identity authentication** (secure, keyless access)  
✅ Clear separation of raw data, transformed data, and dimensional modeling  
✅ Modular scripts for reusability 

---
