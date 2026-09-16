select
    order_id,
    customer_id,
    order_date,
    amount,
    sum(amount) over (partition by customer_id order by order_date) as cumulative_revenue,
    status
from {{ ref('stg_orders') }}