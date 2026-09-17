USE SalesAnalyticsDB;
GO

-- =============================================
-- Project: Sales & Customer Analytics
-- File: 05_Joins_Analysis.sql
-- =============================================

-- 1. Customers and Orders
SELECT
    c.CustomerID,
    c.CustomerName,
    c.City,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;


-- 2. Delivered Orders with Customer Details
SELECT
    c.CustomerName,
    c.City,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered';


-- 3. Total Orders by Customer
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY TotalOrders DESC;


-- 4. Order Details with Product Information
SELECT
    od.OrderDetailID,
    od.OrderID,
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Price,
    od.Quantity
FROM OrderDetails AS od
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID;