USE SalesAnalyticsDB;
GO

-- =============================================
-- Project: Sales & Customer Analytics
-- File: 07_Advanced_SQL_Analysis.sql
-- =============================================


-- 1. Average Price पेक्षा महाग Products
SELECT
    ProductID,
    ProductName,
    Category,
    Price
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
)
ORDER BY Price DESC;


-- 2. Category Average पेक्षा महाग Products
SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Price
FROM Products AS p
WHERE p.Price > (
    SELECT AVG(p2.Price)
    FROM Products AS p2
    WHERE p2.Category = p.Category
)
ORDER BY p.Category, p.Price DESC;


-- 3. Customer-wise Sales using CTE
;WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,
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
        c.CustomerName
)
SELECT
    CustomerID,
    CustomerName,
    TotalSales
FROM CustomerSales
ORDER BY TotalSales DESC;


-- 4. Customers above Average Sales
;WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,
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
        c.CustomerName
)
SELECT
    CustomerID,
    CustomerName,
    TotalSales
FROM CustomerSales
WHERE TotalSales > (
    SELECT AVG(TotalSales)
    FROM CustomerSales
)
ORDER BY TotalSales DESC;


-- 5. Product Ranking using RANK()
;WITH ProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,
        SUM(p.Price * od.Quantity) AS TotalSales
    FROM Products AS p
    INNER JOIN OrderDetails AS od
        ON p.ProductID = od.ProductID
    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category
)
SELECT
    ProductID,
    ProductName,
    Category,
    TotalSales,
    RANK() OVER (ORDER BY TotalSales DESC) AS SalesRank
FROM ProductSales
ORDER BY SalesRank;


-- 6. Product Ranking using ROW_NUMBER()
;WITH ProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,
        SUM(p.Price * od.Quantity) AS TotalSales
    FROM Products AS p
    INNER JOIN OrderDetails AS od
        ON p.ProductID = od.ProductID
    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category
)
SELECT
    ProductID,
    ProductName,
    Category,
    TotalSales,
    ROW_NUMBER() OVER (ORDER BY TotalSales DESC) AS SalesRowNumber
FROM ProductSales
ORDER BY SalesRowNumber;


-- 7. Category-wise Product Ranking
;WITH ProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,
        SUM(p.Price * od.Quantity) AS TotalSales
    FROM Products AS p
    INNER JOIN OrderDetails AS od
        ON p.ProductID = od.ProductID
    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category
)
SELECT
    ProductID,
    ProductName,
    Category,
    TotalSales,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY TotalSales DESC
    ) AS CategorySalesRank
FROM ProductSales
ORDER BY Category, CategorySalesRank;


-- 8. Previous Month Sales using LAG()
;WITH MonthlySales AS
(
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
)
SELECT
    OrderYear,
    OrderMonth,
    TotalSales,
    LAG(TotalSales) OVER (
        ORDER BY OrderYear, OrderMonth
    ) AS PreviousMonthSales
FROM MonthlySales
ORDER BY OrderYear, OrderMonth;


-- 9. Month-over-Month Sales Difference
;WITH MonthlySales AS
(
    SELECT
        YEAR(o.OrderDate) AS OrderYear,
        MONTH(o.OrderDate) AS OrderMonth,
        SUM(p.Price * od.Quantity) AS TotalSales
    FROM Orders AS o
    INNER JOIN OrderDetails AS od
        ON o.OrderID = od.OrderID
    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
),
SalesComparison AS
(
    SELECT
        OrderYear,
        OrderMonth,
        TotalSales,
        LAG(TotalSales) OVER (
            ORDER BY OrderYear, OrderMonth
        ) AS PreviousMonthSales
    FROM MonthlySales
)
SELECT
    OrderYear,
    OrderMonth,
    TotalSales,
    PreviousMonthSales,
    TotalSales - PreviousMonthSales AS SalesDifference
FROM SalesComparison
ORDER BY OrderYear, OrderMonth;


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