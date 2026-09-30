-- Quantity must be positive
select
    order_item_id,
    order_id,
    quantity
from {{ ref('fact_order_items') }}
where quantity <= 0