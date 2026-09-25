select
    id as customer_id,
    first_name,
    last_name
from {{ ref('jaffle_shop__customers') }};