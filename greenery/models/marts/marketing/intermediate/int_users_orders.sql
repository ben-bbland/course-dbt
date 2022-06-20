{{
    config(
        MATERIALIZED = 'table'
    )
}}

SELECT
    stg_greenery__orders.order_guid,
    stg_greenery__orders.user_guid,
    stg_greenery__users.first_name,
    stg_greenery__users.last_name,
    stg_greenery__addresses.address,
    stg_greenery__addresses.state,
    stg_greenery__addresses.country,
    stg_greenery__products.product_name,
    stg_greenery__order_items.quantity,
    stg_greenery__orders.created_at_utc,
    stg_greenery__orders.delivered_at_utc,
    stg_greenery__orders.order_cost,
    stg_greenery__orders.shipping_cost,
    stg_greenery__orders.order_total,
    stg_greenery__orders.shipping_service,
    stg_greenery__orders.order_status
FROM {{ ref('stg_greenery__orders')}}
LEFT JOIN {{ ref('stg_greenery__users') }}
    ON stg_greenery__orders.user_guid = stg_greenery__users.user_guid
LEFT JOIN {{ ref('stg_greenery__addresses') }}
    ON stg_greenery__orders.address_guid = stg_greenery__addresses.address_guid
LEFT JOIN {{ ref('stg_greenery__order_items') }}
    ON stg_greenery__orders.order_guid = stg_greenery__order_items.order_guid
LEFT JOIN {{ ref('stg_greenery__products') }}
    ON stg_greenery__order_items.product_guid = stg_greenery__products.product_guid