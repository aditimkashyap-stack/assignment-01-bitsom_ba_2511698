
-- Q1: List all customers along with the total number of orders they have placed
SELECT
    c.customer_id,
    c.name                          AS customer_name,
    COUNT(o.order_id)               AS total_orders
FROM read_csv_auto('customers.csv')    AS c
LEFT JOIN read_json_auto('orders.json') AS o
       ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;
 
 
-- Q2: Find the top 3 customers by total order value
SELECT
    c.customer_id,
    c.name                              AS customer_name,
    ROUND(SUM(o.total_amount), 2)       AS total_order_value
FROM read_csv_auto('customers.csv')        AS c
JOIN read_json_auto('orders.json')         AS o
  ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_order_value DESC
LIMIT 3;
 
 
-- Q3: List all products purchased by customers from Bangalore
SELECT DISTINCT
    p.product_id,
    p.product_name,
    p.category
FROM read_csv_auto('customers.csv')        AS c
JOIN read_json_auto('orders.json')         AS o
  ON c.customer_id = o.customer_id
-- orders.json contains a line_items array; unnest it to get per-product rows
JOIN (
    SELECT
        oi.order_id,
        item.product_id,
        item.quantity
    FROM read_json_auto('orders.json')      AS oi,
         UNNEST(oi.line_items)              AS t(item)
)                                           AS li
  ON o.order_id = li.order_id
JOIN read_parquet('products.parquet')       AS p
  ON li.product_id = p.product_id
WHERE LOWER(c.city) = 'bangalore'
ORDER BY p.product_name;
 
 
-- Q4: Join all three files to show: customer name, order date,
--     product name, and quantity
SELECT
    c.name                              AS customer_name,
    CAST(o.order_date AS DATE)          AS order_date,
    p.product_name,
    li.quantity
FROM read_csv_auto('customers.csv')        AS c
JOIN read_json_auto('orders.json')         AS o
  ON c.customer_id = o.customer_id
JOIN (
    SELECT
        oi.order_id,
        item.product_id,
        item.quantity
    FROM read_json_auto('orders.json')      AS oi,
         UNNEST(oi.line_items)              AS t(item)
)                                           AS li
  ON o.order_id = li.order_id
JOIN read_parquet('products.parquet')       AS p
  ON li.product_id = p.product_id
ORDER BY o.order_date, c.name, p.product_name;
 
