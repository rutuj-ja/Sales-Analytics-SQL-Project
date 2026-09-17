USE SalesAnalyticsDB;
GO

-- =============================================
-- Project: Sales & Customer Analytics
-- File: 04_Aggregation_Analysis.sql
-- =============================================

-- 1. Customer count by city
SELECT
    City,
    COUNT(*) AS CustomerCount
FROM Customers
GROUP BY City
ORDER BY CustomerCount DESC;


-- 2. Product count by category
SELECT
    Category,
    COUNT(*) AS ProductCount
FROM Products
GROUP BY Category
ORDER BY ProductCount DESC;


-- 3. Average product price
SELECT
    AVG(Price) AS AverageProductPrice
FROM Products;


-- 4. Average price by category
SELECT
    Category,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category
ORDER BY AveragePrice DESC;


-- 5. Total stock by category
SELECT
    Category,
    SUM(StockQuantity) AS TotalStock
FROM Products
GROUP BY Category
ORDER BY TotalStock DESC;


-- 6. Highest priced product
SELECT TOP 1
    ProductName,
    Category,
    Price
FROM Products
ORDER BY Price DESC;