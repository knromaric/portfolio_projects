{{
    config(
        materialized='incremental', 
        unique_key='order_id', 
        merge_update_columns=['status', 'revenue', 'number_of_lines', 'total_units', 'customer_country']
    )
}}

-- adding incremental data 
WITH orders_enriched AS (
    SELECT * FROM {{ ref('silver_int_orders_enriched') }}
    {% if is_incremental() %}
    WHERE order_date > (SELECT MAX(order_date) FROM {{this}})
    {% endif %}
), 
fact_ord AS (
    SELECT 
        {{dbt_utils.generate_surrogate_key(['order_id'])}} AS order_key,
        order_id, 
        customer_id, 
        order_date, 
        status, 
        order_total_amount as revenue, 
        line_count as number_of_lines, 
        total_quantity as total_units, 
        customer_country

    FROM orders_enriched

)

SELECT * FROM fact_ord