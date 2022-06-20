{{
    config(
        MATERIALIZED = 'table'
  )
}}

with orders as (

    SELECT
        order_guid,
        user_guid,
        promo_id,
        address_guid,
        created_at_utc,
        order_cost,
        shipping_cost,
        order_total,
        tracking_guid,
        shipping_service,
        estimated_delivery_at_utc,
        delivered_at_utc,
        order_status

    FROM {{ ref('stg_greenery__orders') }}

)

SELECT * FROM orders