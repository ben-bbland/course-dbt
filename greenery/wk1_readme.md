Question 1: How many users do we have?

    Answer 1: 
        select count(distinct(user_guid))
        from dbt.dbt_ben_b.stg_greenery__users;

        Result: 130 unique users



Question 2: On average, how many orders do we receive per hour?

    Answer 2:
        with hourly_orders as (
            select count(order_guid), date_trunc('hour', created_at_utc) as order_hour_utc
            from dbt.dbt_ben_b.stg_greenery__orders
            group by order_hour_utc)
        
        select avg(count) from hourly_orders;

        Result: 7.52 orders per hour on average



Question 3: On average, how long does an order take from being placed to being delivered?

    Answer 3:
        with delivery as (
            select created_at_utc, delivered_at_utc, (delivered_at_utc - created_at_utc) as delivery_time
            from dbt.dbt_ben_b.stg_greenery__orders
            where delivered_at_utc IS NOT NULL)

        select avg(delivery_time) from delivery;

        Result: 3 days, 21 hours, 24 minutes, 11.8 seconds



Question 4: How many users have only made one purchase? Two purchases? Three+ purchases? Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

    Answer 4:
        with orders_per_customer as (
            select user_guid, count(dbt.dbt_ben_b.stg_greenery__orders.user_guid) as number_of_orders
            from dbt.dbt_ben_b.stg_greenery__orders
            group by dbt.dbt_ben_b.stg_greenery__orders.user_guid
            order by number_of_orders desc
        )

        select
            sum(case when number_of_orders = 1 then 1 else 0 end) as one_purchase,
            sum(case when number_of_orders = 2 then 1 else 0 end) as two_purchases,
            sum(case when number_of_orders >= 3 then 1 else 0 end) as three_plus_purchases
        from orders_per_customer;

        Result: 25 customers with 1 purchase, 28 customers with 2 purchases, 71 customers with 3+ purchases.


Question 5: On average, how many unique sessions do we have per hour?
   
    Answer 5: 
        with hourly_unique_sessions as (
                select count(distinct(session_guid)) as unique_sessions, date_trunc('hour', created_at_utc) as session_hour_utc
                from dbt.dbt_ben_b.stg_greenery__events
                group by session_hour_utc)
            
        select avg(unique_sessions) from hourly_unique_sessions;

        Result: The site has an average of 16.32 unique sessions per hour.