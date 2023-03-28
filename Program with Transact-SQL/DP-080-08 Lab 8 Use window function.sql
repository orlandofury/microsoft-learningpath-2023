WITH sales AS
(
    SELECT C.Name AS 'Category', CAST(SUM(D.LineTotal) AS numeric(12, 2)) AS 'SalesValue'
    FROM SalesLT.SalesOrderDetail AS D
    INNER JOIN SalesLT.Product AS P
        ON D.ProductID = P.ProductID
    INNER JOIN SalesLT.ProductCategory AS C
        ON P.ProductCategoryID = C.ProductCategoryID
    WHERE C.ParentProductCategoryID = 4
        GROUP BY C.Name
)
SELECT Category, SalesValue, RANK() OVER(ORDER BY SalesValue DESC) AS 'Rank'
FROM sales
    ORDER BY Category;
GO
CREATE TABLE dbo.Budget
(
    [Year] int NOT NULL PRIMARY KEY,
    Budget int NOT NULL
);

INSERT INTO dbo.Budget ([Year], Budget)
    VALUES
        (2017, 14600),
        (2018, 16300),
        (2019, 18200),
        (2020, 21500),
        (2021, 22800);

SELECT [Year], Budget, LAG(Budget, 1, 0) OVER (ORDER BY [Year]) AS 'Previous'
    FROM dbo.Budget
    ORDER BY [Year];
GO
SELECT C.Name AS 'Category', SC.Name AS 'Subcategory', COUNT(SC.Name) OVER (PARTITION BY C.Name) AS 'SubcatCount'
FROM SalesLT.SalesOrderDetail AS D
INNER JOIN SalesLT.Product AS P
    ON D.ProductID = P.ProductID
INNER JOIN SalesLT.ProductCategory AS SC
    ON P.ProductCategoryID = SC.ProductCategoryID
INNER JOIN SalesLT.ProductCategory AS C
    ON SC.ParentProductCategoryID = C.ProductCategoryID
    GROUP BY C.Name, SC.Name
GO    ORDER BY C.Name, SC.Name;

WITH sales AS
(
    SELECT C.Name AS 'Category', SC.Name AS 'Subcategory', CAST(SUM(D.LineTotal) AS numeric(12, 2)) AS 'SalesValue'
    FROM SalesLT.SalesOrderDetail AS D
    INNER JOIN SalesLT.Product AS P
        ON D.ProductID = P.ProductID
    INNER JOIN SalesLT.ProductCategory AS SC
        ON P.ProductCategoryID = SC.ProductCategoryID
    INNER JOIN SalesLT.ProductCategory AS C
        ON SC.ParentProductCategoryID = C.ProductCategoryID
        GROUP BY C.Name, SC.Name
)
SELECT Category, Subcategory, SalesValue, RANK() OVER(PARTITION BY Category ORDER BY SalesValue DESC) AS 'Rank'
FROM sales
    ORDER BY Category, SalesValue DESC;
GO
SELECT [Year], Budget, LEAD(Budget, 1, 0) OVER (ORDER BY [Year]) AS 'Next'
FROM dbo.Budget
    ORDER BY [Year];
GO
SELECT [Year], Budget,
        FIRST_VALUE(Budget) OVER (ORDER BY [Year]) AS 'First_Value',
        LAST_VALUE(Budget) OVER (ORDER BY [Year] ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS 'Last_Value'
FROM dbo.Budget
    ORDER BY [Year];
GO
SELECT C.Name AS 'Category', SC.Name AS 'Subcategory', COUNT(P.Name) OVER (PARTITION BY C.Name) AS 'ProductCount'
FROM SalesLT.SalesOrderDetail AS D
    INNER JOIN SalesLT.Product AS P
        ON D.ProductID = P.ProductID
    INNER JOIN SalesLT.ProductCategory AS SC
        ON P.ProductCategoryID = SC.ProductCategoryID
    INNER JOIN SalesLT.ProductCategory AS C
        ON SC.ParentProductCategoryID = C.ProductCategoryID
    GROUP BY C.Name, SC.Name, P.Name
    ORDER BY C.Name, SC.Name, P.Name;