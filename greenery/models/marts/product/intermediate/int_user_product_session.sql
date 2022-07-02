{{
    config(
        MATERIALIZED = 'table'
    )
}}

SELECT
    user_guid,
    session_guid,
    product_guid,
    min(created_at_utc) as session_start,
    max(created_at_utc) as session_end,
    sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped,
    sum(case when event_type = 'page_view' then 1 else 0 end) as page_view,
    sum(case when event_type = 'checkout' then 1 else 0 end) as checkout,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart
FROM {{ ref('stg_greenery__events')}}

group by 1, 2, 3