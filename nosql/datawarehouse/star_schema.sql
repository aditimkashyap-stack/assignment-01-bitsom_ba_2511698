-- Dimension: Date
CREATE TABLE dim_date (
  date_key INT PRIMARY KEY,          -- YYYYMMDD
  full_date DATE NOT NULL,
  year INT NOT NULL,
  month INT NOT NULL,
  month_name VARCHAR(15) NOT NULL
);-- Dimension: Store
CREATE TABLE dim_store (
  store_key INT PRIMARY KEY,
  store_name VARCHAR(100) NOT NULL,
  store_city VARCHAR(50) NOT NULL
);-- Dimension: Product
CREATE TABLE dim_product (
  product_key INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL
);-- Fact: Sales
CREATE TABLE fact_sales (
  transaction_id VARCHAR(20) PRIMARY KEY,
  date_key INT NOT NULL,
  store_key INT NOT NULL,
  product_key INT NOT NULL,
  units_sold INT NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  revenue DECIMAL(14,2) NOT NULL,
  customer_id VARCHAR(20),
  FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
  FOREIGN KEY (store_key) REFERENCES dim_store(store_key),
  FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

-- dim_date: include all dates used in fact rows
INSERT INTO dim_date VALUES
(20230829,'2023-08-29',2023,8,'August'),
(20231212,'2023-12-12',2023,12,'December'),
(20230205,'2023-02-05',2023,2,'February'),
(20230220,'2023-02-20',2023,2,'February'),
(20230115,'2023-01-15',2023,1,'January'),
(20230809,'2023-08-09',2023,8,'August'),
(20231026,'2023-10-26',2023,10,'October'),
(20231020,'2023-10-20',2023,10,'October'),
(20230428,'2023-04-28',2023,4,'April'),
(20230124,'2023-01-24',2023,1,'January');-- dim_store
INSERT INTO dim_store VALUES
(1,'Chennai Anna','Chennai'),
(2,'Delhi South','Delhi'),
(3,'Bangalore MG','Bangalore'),
(4,'Mumbai Central','Mumbai'),
(5,'Pune FC Road','Pune');-- dim_product (categories standardized)
INSERT INTO dim_product VALUES
(1,'Speaker','Electronics'),
(2,'Tablet','Electronics'),
(3,'Phone','Electronics'),
(4,'Smartwatch','Electronics'),
(5,'Atta 10kg','Grocery'),
(6,'Jeans','Clothing'),
(7,'Milk 1L','Grocery'),
(8,'Headphones','Electronics');-- fact_sales (revenue = units_sold * unit_price)
INSERT INTO fact_sales VALUES
('TXN5000',20230829,1,1,3,49262.78,147788.34,'CUST045'),
('TXN5001',20231212,1,2,11,23226.12,255487.32,'CUST021'),
('TXN5002',20230205,1,3,20,48703.39,974067.80,'CUST019'),
('TXN5003',20230220,2,2,14,23226.12,325165.68,'CUST007'),
('TXN5004',20230115,1,4,10,58851.01,588510.10,'CUST004'),
('TXN5005',20230809,3,5,12,52464.00,629568.00,'CUST027'),
('TXN5007',20231026,5,6,16,2317.47,37079.52,'CUST041'),
('TXN5011',20231020,4,6,13,2317.47,30127.11,'CUST045'),
('TXN5013',20230428,4,7,10,43374.39,433743.90,'CUST015'),
('TXN5023',20230124,1,8,5,39854.96,199274.80,'CUST032');
