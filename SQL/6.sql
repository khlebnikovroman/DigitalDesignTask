SELECT
    CONCAT(MP.LastName, ' ', LEFT(MP.FirstName, 1), '.', LEFT(MP.MiddleName, 1), '.') AS [Имя руководителя],
    M.HireDate AS [Дата приема руководителя на работу],
    M.BirthDate AS [Дата рождения руководителя],
    CONCAT(EP.LastName, ' ', LEFT(EP.FirstName, 1), '.', LEFT(EP.MiddleName, 1), '.') AS [Имя сотрудника],
    E.HireDate AS [Дата приема сотрудника на работу],
    E.BirthDate AS [Дата рождения сотрудника]
FROM
    HumanResources.Employee AS E
    INNER JOIN Person.Person AS EP ON E.BusinessEntityID = EP.BusinessEntityID
    INNER JOIN HumanResources.Employee AS M ON E.OrganizationNode.GetAncestor(1) = M.OrganizationNode
    INNER JOIN Person.Person AS MP ON M.BusinessEntityID = MP.BusinessEntityID
WHERE
    E.HireDate < M.HireDate AND
    E.BirthDate < M.BirthDate
ORDER BY
    M.OrganizationLevel,
    MP.LastName,
    EP.LastName;