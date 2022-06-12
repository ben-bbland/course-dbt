{{
    config(
        materialized = 'view'
    )
}}

with src_greenery__orders as (
    select * from {{ source('src_greenery','orders') }}
),

renamed_recast as (
    SELECT
    order_id as order_guid,
    user_id as user_guid,
    promo_id,
    address_id as address_guid,
    created_at as created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id as tracking_guid,
    shipping_service,
    estimated_delivery_at as estimated_delivery_at_utc,
    delivered_at as delivered_at_utc,
    status as order_status
    from src_greenery__orders
)



select * from renamed_recast