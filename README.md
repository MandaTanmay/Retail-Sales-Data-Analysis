# Retail Sales Data Analysis - README

## Overview

Project Title: Retail Sales Analysis

Level: Beginner

This project involves creating, cleaning, and analyzing a retail sales database. The primary objectives are:
- Setting up a normalized database for sales records.
- Cleaning and validating incoming data.
- Performing in-depth SQL analytics to extract actionable business insights.

## Database Details

- **Database Name:** `retail_sales_db`
- **Main Table:** `retail_sales`

**Table Schema:**

| Column          | Type | Description                    |
|-----------------|------|--------------------------------|
| TransactionID   | INT  | Primary Key, unique per sale   |
| OrderDate       | TEXT | Date of transaction            |
| CustomerID      | TEXT | Unique identifier for customer |
| Gender          | TEXT | Gender of customer             |
| Age             | INT  | Age of customer                |
| ProductCategory | TEXT | Category of purchased product  |
| Quantity        | INT  | Number of units sold           |
| PricePerUnit    | INT  | Price per product unit         |
| TotalAmount     | INT  | Total monetary value           |

## Setup Instructions

1. **Run Database Creation Script**
    ```sql
    CREATE DATABASE IF NOT EXISTS retail_sales_db;
    ```

2. **Use the Database**
    ```sql
    USE retail_sales_db;
    ```

3. **Create Sales Table**
    ```sql
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
    ```

4. **Create Indexes for Query Performance**
    ```
   CREATE INDEX idx_orderdate ON retail_sales_db.sales(OrderDate(10));
   CREATE INDEX idx_customerid ON retail_sales_db.sales(CustomerID(10));
   CREATE INDEX idx_productcategory ON retail_sales_db.sales(ProductCategory(100));
    ```

## Exploration

- **List all tables:**  
  ```sql
  SELECT * FROM INFORMATION_SCHEMA.TABLES;
  ```

- **List all columns:**  
  ```sql
  SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'sales';
  ```

## Data Cleaning

- Null checks for each column.
- Identify records with invalid quantities, pricing, or sales values.
- Detect duplicate `TransactionID` records.

[Scripts provided above.]

## Analysis Queries

Key business queries included in this project:

1. **Total sales by product category**
2. **Average spent by customers aged 18-25**
3. **Top revenue-generating product categories (with ranking)**
4. **Average customer age by product category**
5. **Best-performing month by average sales**
6. **Top 5 customers by spending**
7. **Sales for a date range**
8. **Second-highest product-category sales**
9. **Customer classification: High, Medium, Low spenders**
10. **Summary report by product category (total, average, count)**

See the project SQL source for complete queries.

## Getting Started

1. **Clone or download** this repository.
2. **Load the SQL scripts** in your preferred SQL client (MySQL, PostgreSQL, etc.); adjust data types as necessary for your RDBMS.
3. **Populate `retail_sales`** with your data.
4. **Run the provided queries** for analytics.

## Notes & Recommendations

- Adjust date formats and data types according to your RDBMS (e.g., use `DATE` instead of `TEXT` for `OrderDate` in production).
- Indexes are provided to improve query speed—monitor as your dataset grows.
- Add constraints and more validation rules as necessary.

## License

This project is provided for educational/analytical purposes.

## Contact

For questions or suggestions, please reach out to the repository maintainer.

**Happy Analyzing!**
