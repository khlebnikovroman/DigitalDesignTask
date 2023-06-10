SELECT YEAR(OrderDate) AS [Year], MONTH(OrderDate) AS [Month], SUM(LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader
JOIN Sales.SalesOrderDetail ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate)