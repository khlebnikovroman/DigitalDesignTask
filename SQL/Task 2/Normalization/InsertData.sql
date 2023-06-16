
INSERT INTO MeasureUnit (MeasureId, Name)
VALUES
    (1, N'шт'),
    (2, N'кг'),
    (3, N'м3'),
	(4, N'м.п.');

INSERT INTO Product (ProductId, Name, Price, MeasureId)
VALUES
    (1, N'Рама оконнная', 3875, 1),
    (2, N'Платье бальное', 15000, 1),
    (3, N'Грудки куриные', 180, 2),
	(4, N'Салат', 52, 1),
	(5, N'Топор', 500, 1),
	(6, N'Пила',450, 1),
	(7, N'Доски', 4890, 3),
	(8, N'Брус', 9390, 3),
	(9, N'Парусина', 182, 4);

INSERT INTO Gender (GenderId, Name)
VALUES
    (1, N'М'),
    (2, N'Ж');

INSERT INTO Customer (CustomerId, FullName, GenderId)
VALUES
    (1, N'Петр Романов', 1),
    (2, N'Софи́я Авгу́ста Фредери́ка А́нгальт-Це́рбстская', 2),
	(3, N'Александр Рюрикович', 1);


INSERT INTO Address (AddressId, City, AddressLine1)
VALUES
    (1, N'СПб', N'Сенатская площадь д.1'),
    (2, N'СПб', N'площадь Островского д.1'),
	(3, N'СПб', N'пл. Александра Невского д.1');


INSERT INTO Purchase (PurchaseId, Date, CustomerId, AddressId)
VALUES
    (1, '1703-05-27', 1, 1),
	(2, '1762-06-28', 2, 2),
	(3, '1242-04-05', 3, 3),
	(4, '1703-11-05', 1, 1);


INSERT INTO PurchaseComposition (PurchaseId, ProductId, Quantity)
VALUES
    (1, 1, 1),
    (2, 2, 999),
	(3, 3, 5),
	(3, 4, 5),
	(4, 5, 1),
	(4, 6, 1),
	(4, 7, 200),
	(4, 8, 20),
	(4, 9, 100);
