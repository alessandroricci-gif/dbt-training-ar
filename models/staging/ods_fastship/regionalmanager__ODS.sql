{{ config(materialized='table', alias='ODS_REGIONALMANAGER') }}

SELECT 
    TRIM(PERSON) AS PERSON,
    TRIM(REGION) AS REGION,
    TRIM(MARKET) AS MARKET
FROM {{ ref('regionalmanager') }}