SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ProductCategoryID = 6;
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ProductCategoryID = 6;
SELECT ProductID, Name, ListPrice
FROM SalesLT.vProductsRoadBikes
WHERE ListPrice < 1000;
SELECT ProductID, Name, ListPrice
FROM SalesLT.vProductsRoadBikes
WHERE ListPrice < 1000;
GO
SELECT DerivedTable.ProductID, DerivedTable.Name, DerivedTable.ListPrice
FROM
    (
        SELECT
        ProductID, Name, ListPrice,
        CASE WHEN ListPrice > 1000 THEN N'High' ELSE N'Normal' END AS PriceType
        FROM SalesLT.Product
    ) AS DerivedTable
WHERE DerivedTable.PriceType = N'High';
GO
CREATE VIEW SalesLT.vAddressCA AS
SELECT AddressLine1, City, StateProvince, CountryRegion
FROM SalesLT.Address
WHERE CountryRegion = 'Canada';
GO
SELECT * FROM SalesLT.vAddressCA;
GO
SELECT ProductID, Name, Weight, ListPrice,
       CASE WHEN Weight > 1000 THEN N'Heavy' ELSE N'Normal' END AS WeightType
FROM SalesLT.Product;
GO
SELECT DerivedTable.ProductID, DerivedTable.Name, DerivedTable.Weight, DerivedTable.ListPrice
FROM
    (
        SELECT ProductID, Name, Weight, ListPrice,
               CASE WHEN Weight > 1000. THEN N'Heavy' ELSE N'Normal' END AS WeightType
        FROM SalesLT.Product
    ) AS DerivedTable
WHERE DerivedTable.WeightType = N'Heavy' AND DerivedTable.ListPrice > 2000;
go