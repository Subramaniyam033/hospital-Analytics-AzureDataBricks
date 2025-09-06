# hospital-Analytics-AzureDataBricks
End-to-end Azure data engineering project using Event Hubs, Databricks, ADLS Gen2, Data Factory, Synapse, and Power BI to process real-time hospital patient and bed occupancy data with a bronze-silver-gold medallion architecture.

# 🏥 Real-Time Hospital Patient & Bed Occupancy Analytics on Azure

## 📌 Project Overview
This project demonstrates a **modern data architecture on Azure** to handle **real-time hospital patient data and bed occupancy details**.  
It uses **Azure Event Hubs, Databricks, ADLS Gen2, Delta Lake, Azure Data Factory, Synapse Analytics, and Power BI** to build a **scalable data pipeline** with **bronze, silver, and gold layers** for storage and analytics.

---

## 🚀 Architecture
1. **Data Generation & Streaming**
   - Synthetic hospital data (patients & bed occupancy) was generated using **Databricks**.
   - Data was streamed in **real-time** to **Azure Event Hub**.

2. **Bronze Layer (Raw Data)**
   - Event Hub data was ingested into **Azure Data Lake Storage Gen2 (ADLS Gen2)** in **binary format**.
   - Stored in the **bronze container**.

3. **Silver Layer (Cleaned & Transformed Data)**
   - Used **Databricks notebooks** to transform binary data into structured format.
   - Applied data cleaning, normalization, and transformations.
   - Stored results in the **silver container** in ADLS Gen2.

4. **Gold Layer (Curated Data for Analytics)**
   - Implemented **schema evolution** with **Delta Tables**.
   - Created **dimension and fact tables**:
     - `dim_patient`
     - `dim_department`
     - `fact_patient_flow`
   - Stored curated tables in the **gold container**.

5. **Orchestration with Azure Data Factory (ADF)**
   - Pipeline created with:
     - **Get Metadata** activity → fetch child items from the silver layer.
     - **If Condition** activity → check if the silver layer has more than 5 files.
     - If **true**, trigger **Databricks notebook execution** for gold layer processing.
   - **Scheduled trigger**: Runs every **15 minutes**.

   ![ADF Pipeline](DataFactory%20Databricks%20notebook%20execution.png)

6. **Analytics with Synapse & Power BI**
   - Created a **Dedicated SQL Pool** in Synapse.
   - Defined **external tables** for:
     - `dim_patient`
     - `dim_department`
     - `fact_patient_flow`
   - Connected Synapse to **Power BI** for interactive visualizations.

---

