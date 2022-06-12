{{
    config(
        materialized = 'view'
    )
}}

with src_greenery__addresses as (
    select * from {{ source('src_greenery','addresses') }}
),

renamed_recast as (
    SELECT
    address_id as address_guid,
    address,
    zipcode,
    state,
    country
    from src_greenery__addresses
)



select * from renamed_recast