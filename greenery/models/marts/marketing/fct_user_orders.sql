{{
    config(
        MATERIALIZED = 'table'
    )
}}

SELECT
    user_guid,
    first_name || ' ' || last_name as full_name,
    count(distinct(order_guid)) as total_orders,
    sum(quantity) as total_products_ordered,
    round(cast(sum(order_total) as numeric),2) as total_spent,
    avg(order_total) as average_spent_per_order,
    sum(case when order_status = 'preparing' then 1 else 0 end) as items_preparing,
    sum(case when order_status = 'shipped' then 1 else 0 end) as items_shipped,
    sum(case when order_status = 'delivered' then 1 else 0 end) as items_delivered,
    current_date - max(created_at_utc) as time_since_last_order,
    sum(case when shipping_service = 'ups' then 1 else 0 end) as ups_packages,
    sum(case when shipping_service = 'usps' then 1 else 0 end) as usps_packages,
    sum(case when shipping_service = 'fedex' then 1 else 0 end) as fedex_packages,
    sum(case when shipping_service = 'dhl' then 1 else 0 end) as dhl_packages
FROM {{ ref('int_users_orders') }}
GROUP BY user_guid, full_name