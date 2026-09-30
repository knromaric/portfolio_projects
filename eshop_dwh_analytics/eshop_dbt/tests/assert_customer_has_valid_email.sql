-- Email contains @ (current snapshot rows)
SELECT 
    customer_id, 
    email 
FROM {{ ref('scd_customers') }}
WHERE dbt_valid_to IS NULL 
    AND (email NOT LIKE '%@%' OR email IS NULL)