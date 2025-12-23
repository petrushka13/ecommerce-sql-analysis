# E-commerce SQL Analysis

This document describes my step-by-step analytical process using SQL.
The purpose of this project is to show how business questions can be answered
through structured queries, clear logic, and interpretation of results.

The analysis is based on a simplified e-commerce database built in PostgreSQL.
All data was loaded from CSV files and analyzed using SQL.

---

1. Total Revenue

Business Question
How much total revenue did the company generate?

SQL Query
```sql
SELECT
    SUM(quantity * price) AS total_revenue
FROM order_items;
Explanation
Each row in the order_items table represents a product sold within an order.
Revenue for each row is calculated as the product of quantity and price.
The SUM function aggregates revenue across all sales.

Result
Total revenue equals 2600.

Insight
This metric provides a high-level view of the overall business scale
and serves as a starting point for further analysis.

2. Revenue by Customer
Business Question
Which customers generate the most revenue?

SQL Query:

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

Explanation
Customers are joined with their orders using customer_id.
Orders are then joined with order items to calculate revenue.
Only completed orders are included to reflect realized revenue.
Revenue is aggregated per customer and sorted in descending order.

Result
John Doe generates the highest revenue, followed by Anna Smith and Ivan Ivanov.

Insight
Revenue is concentrated among a small number of customers,
which may indicate dependency on a limited customer base.

3. Average Order Value (AOV)
Business Question
What is the average value of a completed order?

SQL Query:

SELECT
    AVG(order_total) AS avg_order_value
FROM (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'completed'
    GROUP BY o.order_id
) sub;

Explanation

First, the total value of each completed order is calculated.
Then, the average value across all completed orders is computed.

Result
The average order value is approximately 650.

Insight
Increasing the average order value through upselling or product bundles
could significantly improve total revenue without increasing the number of customers.

4. Repeat Customers (Basic Retention Analysis)
Business Question
How many customers made more than one completed purchase?

SQL Query:

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
Explanation
The number of completed orders per customer is calculated.
Customers with more than one order are identified.
The percentage of repeat customers is then computed.

Result
The repeat customer rate is low.

Insight
Most customers make only a single purchase.
Improving customer retention represents a major opportunity for business growth.

Conclusion
This project demonstrates a structured, business-oriented approach to SQL analytics.
Each query is linked to a specific business question, and results are interpreted
within a practical business context.

The focus of the project is not only SQL syntax,
but also analytical thinking, data interpretation,

and clear communication of insights.
