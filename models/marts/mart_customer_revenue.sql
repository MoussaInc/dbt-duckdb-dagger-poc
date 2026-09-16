select
    customer_id,
    count(*) as nb_orders,
    max(cumulative_revenue) as max_revenue
from {{ ref('int_customer_revenue') }}
where status = 'completed'
group by customer_id
