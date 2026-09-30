-- revenue must be non negative
SELECT 
    order_id, 
    revenue
FROM {{ ref('fact_orders') }}
WHERE revenue < 0