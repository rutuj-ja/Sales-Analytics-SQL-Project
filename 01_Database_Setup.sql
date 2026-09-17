USE SalesAnalyticsDB;
GO

-- =============================================
-- Project: Sales & Customer Analytics
-- File: 01_Database_Setup.sql
-- =============================================

-- Check Tables
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Check Customers
SELECT *
FROM Customers;

-- Check Products
SELECT *
FROM Products;

-- Check Orders
SELECT *
FROM Orders;

-- Check Order Details
SELECT *
FROM OrderDetails;