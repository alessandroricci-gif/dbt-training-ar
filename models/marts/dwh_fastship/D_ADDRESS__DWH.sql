{{ config(materialized='table', alias='D_ADDRESS') }}

WITH all_addresses AS (
    SELECT DISTINCT
        SHIPMENT_ADDRESS_COD AS ADDRESS_CD, 
        SHIPMENT_CITY AS CITY_DS, 
        SHIPMENT_STATE AS STATE_DS, 
        SHIPMENT_COUNTRY AS COUNTRY_DS, 
        SHIPMENT_POSTAL_CODE AS POSTAL_CODE_CD 
    FROM {{ ref('ORDER__ODS') }}
    
    UNION DISTINCT 
    
    SELECT DISTINCT
        CLIENT_ADDRESS_COD, 
        CLIENT_CITY, 
        CLIENT_STATE, 
        CLIENT_COUNTRY, 
        CLIENT_POSTAL_CODE 
    FROM {{ ref('ORDER__ODS') }}
)

SELECT 
    {{hash(['ADDRESS_CD'])}} AS ADDRESS_ID, 
    ADDRESS_CD, 
    CITY_DS, 
    STATE_DS, 
    COUNTRY_DS, 
    POSTAL_CODE_CD, 
    CURRENT_TIMESTAMP() AS TRANSACTION_TIMESTAMP, 
    'I' AS TRANSACTION_FLAG 
FROM all_addresses