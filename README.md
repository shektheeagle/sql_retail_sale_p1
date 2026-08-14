# **Project Overview**

**Project Title:** Retail Sales Analysis using SQL  
**Level:** Beginner  
**Database:** `sql_project`  
**Table:** `retail_sales_clean`

This project demonstrates SQL skills used to clean, explore and analyze retail sales data. The project includes data cleaning, exploratory data analysis (EDA), and solving business questions using SQL queries.

# **Objectives**

1. **Database Setup** — Create a retail sales database and table.
2. **Data Import** — Import retail sales data from CSV into MySQL.
3. **Data Cleaning** — Check missing values, duplicates, data types and invalid values.
4. **Data Exploration (EDA)** — Explore the dataset and understand important patterns.
5. **Business Analysis** — Answer practical retail business questions using SQL.

# **Dataset Columns**

- `transaction_id`
- `sale_date`
- `sale_time`
- `customer_id`
- `gender`
- `age`
- `category`
- `quantity`
- `price_per_unit`
- `cogs`
- `total_sale`

# **Data Cleaning Performed**

- Checked for **NULL / missing values**
- Checked for **duplicate transactions**
- Validated **data types**
- Changed `cogs` to `DECIMAL(10,2)` to preserve decimal values
- Checked for **invalid values** in age, quantity, price, COGS and total sales
- Checked **logical consistency** between quantity, price and total sale

# **Exploratory Data Analysis**

Performed analysis to understand:

- Total transactions
- Unique customers
- Available product categories
- Category-wise total sales
- Gender-wise sales
- Top 5 customers by total sales
- Average age of customers purchasing Beauty products

# **Business Questions Answered**

1. Retrieve all sales made on **2022-11-05**
2. Find Clothing transactions with quantity greater than 10 in **November 2022**
3. Calculate total sales for each category
4. Find the average age of customers purchasing from the Beauty category
5. Find transactions where total sale is greater than 1000
6. Find number of transactions by gender and category
7. Calculate average sales for each month
8. Find the **Top 5 customers** based on total sales
9. Find unique customers for each category
10. Create **Morning, Afternoon and Evening shifts** based on sale time and count orders in each shift

# **SQL Concepts Used**

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `COUNT()`
- `COUNT(DISTINCT)`
- `SUM()`
- `AVG()`
- `CASE`
- `MONTH()`
- `YEAR()`
- `LIMIT`
- `IS NULL`
- `<>`
- Aggregate functions

# **Tools**

**MySQL / MySQL Workbench**  
**Excel** — used as the original dataset/source

```sql
CREATE DATABASE SQL file 2;

CREATE TABLE retail_sales_clean
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset .

```sql
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
 
-- exploaration
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022**:
```sql
SELECT TRANSACTION_ID FROM RETAIL_SALES_CLEAN
 WHERE CATEGORY = "CLOTHING"
 AND QUANTITY >2
 AND MONTH(SALE_DATE) = "11"
AND YEAR(SALE_DATE) = "2022" ;


3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
 SELECT CATEGORY , SUM(TOTAL_SALE) AS TOTAL_SALES
 FROM RETAIL_SALES_CLEAN
 GROUP BY CATEGORY;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
 YEAR(SALE_DATE) AS YEAR,
 MONTH(SALE_DATE) AS MONTH,
 AVG(TOTAL_SALE) AS AVERGAGE_SALE
 FROM 
 RETAIL_SALES_CLEAN
 GROUP BY YEAR(SALE_DATE),MONTH(SALE_DATE)
 ORDER BY YEAR,MONTH DESC;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales.**:
```sql
SELECT 
    CUSTOMER_ID ,SUM(TOTAL_SALE) AS HIGHEST_TOTAL_SALES
    FROM 
    RETAIL_SALES_CLEAN
GROUP BY CUSTOMER_ID
LIMIT 5;

```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT CATEGORY , COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMERS
FROM RETAIL_SALES_CLEAN
GROUP BY CATEGORY ;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
SELECT
CASE
    WHEN SALE_TIME <= "12:00:00" THEN "MORNING"
    WHEN SALE_TIME >"12:00:00" AND SALE_TIME <= "17:00:00" THEN "AFTERNOON"
ELSE "EVENING"
END AS SHIFT,
COUNT(TRANSACTION_ID) AS NUMBER_OF_ORDERS
    FROM RETAIL_SALES_CLEAN
    GROUP BY SHIFT
```

## Findings

- **Data Quality:** The dataset was checked for NULL values, duplicate records, incorrect data types, invalid values, and logical inconsistencies.
- **Category Performance:** Category-wise sales analysis was performed to compare total sales across different product categories.
- **Gender Analysis:** Sales were analyzed across male and female customers.
- **Customer Insights:** The analysis identified the top 5 customers based on their total sales and unique customers across each category.
- **High-Value Transactions:** Transactions with total sales greater than 1000 were identified.
- **Shift Analysis:** Orders were classified into Morning, Afternoon, and Evening shifts based on sale time.
- **Monthly Analysis:** Average sales were calculated for each month to understand sales performance over time.

## Reports

- **Sales Summary:** Analysis of total transactions, total sales, category performance, and customer activity.
- **Category Analysis:** Comparison of sales performance across different product categories.
- **Customer Analysis:** Top 5 customers and unique customer counts for each category.
- **Time Analysis:** Monthly average sales and order distribution across different shifts.

## Conclusion

This project provided practical experience in using SQL for data cleaning, exploratory data analysis, and solving business-related questions. The analysis helped understand sales performance, customer behavior, category performance, and transaction patterns.

The project demonstrates the basic SQL skills required for data analysis, including filtering, aggregation, grouping, conditional logic, and working with dates and times.

## How to Use

1. **Clone the Repository:** Clone this project repository from GitHub.
2. **Set Up the Database:** Create the database and import the retail sales dataset into MySQL.
3. **Run the SQL Queries:** Execute the SQL queries provided in the project to perform data cleaning and analysis.
4. **Explore and Modify:** Modify the queries to answer additional business questions and explore the dataset further.

## Author - abhishek

This project is part of my data analytics portfolio and demonstrates my practical SQL skills in data cleaning, exploratory analysis, and business problem solving.


