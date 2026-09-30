WITH source AS ( 
    SELECT * FROM {{ ref('raw_order_items') }}
),

modified AS (
    SELECT
        order_item_id, 
        order_id, 
        product_id, 
        CAST(quantity AS INT) AS quantity, 
        CAST(unit_price AS DECIMAL(12,2)) AS unit_price
    FROM source
)

SELECT * FROM modified