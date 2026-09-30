WITH source AS (
    SELECT * FROM {{ ref('raw_products') }}
),
modified AS (
    SELECT 
        product_id, 
        TRIM(product_name) AS product_name,
        TRIM(category) AS category,
        CAST(price AS  DECIMAL(12, 2)) AS price 
    FROM source
)

SELECT * FROM modified