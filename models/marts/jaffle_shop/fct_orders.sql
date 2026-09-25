-- Import: calling necessary staging import models
with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

payments as (
    select * from {{ ref('stg_stripe_payments') }}
),

-- Logic: payments by order aggregation ( >= 1 payments per single order)
order_payments as (
    select
        order_id,
        sum(case when payment_status = 'success' then order_amount else 0 end) as amount
    from payments
    group by 1
),

-- Final: join orders with total paid
final as (
    select
        orders.order_id as order_id,
        orders.customer_id as customer_id,
        orders.order_date,
        coalesce(order_payments.amount, 0) as amount
    from orders
    left join order_payments 
        on orders.order_id = order_payments.order_id
)

select * from final