USE SalesAnalyticsDB;
GO

-- =============================================
-- Project: Sales & Customer Analytics
-- File: 08_Business_Questions.sql
-- =============================================

-- 1. Highest Revenue Product
SELECT TOP 1
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(p.Price * od.Quantity) AS TotalRevenue
FROM Products AS p
INNER JOIN OrderDetails AS od
    ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY TotalRevenue DESC;


-- 2. Highest Revenue Customer
SELECT TOP 1
    c.CustomerID,
    c.CustomerName,
    c.City,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(p.Price * od.Quantity) AS TotalRevenue
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
ORDER BY TotalRevenue DESC;


-- 3. Revenue by Product Category
SELECT
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(p.Price * od.Quantity) AS TotalRevenue
FROM Products AS p
INNER JOIN OrderDetails AS od
    ON p.ProductID = od.ProductID
GROUP BY p.Category
ORDER BY TotalRevenue DESC;


-- 4. Customers with No Orders
SELECT
    c.CustomerID,
    c.CustomerName,
    c.City
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
ORDER BY c.CustomerID;


-- 5. Cancelled Orders Analysis
SELECT
    COUNT(DISTINCT o.OrderID) AS CancelledOrders,
    SUM(p.Price * od.Quantity) AS CancelledOrderValue
FROM Orders AS o
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
WHERE o.OrderStatus = 'Cancelled';


-- 6. Average Order Value
SELECT
    AVG(OrderTotal) AS AverageOrderValue
FROM
(
    SELECT
        o.OrderID,
        SUM(p.Price * od.Quantity) AS OrderTotal
    FROM Orders AS o
    INNER JOIN OrderDetails AS od
        ON o.OrderID = od.OrderID
    INNER JOIN Products AS p
        ON od.ProductID = p.ProductID
    GROUP BY o.OrderID
) AS OrderSummary;


-- 7. Revenue by Order Status
SELECT
    o.OrderStatus,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(p.Price * od.Quantity) AS TotalRevenue
FROM Orders AS o
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY o.OrderStatus
ORDER BY TotalRevenue DESC;


-- 8. Revenue by City
SELECT
    c.City,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(p.Price * od.Quantity) AS TotalRevenue
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY c.City
ORDER BY TotalRevenue DESC;


-- 9. Repeat Customers
SELECT
    c.CustomerID,
    c.CustomerName,
    c.City,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName,
    c.City
HAVING COUNT(o.OrderID) > 1
ORDER BY TotalOrders DESC;


-- 10. Category Revenue Contribution
;WITH CategorySales AS
(
    SELECT
        p.Category,
        SUM(p.Price * od.Quantity) AS TotalRevenue
    FROM Products AS p
    INNER JOIN OrderDetails AS od
        ON p.ProductID = od.ProductID
    GROUP BY p.Category
)
SELECT
    Category,
    TotalRevenue,
    CAST(
        100.0 * TotalRevenue / SUM(TotalRevenue) OVER ()
        AS DECIMAL(5,2)
    ) AS RevenueContributionPercent
FROM CategorySales
ORDER BY TotalRevenue DESC;