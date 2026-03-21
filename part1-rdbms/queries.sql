Q1: List all customers from Mumbai along with their total order value
SELECT
  c.customer_id,
  c.customer_name,
  SUM(oi.quantity * oi.unit_price) AS total_order_value
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_order_value DESC;
Q2: Find the top 3 products by total quantity sold
SELECT
  p.product_id,
  p.product_name,
  SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;
 Q3: List all sales representatives and the number of unique customers they have handled
 s.sales_rep_id,
  s.sales_rep_name,
  COUNT(DISTINCT o.customer_id) AS unique_customers_handled
FROM sales_reps s
LEFT JOIN orders o ON o.sales_rep_id = s.sales_rep_id
GROUP BY s.sales_rep_id, s.sales_rep_name
ORDER BY unique_customers_handled DESC;
 Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
 o.order_id,
  SUM(oi.quantity * oi.unit_price) AS total_order_value
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id
HAVING SUM(oi.quantity * oi.unit_price) > 10000
ORDER BY total_order_value DESC;
Q5: Identify any products that have never been ordered
SELECT
  p.product_id,
  p.product_name
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL
ORDER BY p.product_id;
