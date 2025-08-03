-- DATABASE CREATION SCRIPT
CREATE DATABASE IF NOT EXISTS retail_sales_db;

-- USE THE DATABASE
USE retail_sales_db;

-- TABLE CREATION SCRIPT
CREATE TABLE IF NOT EXISTS sales (
    TransactionID INT PRIMARY KEY,
    OrderDate TEXT,
    CustomerID TEXT,
    Gender TEXT,
    Age INT,
    ProductCategory TEXT,
    Quantity INT,
    PricePerUnit INT,
    TotalAmount INT
);

-- INDEX CREATION SCRIPT
CREATE INDEX idx_orderdate ON retail_sales_db.sales(OrderDate(10));
CREATE INDEX idx_customerid ON retail_sales_db.sales(CustomerID(10));
CREATE INDEX idx_productcategory ON retail_sales_db.sales(ProductCategory(100));



-- EXPLORE ALL OBJECTS IN THE DATABASE
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- EXPLORE ALL COLUMNS IN THE DATABASE
SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'sales';


-- DATA CLEANING SCRIPT

--CHECK FOR NULL VALUES IN EACH COLUMN
SELECT COUNT(*) AS Null_TransactionID FROM retail_sales_db.sales WHERE TransactionID IS NULL;

SELECT COUNT(*) AS Null_OrderDate FROM retail_sales_db.sales WHERE OrderDate IS NULL;

SELECT COUNT(*) AS Null_CustomerID FROM retail_sales_db.sales WHERE CustomerID IS NULL;

SELECT COUNT(*) AS Null_ProductCategory FROM retail_sales_db.sales WHERE ProductCategory IS NULL;

SELECT COUNT(*) AS Null_Quantity FROM retail_sales_db.sales WHERE Quantity IS NULL;

SELECT COUNT(*) AS Null_PricePerUnit FROM retail_sales_db.sales WHERE PricePerUnit IS NULL;

SELECT COUNT(*) AS Null_TotalAmount FROM retail_sales_db.sales WHERE TotalAmount IS NULL;

-- CHECK FOR INVALID DATA 
SELECT * FROM retail_sales_db.sales
WHERE Quantity <= 0 OR PricePerUnit <= 0 OR TotalAmount <= 0;

-- CHECK FOR DUPLICATE  TRANSACTIONID RECORDS
SELECT TransactionID, COUNT(*) AS Count FROM retail_sales_db.sales
GROUP BY TransactionID
HAVING COUNT(*) > 1;


--  DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERD 
-- MY ANALYSIS SCRIPT

-- 1)Write a query to calculate the total sales amount for each product category.

SELECT 
	productCategory,
    SUM(TotalAmount) AS Total_Amount
FROM retail_sales_db.sales
GROUP BY productCategory
ORDER BY Total_Amount ASC;


-- 2)Write a query to find the average amount spent by customers aged between 18 and 25.

SELECT
    AVG(TotalAmount) AS Avg_Amount
FROM retail_sales_db.sales
WHERE AGE BETWEEN 18 AND 25;

-- 3)Write a query to rank product categories based on total revenue and identify the one with the highest revenue.

SELECT
   productCategory,
   SUM(TotalAmount) AS Total_Amount,
   DENSE_RANK() OVER(ORDER BY SUM(TotalAmount) DESC) AS Ranking
FROM retail_sales_db.sales
GROUP BY productCategory;

-- 4)Write a query to calculate the average age of customers for each product category.

SELECT
   productCategory,
   ROUND(AVG(age),2) AS Avg_Age
FROM retail_sales_db.sales
GROUP BY productCategory;

-- 5)Write a query to find the average sales amount for each month and identify the best-performing month.

SELECT
	Year,
    Month,
    Avg_Amount
FROM (
       SELECT
          EXTRACT(YEAR FROM OrderDate) AS Year,
          EXTRACT(MONTH FROM OrderDate) AS Month,
          AVG(TotalAmount) AS Avg_Amount,
          RANK() OVER( ORDER BY AVG(TotalAmount)) AS Ranking
	   FROM retail_sales_db.sales
       GROUP BY EXTRACT(YEAR FROM OrderDate),EXTRACT(MONTH FROM OrderDate)
	 ) AS T1
WHERE Ranking=1;

-- 6)Write a query to identify the top 5 customers based on total amount spent.

SELECT
    CustomerID,
    SUM(TotalAmount) AS Total_Amount
FROM retail_sales_db.sales
GROUP BY  CustomerID
ORDER BY Total_Amount DESC
LIMIT 5;

-- 7)Write a query to calculate the total sales amount between two specific order dates.

SELECT 
    SUM(TotalAmount) AS TotalSales
FROM retail_sales
WHERE OrderDate BETWEEN '2024-01-01' AND '2024-12-31';

-- 8)Write a query to find the second highest total sales amount for each product category.

WITH category_sales AS (
    SELECT 
        productCategory,
        SUM(TotalAmount) AS total_sales
    FROM sales
    GROUP BY productCategory
),
ranked_sales AS (
    SELECT 
        productCategory,
        total_sales,
        DENSE_RANK() OVER (ORDER BY total_sales DESC) AS rnk
    FROM category_sales
)
SELECT 
    productCategory,
    total_sales
FROM ranked_sales
WHERE rnk = 2;

-- 9)Write a query to classify customers into 'High', 'Medium', or 'Low' spenders based on their total amount spent.

SELECT 
    CustomerID,
    SUM(TotalAmount) AS TotalSpent,
    CASE
        WHEN SUM(TotalAmount) >= 1000 THEN 'High'
        WHEN SUM(TotalAmount) >= 500 THEN 'Medium'
        ELSE 'Low'
    END AS SpenderCategory
FROM retail_sales_db.sales
GROUP BY CustomerID;

-- 10)Write a query to generate a report showing the total sales amount, average sales amount, and total number of transactions for each product category.

SELECT 
    productCategory,
    SUM(TotalAmount) AS Total_Sales_Amount,
    AVG(TotalAmount) AS Average_Sales_Amount,
    COUNT(*) AS Total_Transactions
FROM retail_sales_db.sales
GROUP BY productCategory;

