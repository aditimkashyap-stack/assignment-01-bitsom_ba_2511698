## Anomaly Analysis
### Insert Anomaly
In `orders_flat.csv`, customer/product/sales-rep information only exists inside order rows.
For example, the row with `order_id = ORD1027` contains customer fields (`customer_id`, `customer_name`, `customer_email`, `customer_city`),
product fields (`product_id`, `product_name`, `category`, `unit_price`), and sales rep fields (`sales_rep_id`, `sales_rep_name`, `sales_rep_email`, `office_address`) all in the same row.
Because of this, you cannot insert a new customer or product unless you also insert a complete order row (with `order_id`, `order_date`, `quantity`, etc.).
That is an insert anomaly.
### Update Anomaly
The same sales rep `SR01 (Deepak Joshi)` appears in multiple rows, but the office address is inconsistent:- `ORD1114` shows: "Mumbai HQ, Nariman Point, Mumbai - 400021"- `ORD1180` shows: "Mumbai HQ, Nariman Pt, Mumbai - 400021"
If the address needs correction, it must be updated in every row where SR01 appears.
If one row is missed, the data becomes inconsistent. This is an update anomaly.
### Delete Anomaly
Product information is stored inside order rows. For example, product `P008 (Webcam)` appears in an order row like `ORD1185`.
If that order row is deleted and there are no other rows containing `P008`, the database loses the only record that the product exists.
This is a delete anomaly.
