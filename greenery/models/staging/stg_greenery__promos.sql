{{
    config(
        materialized = 'view'
    )
}}

with src_greenery__promos as (
    select * from {{ source('src_greenery','promos') }}
),

renamed_recast as (
    SELECT
    promo_id,
    discount,
    status as promo_status
    from src_greenery__promos
)



select * from renamed_recast