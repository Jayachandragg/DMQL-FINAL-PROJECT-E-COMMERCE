select
    s.seller_id,
    s.seller_city,
    s.seller_state
from {{ ref('stg_sellers') }} as s
