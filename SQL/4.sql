SELECT 
    P.LastName AS [������� ����������],
    P.FirstName AS [��� ����������],
    PR.Name AS [�������� ��������],
    SUM(D.OrderQty) AS [���������� ��������� �����������]
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
    [���������� ��������� �����������] DESC,
    P.LastName ASC,
    P.FirstName ASC