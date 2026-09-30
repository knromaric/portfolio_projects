{{
    config(
        materialized='incremental',
        unique_key='order_item_id',
        merge_update_columns=['quantity', 'unit_price', 'revenue', 'order_status']
    )
}}

WITH line_items as (
    SELECT * FROM {{ ref('silver_int_order_items_with_product') }}
    {% if is_incremental()%}
    WHERE order_date > (SELECT MAX(order_date) FROM {{this}})
    {% endif %}
),

fact_oi AS (
    SELECT 
        order_item_id, 
        order_id, 
        product_id, 
        quantity, 
        unit_price, 
        line_total AS revenue, 
        product_name, 
        product_category, 
        customer_id, 
        order_date, 
        order_status
    FROM 
        line_items
)
SELECT * FROM fact_oi