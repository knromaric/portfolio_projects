-- Dimension: one row per product 
WITH products AS (
    SELECT * FROM {{ ref('silver_products') }}
), 
dim_prod AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key, 
        product_id, 
        product_name, 
        category, 
        price
    FROM products
)

SELECT * FROM dim_prod