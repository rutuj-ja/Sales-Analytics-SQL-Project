# Sales & Customer Analytics — SQL Data Analyst Project

## Project Overview

This project focuses on analyzing sales, customer, product, and order data using Microsoft SQL Server.

The project demonstrates practical SQL skills including data retrieval, filtering, aggregation, joins, subqueries, CTEs, window functions, views, KPI analysis, and business-oriented SQL queries.

The analysis is designed to generate meaningful insights into customer behavior, product performance, sales revenue, order status, and business performance.

## Business Objectives

- Analyze overall sales revenue and order performance.
- Identify top-performing products and customers.
- Analyze sales performance by product category.
- Understand customer ordering patterns and repeat customers.
- Analyze monthly sales trends and revenue changes.
- Evaluate order status distribution and cancelled orders.
- Calculate key business KPIs such as total revenue, total orders, and average order value.

## Database Schema

The project contains four main tables:

### 1. Customers
Stores customer information such as Customer ID, customer name, and city.

### 2. Products
Stores product information including product name, category, price, and stock quantity.

### 3. Orders
Stores order information including customer, order date, and order status.

### 4. OrderDetails
Stores individual products and quantities associated with each order.

### Table Relationships

- `Customers.CustomerID` → `Orders.CustomerID`
- `Orders.OrderID` → `OrderDetails.OrderID`
- `Products.ProductID` → `OrderDetails.ProductID`

## Tools & Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL
- GitHub
- Data Analysis
- Business Intelligence

## SQL Concepts Demonstrated

- SELECT, WHERE, ORDER BY
- GROUP BY and HAVING
- Aggregate Functions: SUM, AVG, COUNT
- INNER JOIN and LEFT JOIN
- Subqueries
- Common Table Expressions (CTEs)
- CASE WHEN
- Window Functions
- RANK() and ROW_NUMBER()
- LAG()
- Monthly Sales Analysis
- KPI Analysis
- Views
- Business-oriented SQL Queries

## Key Business Questions

- Which product generates the highest revenue?
- Which customer generates the highest revenue?
- Which product categories generate the most revenue?
- Which customers are repeat customers?
- Which customers have no orders?
- What is the average order value?
- How much revenue comes from cancelled orders?
- How does revenue vary by order status?
- Which cities generate the highest revenue?
- What percentage of total revenue is contributed by each category?

## Project Structure

```text
Sales-Analytics-SQL-Project/
├── 01_Database_Setup.sql
├── 02_Data_Insertion.sql
├── 03_Basic_Analysis.sql
├── 04_Aggregation_Analysis.sql
├── 05_Joins_Analysis.sql
├── 06_Sales_Revenue_Analysis.sql
├── 07_Advanced_SQL_Analysis.sql
├── 08_Business_Questions.sql
└── README.md

## How to Run

1. Install Microsoft SQL Server and SQL Server Management Studio (SSMS).
2. Open SQL Server Management Studio.
3. Create or open the `SalesAnalyticsDB` database.
4. Execute the SQL files in the following order:
   - `01_Database_Setup.sql`
   - `02_Data_Insertion.sql`
   - `03_Basic_Analysis.sql`
   - `04_Aggregation_Analysis.sql`
   - `05_Joins_Analysis.sql`
   - `06_Sales_Revenue_Analysis.sql`
   - `07_Advanced_SQL_Analysis.sql`
   - `08_Business_Questions.sql`
5. Review the query results to analyze sales, customers, products, and business KPIs.

## Key Insights

- Identified top-performing products based on total revenue.
- Identified high-value customers based on customer revenue.
- Analyzed revenue contribution across product categories.
- Analyzed monthly sales trends and month-over-month changes.
- Identified repeat customers based on order frequency.
- Analyzed cancelled orders and their revenue impact.
- Calculated important business KPIs including total revenue, total orders, and average order value.
- Used SQL analysis to support data-driven business understanding.

## Author

**Rutuja Kusalkar**

Fresher Data Analyst | SQL | Excel | Power BI | Python | Data Visualization

- LinkedIn: linkedin.com/in/rutujakusalkar
- GitHub: github.com/rutuj-ja