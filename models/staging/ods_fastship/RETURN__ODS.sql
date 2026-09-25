{{ config(materialized='table', alias='ODS_RETURN') }}

SELECT 
    CAST(RETURNED_FLAG AS BOOL) AS RETURNED_FLAG,
    TRIM(ORDER_COD) AS ORDER_COD,
    TRIM(PRODUCT_COD) AS PRODUCT_COD
FROM {{ ref('return') }}