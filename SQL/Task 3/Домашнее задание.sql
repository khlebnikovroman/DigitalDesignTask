
-- Нужно ускорить запросы ниже любыми способами
-- Можно менять текст самого запроса или добавилять новые индексы
-- Схему БД менять нельзя
-- В овете пришлите итоговый запрос и все что было создано для его ускорения

-- Задача 1

CREATE INDEX IX_CoveringWebLog_SessionStart
ON Marketing.WebLog (SessionStart)
INCLUDE (ServerID, UserName, SessionId);

SELECT TOP(5000) wl.SessionID, wl.ServerID, wl.UserName 
FROM Marketing.WebLog AS wl
WHERE wl.SessionStart >= '2010-08-30 16:27'
ORDER BY wl.SessionStart, wl.ServerID;
GO

-- Задача 2

CREATE INDEX IX_CoveringIndex ON
Marketing.PostalCode (StateCode, PostalCode)
INCLUDE (Country);

SELECT PostalCode, Country
FROM Marketing.PostalCode 
WHERE StateCode = 'KY'
ORDER BY StateCode, PostalCode;
GO

-- Задача 3

CREATE INDEX IX_Prospect_LastName
ON Marketing.Prospect (LastName);
CREATE INDEX IX_Salesperson_LastName
ON Marketing.Salesperson (LastName);
CREATE INDEX IX_Prospect_FirstName
ON Marketing.Prospect (FirstName);

DECLARE @Counter INT = 0;
WHILE @Counter < 350
BEGIN
  SELECT p.LastName, p.FirstName 
  FROM Marketing.Prospect AS p
  INNER JOIN Marketing.Salesperson AS sp
  ON p.LastName = sp.LastName
  ORDER BY p.LastName, p.FirstName;
  
  SELECT * 
  FROM Marketing.Prospect AS p
  WHERE p.LastName = 'Smith';
  SET @Counter += 1;
END;

-- Задача 4

CREATE INDEX IX_Product_ProductModelID
ON Marketing.Product (ProductModelID);
CREATE INDEX IX_Product_SubcategoryID
ON Marketing.Product (SubcategoryID);

SELECT
	c.CategoryName,
	sc.SubcategoryName,
	pm.ProductModel,
	COUNT(p.ProductID) AS ModelCount
FROM Marketing.ProductModel pm
	JOIN Marketing.Product p
		ON p.ProductModelID = pm.ProductModelID
	JOIN Marketing.Subcategory sc
		ON sc.SubcategoryID = p.SubcategoryID
	JOIN Marketing.Category c
		ON c.CategoryID = sc.CategoryID
GROUP BY c.CategoryName,
	sc.SubcategoryName,
	pm.ProductModel
HAVING COUNT(p.ProductID) > 1