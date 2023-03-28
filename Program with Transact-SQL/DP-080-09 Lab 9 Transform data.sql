CREATE VIEW SalesLT.vCustGroups AS
SELECT AddressID, CHOOSE(AddressID % 3 + 1, N'A', N'B', N'C') AS custgroup, CountryRegion
FROM SalesLT.Address;
GO
SELECT AddressID, custgroup, CountryRegion
FROM SalesLT.vCustGroups;
GO
SELECT CountryRegion, p.A, p.B, p.C
FROM SalesLT.vCustGroups PIVOT (
        COUNT(AddressID) FOR custgroup IN (A, B, C)
) AS p;
GO
CREATE VIEW SalesLT.vCustomerSales AS 
SELECT Customer.CustomerID, Customer.CompanyName, Customer.SalesPerson, SalesOrderHeader.TotalDue 
FROM SalesLT.Customer 
INNER JOIN SalesLT.SalesOrderHeader 
    ON Customer.CustomerID = SalesOrderHeader.CustomerID;
GO
SELECT * FROM SalesLT.vCustomerSales;
GO
SELECT SalesPerson, CompanyName, SUM(TotalDue) AS TotalSales
FROM SalesLT.vCustomerSales
    GROUP BY ROLLUP (SalesPerson, CompanyName);
GO
SELECT * 
FROM 
(
    SELECT P.ProductID, PC.Name, ISNULL(P.Color, 'Uncolored') AS Color 
    FROM Saleslt.ProductCategory AS PC 
    JOIN SalesLT.Product AS P 
        ON PC.ProductCategoryID = P.ProductCategoryID
) AS PPC PIVOT(
    COUNT(ProductID) FOR Color IN(
        [Red], [Blue], [Black], [Silver], [Yellow], 
        [Grey], [Multi], [Uncolored]
    )
) AS pvt 
    ORDER BY Name;
GO
SELECT CompanyName, SalesPerson, SUM(TotalDue) AS TotalSales
FROM SalesLT.vCustomerSales
    GROUP BY CUBE (CompanyName, SalesPerson);