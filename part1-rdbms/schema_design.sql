
-- Customers
CREATE TABLE customers (
  customer_id VARCHAR(10) PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  customer_email VARCHAR(150) NOT NULL UNIQUE,
  customer_city VARCHAR(50) NOT NULL
);-- Sales Representatives
CREATE TABLE sales_reps (
  sales_rep_id VARCHAR(10) PRIMARY KEY,
  sales_rep_name VARCHAR(100) NOT NULL,
  sales_rep_email VARCHAR(150) NOT NULL UNIQUE,
  office_address VARCHAR(255) NOT NULL
);-- Products
CREATE TABLE products (
  product_id VARCHAR(10) PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL
);
-- Orders (header)
CREATE TABLE orders (
  order_id VARCHAR(10) PRIMARY KEY,
  customer_id VARCHAR(10) NOT NULL,
  sales_rep_id VARCHAR(10) NOT NULL,
  order_date DATE NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);-- Order Items (line items)
CREATE TABLE order_items (
  order_id VARCHAR(10) NOT NULL,
  product_id VARCHAR(10) NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Customers (6 rows)
INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001','Rohan Mehta','rohan@gmail.com','Mumbai'),
('C002','Priya Sharma','priya@gmail.com','Delhi'),
('C003','Amit Verma','amit@gmail.com','Bangalore'),
('C004','Sneha Iyer','sneha@gmail.com','Chennai'),
('C005','Vikram Singh','vikram@gmail.com','Mumbai'),
('C006','Neha Gupta','neha@gmail.com','Delhi');-- Sales reps (5 rows: 3 real + 2 extra)
INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01','Deepak Joshi','deepak@corp.com','Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02','Anita Desai','anita@corp.com','Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03','Ravi Kumar','ravi@corp.com','South Zone, MG Road, Bangalore - 560001'),
('SR04','Meera Nair','meera@corp.com','Chennai Hub, T. Nagar, Chennai - 600017'),
('SR05','Kunal Shah','kunal@corp.com','Pune Branch, Shivaji Nagar, Pune - 411005');-- Products (8 rows: real products from file)
INSERT INTO products (product_id, product_name, category) VALUES
('P001','Laptop','Electronics'),
('P002','Mouse','Electronics'),
('P003','Desk Chair','Furniture'),
('P004','Notebook','Stationery'),
('P005','Headphones','Electronics'),
('P006','Standing Desk','Furniture'),
('P007','Pen Set','Stationery'),
('P008','Webcam','Electronics');-- Orders (5 real order_ids/dates)
INSERT INTO orders (order_id, customer_id, sales_rep_id, order_date) VALUES
('ORD1027','C002','SR02','2023-11-02'),
('ORD1114','C001','SR01','2023-08-06'),
('ORD1002','C002','SR02','2023-01-17'),
('ORD1075','C005','SR03','2023-04-18'),
('ORD1076','C004','SR03','2023-05-16');-- Order Items (from the same orders above)
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
('ORD1027','P004',4,120),
('ORD1114','P007',2,250),
('ORD1002','P005',1,3200),
('ORD1075','P003',3,8500),
('ORD1076','P006',5,22000);
