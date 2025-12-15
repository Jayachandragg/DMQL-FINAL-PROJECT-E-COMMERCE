

-- QUERY 1(optimized) — Which sellers are responsible for the most canceled orders?


WITH canceled_orders AS (
    SELECT order_id
    FROM orders
    WHERE order_status = 'canceled'
)
SELECT 
    s.seller_id,
    COUNT(*) AS canceled_orders,
    total_orders.total_orders
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
JOIN canceled_orders co ON oi.order_id = co.order_id
JOIN (
    SELECT seller_id, COUNT(*) AS total_orders
    FROM order_items
    GROUP BY seller_id
) AS total_orders
ON total_orders.seller_id = s.seller_id
GROUP BY s.seller_id, total_orders.total_orders
ORDER BY canceled_orders DESC;



-- QUERY 2 — Product Category Revenue & Items Sold


SELECT 
    p.product_category_name,
    SUM(oi.price + oi.freight_value) AS total_revenue,
    COUNT(oi.order_item_id) AS total_items_sold
FROM products p
JOIN order_items oi 
    ON p.product_id = oi.product_id
GROUP BY 
    p.product_category_name
ORDER BY 
    total_revenue DESC;

--Query 3-Which customers placed the highest total order value, and how many orders did each of them make?
WITH customer_order_values AS (
    SELECT 
        o.customer_id,
        COUNT(o.order_id) AS total_orders,
        SUM(p.payment_value) AS total_amount_spent
    FROM orders o
    JOIN payments p 
        ON o.order_id = p.order_id
    WHERE o.order_status IN ('delivered', 'shipped')
    GROUP BY o.customer_id
)
SELECT 
    customer_id,
    total_orders,
    total_amount_spent
FROM customer_order_values
ORDER BY total_amount_spent DESC
LIMIT 10;

-- QUERY 4 —Which product categories have the highest average order price?
SELECT 
    p.product_category_name,
    AVG(oi.price) AS avg_product_price
FROM products p
JOIN order_items oi 
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY avg_product_price DESC;

--QUERY 5 —Which customers generate the highest total freight cost?

SELECT
    o.customer_id,
    SUM(oi.freight_value) AS total_freight_cost
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_freight_cost DESC
LIMIT 10;
