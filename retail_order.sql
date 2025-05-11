USE online_test_db;
/*
SELECT * FROM df_orders_cleaned; 
--
DESCRIBE df_orders_cleaned;

ALTER TABLE df_orders_cleaned
MODIFY COLUMN order_id INT PRIMARY KEY,
MODIFY COLUMN order_date DATE,
MODIFY COLUMN ship_mode VARCHAR(50),
MODIFY COLUMN segment VARCHAR(50),
MODIFY COLUMN country VARCHAR(100),
MODIFY COLUMN city VARCHAR(100),
MODIFY COLUMN state VARCHAR(100),
MODIFY COLUMN postal_code VARCHAR(20),
MODIFY COLUMN region VARCHAR(50),
MODIFY COLUMN category VARCHAR(100),
MODIFY COLUMN sub_category VARCHAR(100),
MODIFY COLUMN product_id VARCHAR(50),
MODIFY COLUMN quantity INT,
MODIFY COLUMN discount DECIMAL(10,2),
MODIFY COLUMN sale_price DECIMAL(10,2),
MODIFY COLUMN profit DECIMAL(10,2);

DESCRIBE df_orders_cleaned;
*/

SELECT * FROM df_orders_cleaned; 

-- Find top 10 highest revenue generating products
SELECT product_id, SUM(sale_price) AS sales 
FROM df_orders_cleaned 
GROUP BY product_id 
ORDER BY sales DESC
LIMIT 10;

-- Find top 5 selling products in each region 
SELECT region, product_id, sales
FROM(
	SELECT
		region,
        product_id,
        SUM(sale_price) AS sales,
        RANK() OVER (PARTITION BY region ORDER BY SUM(sale_price) DESC) AS rank_order
     FROM df_orders_cleaned
     GROUP BY region, product_id
) ranked 
WHERE rank_order <= 5 
ORDER BY region, sales DESC;

-- Find month over month growth comparison for 2022 and 2023 sales eg: jan 2022 vs jan 2023

WITH cte AS(
SELECT YEAR(order_date) AS order_year, MONTH(order_date) AS order_month,
	SUM(sale_price) AS sales
FROM df_orders_cleaned
GROUP BY YEAR(order_date),MONTH(order_date)
	)
SELECT order_month,
	SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
FROM cte
GROUP BY order_month
ORDER BY order_month;

-- For each category which month had highest sales
WITH cte AS(
SELECT category, 
       DATE_FORMAT(order_date, '%Y-%m') AS order_year_month, 
       SUM(sale_price) AS sales 
FROM df_orders_cleaned
GROUP BY category, order_year_month
ORDER BY category, order_year_month
)
SELECT * FROM(
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY category ORDER BY sales DESC) AS rn
FROM cte
) a 
WHERE rn = 1;

-- Which sub category had highest growth by profit in 2023 compare to 2022
WITH cte AS(
SELECT sub_category, YEAR(order_date) AS order_year,
	SUM(sale_price) AS sales
FROM df_orders_cleaned
GROUP BY sub_category,YEAR(order_date)
	)
, cte2 AS (
SELECT sub_category,
	SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
FROM cte
GROUP BY sub_category
)
SELECT *
, (sales_2023 - sales_2022)* 100/ sales_2022 AS sales_growth_pct
FROM cte2
ORDER BY sales_growth_pct DESC
LIMIT 3;

