-- silver: orders 
WITH source AS(
    SELECT * FROM {{ ref('raw_orders') }}
),
modified AS (
    SELECT 
        order_id, 
        customer_id, 
        CAST(order_date AS DATE) AS order_date, 
        LOWER(TRIM(status)) AS status, 
        CAST(total_amount AS DECIMAL(12, 2)) AS total_amount
    FROM source
)

SELECT * FROM modified