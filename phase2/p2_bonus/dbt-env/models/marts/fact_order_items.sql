select
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    o.customer_id,
    o.order_purchase_timestamp::date as order_date,
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) as total_item_value,
    p.payment_value
from {{ ref('stg_order_items') }} as oi
left join {{ ref('stg_orders') }} as o
    on oi.order_id = o.order_id
left join {{ ref('stg_payments') }} as p
    on oi.order_id = p.order_id
