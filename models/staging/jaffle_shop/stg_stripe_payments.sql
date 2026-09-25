select 
      ID as id,
      ORDERID as order_id,
      PAYMENTMETHOD as payment_method,
      STATUS as payment_status,
      AMOUNT as order_amount,
      CREATED as order_created_date
from {{ ref ('stripe_payments') }};