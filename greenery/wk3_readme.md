Question 1: What is our overall conversion rate?
Answer 1: 62.46% is Greenery's overall conversion rate, query below:

    select (sum(checkout) / count(distinct session_guid))*100 as conv_rate
    from dbt.dbt_ben_b.int_session_events_agg


Question 2: What is our conversion rate by product?
Answer 2: Query below:

    with product_conv_rate as (
    select product_guid, (sum(add_to_cart) / count(distinct session_guid))*100 as conv_rate
    from dbt.dbt_ben_b.int_user_product_session
    group by product_guid
    )

    select product_name, conv_rate
    from product_conv_rate
    left join dbt.dbt_ben_b.stg_greenery__products on product_conv_rate.product_guid = stg_greenery__products.product_guid

Per Project B group session, swapped from "checkout" to "add to cart", assumption that if a customer added to cart that they did checkout. Heidi and Kate brought up a good point that sometimes users abandon carts - but for the project this works!

