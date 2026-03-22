
-- Q1: Total sales revenue by product category for each month
SELECT
  d.year,
  d.month,
  d.month_name,
  p.category,
  SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
JOIN dim_product p ON p.product_key = f.product_key
GROUP BY d.year, d.month, d.month_name, p.category
ORDER BY d.year, d.month, p.category;-- Q2: Top 2 performing stores by total revenue
SELECT
  s.store_name,
  s.store_city,
  SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_store s ON s.store_key = f.store_key
GROUP BY s.store_name, s.store_city
ORDER BY total_revenue DESC
LIMIT 2;-- Q3: Month-over-month sales trend across all stores
WITH monthly AS (
  SELECT
    d.year,
    d.month,
    (d.year * 100 + d.month) AS year_month,
    SUM(f.revenue) AS total_revenue
)
  FROM fact_sales f
  JOIN dim_date d ON d.date_key = f.date_key
  GROUP BY d.year, d.month
SELECT
  year,
  month,
  total_revenue,
  LAG(total_revenue) OVER (ORDER BY year_month) AS prev_month_revenue,
  (total_revenue - LAG(total_revenue) OVER (ORDER BY year_month)) AS mom_change
FROM monthly
ORDER BY year, month;
