{{
  config(
    MATERIALIZED = 'table'
  )
}}

with products as (

    select
      product_guid,
      product_name,
      product_price,
      product_inventory

    from {{ ref('stg_greenery__products') }}

)

select * from products