{{
    config(
        materialized = 'view'
    )
}}

with src_greenery__products as (
    select * from {{ source('src_greenery','products') }}
),

renamed_recast as (
    SELECT
    product_id as product_guid,
    name as product_name,
    price as product_price,
    inventory as product_inventory
    from src_greenery__products
)



select * from renamed_recast