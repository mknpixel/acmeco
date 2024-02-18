--{{config(materialized="table")}}

WITH customer_lifetime_value AS (
    SELECT
        rc.id AS customer_id,
        DATE_TRUNC('week', ro.order_date) AS week_start_date,
        SUM(rp.amount) / 100.0 AS lifetime_value_in_dollars
    FROM
        raw_customers rc
    INNER JOIN
        raw_orders ro ON rc.id = ro.user_id
    LEFT JOIN
        raw_payments rp ON ro.id = rp.order_id
    GROUP BY
        rc.id, week_start_date
)
SELECT
    week_start_date,
    AVG(lifetime_value_in_dollars) AS average_lifetime_value_in_dollars
FROM
    customer_lifetime_value
GROUP BY
    week_start_date
ORDER BY
    week_start_date