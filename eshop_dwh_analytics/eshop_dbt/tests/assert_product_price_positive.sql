-- product price must be positive
SELECT 
    product_id, 
    product_name, 
    price
FROM {{ ref('silver_products') }}
WHERE price <= 0 