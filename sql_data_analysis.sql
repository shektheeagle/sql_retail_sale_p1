create database sql_project;
use sql_project;

create table retail_shop_data
(transactions_id	int PRIMARY KEY,
sale_date DATE,	
sale_time TIME,
customer_id	INT,
gender	VARCHAR (10),
age	INT,
category varchar (15),	
quantity int,	
price_per_unit	float,
cogs float,
total_sale float);


select * from retail_sale_data
limit 10;

-- data cleaning

select count(*) from retail_sale_data;
SELECT COUNT(*) AS total_rows,
       COUNT(transaction_id) AS transaction_ids
FROM retail_sale_data;
SELECT COUNT(DISTINCT transaction_id) AS unique_transactions
FROM retail_sale_data;

SELECT
    COUNT(*) AS total_rows,
    COUNT(sale_date) AS sale_date_filled,
    COUNT(sale_time) AS sale_time_filled,
    COUNT(customer_id) AS customer_id_filled,
    COUNT(gender) AS gender_filled,
    COUNT(age) AS age_filled,
    COUNT(category) AS category_filled,
    COUNT(quantity) AS quantity_filled,
    COUNT(price_per_unit) AS price_filled,
    COUNT(cogs) AS cogs_filled,
    COUNT(total_sale) AS sales_filled
FROM retail_sale_data;

SELECT 
    MIN(transaction_id) AS first_id,
    MAX(transaction_id) AS last_id,
    COUNT(*) AS total_rows
FROM retail_sale_data;


CREATE TABLE retail_sales_clean AS
SELECT *
FROM retail_sale_data;


select transaction_id , count(*) as duplicate_count
from retail_sales_clean 
group by transaction_id
having count(*) > 1;


DESCRIBE retail_sales_clean;

alter table retail_sales_clean
modify cogs decimal(10,2);
alter table retail_sales_clean
modify PRICE_PER_UNIT decimal(10,2);
alter table retail_sales_clean
modify TOTAL_SALE decimal(10,2);


SELECT * FROM RETAIL_SALES_CLEAN
WHERE AGE < 0 OR  AGE > 100
OR QUANTITY <=0
OR  PRICE_PER_UNIT <0
OR COGS < 0
OR TOTAL_SALE< 0;

SELECT * FROM RETAIL_SALES_CLEAN
WHERE TOTAL_SALE <> PRICE_PER_UNIT * QUANTITY;



-- DATA CLEANNNG DONE
 -- NOW DATA EXPLORATION
 
 
 SELECT CATEGORY ,SUM(TOTAL_SALE) AS TOTAL_SALES
 FROM RETAIL_SALES_CLEAN
 GROUP BY CATEGORY
 ORDER BY TOTAL_SALES DESC;
 
  SELECT GENDER ,SUM(TOTAL_SALE) AS TOTAL_SALES
 FROM RETAIL_SALES_CLEAN
 GROUP BY GENDER
 ORDER BY TOTAL_SALES DESC;
 
 
 SELECT
    CASE
        WHEN age < 25 THEN '18-24'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        WHEN age < 55 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    SUM(total_sale) AS total_sales
FROM retail_sales_clean
WHERE age IS NOT NULL
GROUP BY age_group
ORDER BY total_sales DESC;


SELECT CUSTOMER_ID ,SUM(TOTAL_SALE) AS TOTAL_SALES
 FROM RETAIL_SALES_CLEAN
 GROUP BY CUSTOMER_ID
 ORDER BY TOTAL_SALES DESC
 LIMIT 5;
 




-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2
-- in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- 1
SELECT * FROM RETAIL_SALES_CLEAN
WHERE SALE_DATE = "2022-11-05";

-- 2
 SELECT TRANSACTION_ID FROM RETAIL_SALES_CLEAN
 WHERE CATEGORY = "CLOTHING"
 AND QUANTITY >2
 AND MONTH(SALE_DATE) = "11"
AND YEAR(SALE_DATE) = "2022" ;

 -- 3
 SELECT CATEGORY , SUM(TOTAL_SALE) AS TOTAL_SALES
 FROM RETAIL_SALES_CLEAN
 GROUP BY CATEGORY;
 
 -- 4
 SELECT round(AVG(AGE),2) FROM RETAIL_SALES_CLEAN
 WHERE CATEGORY = "BEAUTY";

 
 -- 5
 SELECT TRANSACTION_ID , TOTAL_SALE FROM RETAIL_SALES_CLEAN
 WHERE TOTAL_SALE > 1000;
 
 -- 6 
 SELECT GENDER , SUM(TRANSACTION_ID)
 FROM RETAIL_SALES_CLEAN 
 GROUP BY GENDER
 order by 1;
 -- 7
 SELECT 
 YEAR(SALE_DATE) AS YEAR,
 MONTH(SALE_DATE) AS MONTH,
 AVG(TOTAL_SALE) AS AVERGAGE_SALE
 FROM RETAIL_SALES_CLEAN
 GROUP BY YEAR(SALE_DATE),MONTH(SALE_DATE)
 ORDER BY YEAR,MONTH DESC;
 
  
 -- 8-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT CUSTOMER_ID ,SUM(TOTAL_SALE) AS HIGHEST_TOTAL_SALES
FROM RETAIL_SALES_CLEAN
GROUP BY CUSTOMER_ID
LIMIT 5;
 
 -- 9 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT CATEGORY , COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMERS
FROM RETAIL_SALES_CLEAN
GROUP BY CATEGORY ;

-- 10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, 
-- Evening >17)
SELECT
CASE
WHEN SALE_TIME <= "12:00:00" THEN "MORNING"
WHEN SALE_TIME >"12:00:00" AND SALE_TIME <= "17:00:00" THEN "AFTERNOON"
ELSE "EVENING"
END AS SHIFT,
COUNT(TRANSACTION_ID) AS NUMBER_OF_ORDERS
FROM RETAIL_SALES_CLEAN
GROUP BY SHIFT

-- DATA ANALYSE COMPLETE
