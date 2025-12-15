with dates as (
    select
        order_purchase_timestamp::date as date_day
    from {{ ref('stg_orders') }}
)

select
    date_day,
    extract(year  from date_day) as year,
    extract(month from date_day) as month,
    extract(day   from date_day) as day,
    to_char(date_day, 'Day') as day_name,
    to_char(date_day, 'Month') as month_name
from dates
group by date_day
