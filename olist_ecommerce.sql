-- =========================================================================
-- PROJECT TITLE: Olist E-Commerce Data Analysis
-- GITHUB: https://github.com/RinaTheSiamese
-- DATE: April 15, 2026
--
-- DESCRIPTION: 
-- This script sets up the Olist database, loads the raw CSV files, and 
-- pulls key business metrics. To simulate a real-world stakeholder 
-- environment, I used Gemini to help generate realistic business questions.
--
-- The final output of these queries is designed to be exported and used 
-- to build a visualization dashboard in PowerBI and a presentation file.
-- =========================================================================

CREATE DATABASE olist_ecommerce;
USE olist_ecommerce;

-- ===============================================================================
-- SECTION 1: Create Tables
-- Desc: 	  Initializes the database schema by creating 9 tables corresponding 
--       	  to the Olist E-commerce dataset. Data types are mapped to handle 
--       	  strings, integers, floats, and datetime values appropriately.
-- ===============================================================================

-- 1. Customers Table
CREATE TABLE olist_customers (
    customer_id VARCHAR(255),
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(255),
    customer_state VARCHAR(255)
);

-- 2. Geolocation Table
CREATE TABLE olist_geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(255)
);

-- 3. Order Items Table
CREATE TABLE olist_order_items (
	order_id VARCHAR(255),
    order_item_id INT,
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    shipping_limit_date DATETIME,
    price FLOAT,
    freight_value FLOAT
);

-- 4. Order Payments Table
CREATE TABLE olist_order_payments (
    order_id VARCHAR(255),
    payment_sequential INT,
    payment_type VARCHAR(255),
    payment_installments INT,
    payment_value FLOAT
);

-- 5. Order Reviews Table
CREATE TABLE olist_order_reviews (
    review_id VARCHAR(255),
    order_id VARCHAR(255),
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

-- 6. Orders Table
CREATE TABLE olist_orders (
    order_id VARCHAR(255),
    customer_id VARCHAR(255),
    order_status VARCHAR(255),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

-- 7. Products Table
CREATE TABLE olist_products (
    product_id VARCHAR(255),
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- 8. Sellers Table
CREATE TABLE olist_sellers (
    seller_id VARCHAR(255),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(255),
    seller_state VARCHAR(255)
);

-- 9. Category Name Translation Table
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(255),
    product_category_name_english VARCHAR(255)
);

-- ===============================================================================
-- SECTION 2: Load Data
-- Desc: 	  Populates the tables using local CSV files.
-- Note: 	  Please update the local file paths to your files' local path!
-- Data: 	  https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
-- ===============================================================================

-- First, ensure local infile is enabled for this session
SET GLOBAL local_infile = 1;

-- 1. Load Customers
LOAD DATA LOCAL INFILE 'C:/path/to/your/local/directory/olist_customers_dataset.csv'
INTO TABLE olist_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 2. Load Geolocation
LOAD DATA LOCAL INFILE 'C:/path/to/your/local/directory/olist_geolocation_dataset.csv'
INTO TABLE olist_geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 3. Load Order Items
LOAD DATA LOCAL INFILE 'C:/path/to/your/local/directory/olist_order_items_dataset.csv'
INTO TABLE olist_order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 4. Load Order Payments
LOAD DATA LOCAL INFILE 'C:/path/to/your/local/directory/olist_order_payments_dataset.csv'
INTO TABLE olist_order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 5. Load Order Reviews
LOAD DATA LOCAL INFILE 'C:/path/to/your/local/directory/olist_order_reviews_dataset.csv'
INTO TABLE olist_order_reviews
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
ESCAPED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 6. Load Orders
LOAD DATA LOCAL INFILE 'C:/path/to/your/local/directory/olist_orders_dataset.csv'
INTO TABLE olist_orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(order_id, customer_id, order_status, order_purchase_timestamp, @v_approved, @v_carrier, @v_customer, order_estimated_delivery_date)
SET 
order_approved_at = NULLIF(@v_approved, ''),
order_delivered_carrier_date = NULLIF(@v_carrier, ''),
order_delivered_customer_date = NULLIF(@v_customer, '');

-- 7. Load Products
LOAD DATA LOCAL INFILE 'C:/path/to/your/local/directory/olist_products_dataset.csv'
INTO TABLE olist_products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(product_id, @v_cat, @v_name_len, @v_desc_len, @v_photos, @v_weight, @v_length, @v_height, @v_width)
SET
product_category_name = NULLIF(@v_cat, ''),
product_name_length = NULLIF(@v_name_len, ''),
product_description_length = NULLIF(@v_desc_len, ''),
product_photos_qty = NULLIF(@v_photos, ''),
product_weight_g = NULLIF(@v_weight, ''),
product_length_cm = NULLIF(@v_length, ''),
product_height_cm = NULLIF(@v_height, ''),
product_width_cm = NULLIF(@v_width, '');

-- 8. Load Sellers
LOAD DATA LOCAL INFILE 'C:/path/to/your/local/directory/olist_sellers_dataset.csv'
INTO TABLE olist_sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 9. Load Category Translation
LOAD DATA LOCAL INFILE 'C:/path/to/your/local/directory/product_category_name_translation.csv'
INTO TABLE product_category_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ===============================================================================
-- SECTION 3: Extract Revenue & Sales Trends
-- Desc: 	  Queries analyzing the top-level financial metrics and purchasing 
--       	  behavior over time.
-- ===============================================================================

-- Q1.1: What is the total (gross) revenue generated by Olist over time?
-- Note: Revenue is calculated as GMV (Gross Merchandise Value) including freight.
-- 		 Kept at the 'date' grain so it can be dynamically filtered further in PowerBI.
SELECT 
	DATE(order_purchase_timestamp) AS revenue_during,
	ROUND(SUM(payment_value), 2) AS total_revenue
FROM olist_order_payments
INNER JOIN olist_orders
	ON olist_order_payments.order_id = olist_orders.order_id
GROUP BY revenue_during
ORDER BY revenue_during DESC;

-- Q1.2: What are the top 3 busiest days of the week for purchasing?
-- Note: LIMIT can be removed to compare all 7 days of the week in PowerBI.
SELECT 
	DAYNAME(order_purchase_timestamp) AS purchased_when,
	COUNT(DATE(order_purchase_timestamp)) AS purchase_count	   
FROM olist_orders
GROUP BY DAYNAME(order_purchase_timestamp)
ORDER BY purchase_count DESC
LIMIT 3;

-- ===============================================================================
-- SECTION 4: Extract Product Performance
-- Desc: Queries exploring the most popular items and highest value categories.
-- ===============================================================================

-- Q2.1: What are the Top 10 most popular product categories by total sales volume?
SELECT 
	COUNT(olist_order_items.product_id) AS sales_volume,
	REPLACE(product_category_name_english, '_', ' ') AS product_category
FROM olist_products
INNER JOIN olist_order_items
	ON olist_products.product_id = olist_order_items.product_id
INNER JOIN product_category_name_translation
	ON olist_products.product_category_name = product_category_name_translation.product_category_name
GROUP BY product_category_name_english
ORDER BY sales_volume DESC
LIMIT 10;

-- Q2.2: Which product categories generate the highest average revenue per order?
-- Note: Calculated the true Average Order Value (AOV) by dividing total category 
-- 		 revenue by the count of distinct orders to account for multi-item orders.
SELECT
	ROUND(SUM(price + freight_value) / COUNT(DISTINCT order_id), 2) AS avg_order_value, 
	REPLACE(product_category_name_english, '_', ' ') AS product_category
FROM olist_order_items
INNER JOIN olist_products
	ON olist_order_items.product_id = olist_products.product_id
INNER JOIN product_category_name_translation
	ON olist_products.product_category_name = product_category_name_translation.product_category_name
GROUP BY product_category_name_english
ORDER BY avg_order_value DESC;

-- ===============================================================================
-- SECTION 5: Extract Customer & Seller Geography
-- Desc: Queries identifying supply and demand concentration across Brazil.
-- ===============================================================================

-- Q3.1: Which 5 Brazilian states have the highest number of customers?
SELECT 
	customer_state,
	COUNT(customer_id) AS customer_amount
FROM olist_customers
GROUP BY customer_state
ORDER BY customer_amount DESC
LIMIT 5;

-- Q3.2: Is there a major discrepancy between where sellers and buyers are located?
-- Note: The short answer is No. Both supply (sellers) and demand (buyers) are heavily 
-- 		 concentrated in the Southeastern states (like SP, RJ, and MG). This query extracts 
-- 		 the seller distribution so it can be compared against the customer distribution. 
-- 		 The final comparison will be mapped and visualized side-by-side in PowerBI / PPT.
SELECT seller_state,
	COUNT(seller_id) AS seller_amount
FROM olist_sellers
GROUP BY seller_state
ORDER BY seller_amount DESC
LIMIT 5;

-- ===============================================================================
-- SECTION 6: Extract Logistics & Delivery
-- Desc: Queries analyzing delivery performance and fulfillment efficiency.
-- ===============================================================================

-- Q4.1 What is the average delivery time (in days) from the moment an order is purchased
-- 		to the moment it is delivered to the customer?
SELECT
	ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 2) as average_delivery_days
FROM olist_orders
WHERE order_status = "delivered"
	AND order_delivered_customer_date IS NOT NULL;

-- Q4.2: What percentage of delivered orders arrived after their estimated delivery date?
SELECT 
	ROUND(COUNT(order_id)
		/ (SELECT COUNT(order_id)
		   FROM olist_orders
		   WHERE order_status = "delivered")
        * 100, 2) AS delivered_after_estimate
FROM olist_orders
WHERE order_status = "delivered"
	AND order_delivered_customer_date > order_estimated_delivery_date;

-- =========================================================================
-- SECTION 7: Create PowerBI Views
-- Desc: Creating virtual tables (Views) for the most critical metrics. 
--       These views remove the 'LIMIT' constraints so that PowerBI has access 
--       to the full dataset for dynamic filtering and interactive dashboards.
-- =========================================================================

-- View 1: Revenue Over Time
CREATE OR REPLACE VIEW vw_revenue_over_time AS
SELECT 
	DATE(order_purchase_timestamp) AS revenue_during,
    ROUND(SUM(payment_value), 2) AS total_revenue				
FROM olist_order_payments
INNER JOIN olist_orders
    ON olist_order_payments.order_id = olist_orders.order_id
GROUP BY revenue_during;

-- View 2: Purchases by Day of Week
CREATE OR REPLACE VIEW vw_purchases_by_day AS
SELECT 
    DAYNAME(order_purchase_timestamp) AS purchased_when,
    COUNT(DATE(order_purchase_timestamp)) AS purchase_count	   
FROM olist_orders
GROUP BY DAYNAME(order_purchase_timestamp);

-- View 3: Sales Volume by Category
CREATE OR REPLACE VIEW vw_category_sales_volume AS
SELECT 
    COUNT(olist_order_items.product_id) AS sales_volume,
    REPLACE(product_category_name_english, '_', ' ') AS product_category
FROM olist_products
INNER JOIN olist_order_items
    ON olist_products.product_id = olist_order_items.product_id
INNER JOIN product_category_name_translation
    ON olist_products.product_category_name = product_category_name_translation.product_category_name
GROUP BY product_category_name_english;

-- View 4: Average Order Value by Category
CREATE OR REPLACE VIEW vw_category_aov AS
SELECT 
    ROUND(SUM(price + freight_value) / COUNT(DISTINCT order_id), 2) AS avg_order_value,					
    REPLACE(product_category_name_english, '_', ' ') AS product_category
FROM olist_order_items
INNER JOIN olist_products
    ON olist_order_items.product_id = olist_products.product_id
INNER JOIN product_category_name_translation
    ON olist_products.product_category_name = product_category_name_translation.product_category_name
GROUP BY product_category_name_english;

-- View 5: Customer Distribution by State
CREATE OR REPLACE VIEW vw_customer_geography AS
SELECT 
    customer_state,
    COUNT(customer_id) AS customer_amount
FROM olist_customers
GROUP BY customer_state;

-- View 6: Seller Distribution by State
CREATE OR REPLACE VIEW vw_seller_geography AS
SELECT 
    seller_state,
    COUNT(seller_id) AS seller_amount
FROM olist_sellers
GROUP BY seller_state;