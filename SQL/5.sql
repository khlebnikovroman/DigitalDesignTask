SELECT
    H.OrderDate AS [Дата заказа],
    P.LastName AS [Фамилия покупателя],
    P.FirstName AS [Имя покупателя],
    STRING_AGG(CONCAT(PR.Name, ' Количество: ', D.OrderQty, ' шт.'), CHAR(10)) AS [Содержимое заказа]
FROM
    Sales.SalesOrderHeader AS H
    INNER JOIN Sales.SalesOrderDetail AS D ON H.SalesOrderId = D.SalesOrderId
    INNER JOIN Sales.Customer AS C ON H.CustomerId = C.CustomerId
    INNER JOIN Person.Person AS P ON C.PersonId = P.BusinessEntityID
    INNER JOIN Production.Product AS PR ON D.ProductId = PR.ProductId
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Sales.SalesOrderHeader AS H2
        WHERE H.CustomerId = H2.CustomerId AND H2.OrderDate < H.OrderDate
    )
GROUP BY
    H.OrderDate,
    P.LastName,
    P.FirstName
ORDER BY
    H.OrderDate DESC
