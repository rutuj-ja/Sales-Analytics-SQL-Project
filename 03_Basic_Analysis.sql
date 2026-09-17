USE SalesAnalyticsDB;
GO

-- =============================================
-- Project: Sales & Customer Analytics
-- File: 03_Basic_Analysis.sql
-- =============================================

-- 1. View all customers
SELECT *
FROM Customers;

-- 2. Customer name and city
SELECT
    CustomerName,
    City
FROM Customers;

-- 3. Electronics products
SELECT *
FROM Products
WHERE Category = 'Electronics';

-- 4. Products sorted by price
SELECT *
FROM Products
ORDER BY Price DESC;