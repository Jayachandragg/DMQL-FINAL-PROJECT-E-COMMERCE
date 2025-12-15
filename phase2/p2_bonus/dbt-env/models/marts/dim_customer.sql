select
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state
from {{ ref('stg_customers') }} as c
