{{
    config(
        materialized = 'view'
    )
}}

with src_greenery__order_items as (
    select * from {{ source('src_greenery','order_items') }}
),

renamed_recast as (
    SELECT
    order_id as order_guid,
    product_id as product_guid,
    quantity
    from src_greenery__order_items
)



select * from renamed_recast