{{
    config(
        MATERIALIZED = 'table'
    )
}}

with session_length as(
    SELECT
        session_guid,
        min(created_at_utc) as first_event,
        max(created_at_utc) as last_event
    FROM {{ ref('stg_greenery__events') }}
    group by 1
)

SELECT  
    int_session_events_basic_agg.session_guid,
    int_session_events_basic_agg.user_guid,
    stg_greenery__users.first_name,
    stg_greenery__users.last_name,
    stg_greenery__users.email,
    int_session_events_basic_agg.page_view,
    int_session_events_basic_agg.add_to_cart,
    int_session_events_basic_agg.checkout,
    int_session_events_basic_agg.package_shipped,
    session_length.first_event as first_session_event,
    session_length.last_event as last_session_event,
    (date_part('day', session_length.last_event::timestamp - session_length.first_event::timestamp)*24*60 +
        date_part('hour', session_length.last_event::timestamp - session_length.first_event::timestamp)*60 +
        date_part('minute', session_length.last_event::timestamp - session_length.first_event::timestamp))
    as session_length_minutes

FROM {{ ref('int_session_events_basic_agg') }}
LEFT JOIN {{ ref('stg_greenery__users') }}
    on int_session_events_basic_agg.user_guid = stg_greenery__users.user_guid
LEFT JOIN session_length
    on int_session_events_basic_agg.session_guid = session_length.session_guid