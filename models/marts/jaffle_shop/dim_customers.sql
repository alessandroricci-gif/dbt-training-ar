-- Import: calling necessary staging import models

with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

payments as (
    select * from {{ ref('stg_stripe_payments') }}
),

customers as (
    select * from {{ ref('stg_jaffle_shop__customers') }}
),

-- Logic: payments by order aggregation ( >= 1 payments per single order)

order_payments as (
    select 
        order_id, 
        sum(case when payment_status = 'success' then order_amount else 0 end) as amount
    from payments
    group by 1
),

-- Final: join customers with orders number and total paid

final as (
    select 
        c.customer_id as customer_id, 
        c.first_name as customer_name, 
        c.last_name as customer_surname, 
        count(o.order_id) as orders_total, 
        sum(coalesce(op.amount, 0)) as customer_amount
    from customers c 
    left join orders o on c.customer_id = o.customer_id
    left join order_payments op on o.order_id = op.order_id
    group by 1, 2, 3
)

select * from final