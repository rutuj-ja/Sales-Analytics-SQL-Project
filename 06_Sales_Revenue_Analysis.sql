USE SalesAnalyticsDB;
GO

-- =============================================
-- Project: Sales & Customer Analytics
-- File: 06_Sales_Revenue_Analysis.sql
-- =============================================

-- 1. Sales amount by order and product
SELECT
    od.OrderID,
    p.ProductName,
    p.Price,
    od.Quantity,
    p.Price * od.Quantity AS SalesAmount
FROM OrderDetails AS od
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
ORDER BY SalesAmount DESC;


-- 2. Product-wise sales
SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM OrderDetails AS od
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY TotalSales DESC;


-- 3. Customer-wise revenue
SELECT
    c.CustomerID,
    c.CustomerName,
    c.City,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY
    c.CustomerID,
    c.CustomerName,
    c.City
ORDER BY TotalSales DESC;


-- 4. Top 5 customers by revenue
SELECT TOP 5
    c.CustomerID,
    c.CustomerName,
    c.City,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY
    c.CustomerID,
    c.CustomerName,
    c.City
ORDER BY TotalSales DESC;


-- 5. City-wise revenue
SELECT
    c.City,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY c.City
ORDER BY TotalSales DESC;


-- 6. Monthly sales
SELECT
    YEAR(o.OrderDate) AS OrderYear,
    MONTH(o.OrderDate) AS OrderMonth,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM Orders AS o
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate)
ORDER BY OrderYear, OrderMonth;


-- 7. Monthly sales with month name
SELECT
    DATENAME(MONTH, o.OrderDate) AS SalesMonth,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM Orders AS o
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY
    MONTH(o.OrderDate),
    DATENAME(MONTH, o.OrderDate)
ORDER BY MONTH(o.OrderDate);