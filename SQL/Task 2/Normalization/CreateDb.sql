CREATE FUNCTION dbo.GetPurchaseTotalAmount (@PurchaseId INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10, 2);

    SELECT @TotalAmount = SUM(Product.Price * PurchaseComposition.Quantity)
    FROM PurchaseComposition
    JOIN Product ON PurchaseComposition.ProductId = Product.ProductId
    WHERE PurchaseComposition.PurchaseId = @PurchaseId;

    RETURN @TotalAmount;
END;
GO

CREATE TABLE MeasureUnit (
    MeasureId INT PRIMARY KEY,
    Name NVARCHAR(50)
);

CREATE TABLE Product (
    ProductId INT PRIMARY KEY,
    Name NVARCHAR(250) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    MeasureId INT,
    FOREIGN KEY (MeasureId) REFERENCES MeasureUnit(MeasureId)
);

CREATE TABLE Gender (
    GenderId INT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Address (
    AddressId INT PRIMARY KEY,
    City NVARCHAR(300) NOT NULL,
    AddressLine1 NVARCHAR(300) NOT NULL,
    FullAddress AS (City + ', ' + AddressLine1) PERSISTED
);

CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY,
    FullName NVARCHAR(300) NOT NULL,
    GenderId INT NOT NULL,
    FOREIGN KEY (GenderId) REFERENCES Gender(GenderId)
);

CREATE TABLE Purchase (
    PurchaseId INT PRIMARY KEY,
	Date DATE NOT NULL,
    CustomerId INT NOT NULL,
	AddressId INT NOT NULL,
	TotalAmount AS dbo.GetPurchaseTotalAmount(PurchaseId),
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
	FOREIGN KEY (AddressId) REFERENCES Address(AddressId),
);

CREATE TABLE PurchaseComposition (
    PurchaseId INT,
    ProductId INT,
    Quantity DECIMAL(10, 2),
    PRIMARY KEY (PurchaseId, ProductId),
    FOREIGN KEY (PurchaseId) REFERENCES Purchase(PurchaseId),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);
