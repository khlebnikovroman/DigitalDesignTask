IF OBJECT_ID('GetSingleMaleEmployeesByBirthDate', 'P') IS NOT NULL
    DROP PROCEDURE GetSingleMaleEmployeesByBirthDate;
GO
CREATE PROCEDURE GetSingleMaleEmployeesByBirthDate
    @DateFrom DATE,
    @DateTo DATE,
    @TotalCount INT OUTPUT
AS
BEGIN
    SELECT
        P.BusinessEntityID,
        P.FirstName,
        P.MiddleName,
        P.LastName,
        E.BirthDate
    INTO #Result
    FROM Person.Person P
    JOIN HumanResources.Employee E ON P.BusinessEntityID = E.BusinessEntityID
    WHERE E.BirthDate BETWEEN @DateFrom AND @DateTo
        AND E.Gender = 'M'
		And E.MaritalStatus = 'S'

    SELECT * FROM #Result

    SET @TotalCount = (SELECT COUNT(*) FROM #Result)
END

DECLARE @From DATE = '1969-01-01'
DECLARE @To DATE = '2023-12-31'
DECLARE @Count INT

EXEC GetSingleMaleEmployeesByBirthDate @From, @To, @Count OUTPUT

select @Count