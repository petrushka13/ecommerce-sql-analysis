SELECT
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.price) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'completed'
GROUP BY c.first_name, c.last_name
ORDER BY revenue DESC;
