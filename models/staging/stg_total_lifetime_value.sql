--{{config(materialized="table")}}

WITH customer_lifetime_value AS (
    --select * from {{ref("stg_weekly_lifetime_value")}}
    select * from DEMO.acmeco.stg_weekly_lifetime_value
),
average_lifetime_value AS (
    SELECT
        AVG(average_lifetime_value_in_dollars) AS avg_lifetime_value
    FROM
        customer_lifetime_value
)
SELECT
    (SELECT avg_lifetime_value FROM average_lifetime_value) AS total_lifetime_value_for_all_customers