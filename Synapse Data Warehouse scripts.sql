CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pass@123'

CREATE DATABASE SCOPED CREDENTIAL storage_credential
WITH identity = 'Managed Identity' ;

drop EXTERNAL DATA SOURCE gold_data_source
CREATE EXTERNAL DATA SOURCE gold_data_source
WITH
(
    TYPE = HADOOP,
    location = 'abfss://gold@hospitaldatastorag.dfs.core.windows.net/',
    credential = storage_credential
) ;

CREATE EXTERNAL FILE FORMAT parquet_format
WITH
(
    FORMAT_TYPE = PARQUET
) ;

--Product table
CREATE EXTERNAL TABLE dbo.dim_patient
(
    patient_id VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    effective_from DATETIME2,
    hash varchar(100),
    surrogate_key BIGINT,
    effective_to DATETIME2,
    is_current BIT
)
WITH
(
    location = 'dim_patient/',
    data_source = gold_data_source,
    file_format = parquet_format
)
;

--Department Dimension
create EXTERNAL TABLE dbo.dim_depatment
(
    surrogate_key BIGINT,
    department NVARCHAR(200),
    hospital_id INT
)
WITH(
    location='dim_department/',
    data_source = gold_data_source,
    FILE_FORMAT = parquet_format
)
;

--Fact Table
create EXTERNAL TABLE dbo.fact_patient_flow
(
    fact_id BIGINT,
    patient_sk BIGINT,
    department_sk BIGINT,
    admission_time DATETIME2,
    discharge_time DATETIME2,
    admission_date DATE,
    length_of_stay_hours FLOAT,
    is_currently_admitted BIT,
    bed_id INT,
    event_ingestion_time DATETIME2
)
WITH(
    location = 'fact_patient_flow/',
    DATA_SOURCE = gold_data_source,
    FILE_FORMAT = parquet_format
)
;
select * from dbo.fact_patient_flow;















