CREATE PROCEDURE SalesLT.TopProducts AS
SELECT TOP(10) name, listprice
            FROM SalesLT.Product
            GROUP BY name, listprice
            ORDER BY listprice DESC;
GO
EXECUTE SalesLT.TopProducts;

ALTER PROCEDURE SalesLT.TopProducts @ProductCategoryID int
AS
SELECT TOP(10) name, listprice
        FROM SalesLT.Product
        WHERE ProductCategoryID = @ProductCategoryID 
        GROUP BY name, listprice
        ORDER BY listprice DESC;
GO

EXECUTE SalesLT.TopProducts @ProductCategoryID = 18;
GO

EXECUTE SalesLT.TopProducts 41;
GO
CREATE FUNCTION SalesLT.GetFreightbyCustomer
(@orderyear AS INT) RETURNS TABLE
AS
RETURN
SELECT
customerid, SUM(freight) AS totalfreight
FROM SalesLT.SalesOrderHeader
WHERE YEAR(orderdate) = @orderyear
GROUP BY customerid;
GO
SELECT * FROM SalesLT.GetFreightbyCustomer(2008)

