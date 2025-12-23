SELECT
    ROUND(
        COUNT(*) FILTER (WHERE order_count > 1) * 100.0 / COUNT(*),
        2
    ) AS repeat_customer_rate
FROM (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    WHERE order_status = 'completed'
    GROUP BY customer_id
) t;
