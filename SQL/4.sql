SELECT 
    P.LastName AS [Фамилия покупателя],
    P.FirstName AS [Имя покупателя],
    PR.Name AS [Название продукта],
    SUM(D.OrderQty) AS [Количество купленных экземпляров]
FROM 
    Sales.SalesOrderHeader AS H
    INNER JOIN Sales.SalesOrderDetail AS D ON H.SalesOrderId = D.SalesOrderId
    INNER JOIN Sales.Customer AS C ON H.CustomerId = C.CustomerId
    INNER JOIN Person.Person AS P ON C.PersonId = P.BusinessEntityID
    INNER JOIN Production.Product AS PR ON D.ProductId = PR.ProductId
GROUP BY 
    P.LastName,
    P.FirstName,
    PR.Name
HAVING 
    SUM(D.OrderQty) > 15
ORDER BY 
    [Количество купленных экземпляров] DESC,
    P.LastName ASC,
    P.FirstName ASC