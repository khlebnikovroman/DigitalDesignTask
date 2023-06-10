SELECT TOP(10) C.City, Count(C.BusinessEntityID) as Priority
FROM Sales.vIndividualCustomer AS C
LEFT JOIN Sales.vStoreWithAddresses as S ON C.City = S.City
where S.City is null
group by C.city
order by Priority DESC
