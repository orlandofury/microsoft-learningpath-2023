use AdventureWorks
go
DECLARE @num int = 5;
SELECT @num AS mynumber;
GO
DECLARE @num1 int,@num2 int;SET @num1 = 4;
SET @num2 = 6;
SELECT @num1 + @num2 AS totalnum;
GO
DECLARE @empname nvarchar(30),@empid int;
SET @empid = 2;
SET @empname = (SELECT FirstName + N' ' + LastName FROM SalesLT.Customer WHERE CustomerID = @empid)SELECT @empname AS employee;
GO
DECLARE @empname NVARCHAR(30),@empid int;SET @empid = 5;
SET @empname = (SELECT FirstName + N' ' + LastName FROM SalesLT.Customer WHERE CustomerID = @empid)
GO--SELECT @empname AS employee;
DECLARE @i int = 8,@result nvarchar(20);
IF @i < 5    
	SET @result = N'Less than 5'
ELSE IF @i <= 10    
	SET @result = N'Between 5 and 10'
ELSE if @i > 10    
	SET @result = N'More than 10'
ELSE    
	SET @result = N'Unknown';
SELECT @result AS result;
go
DECLARE @i int = 8,@result nvarchar(20);
SET @result = CASE WHEN @i < 5 THEN    N'Less than 5'
				   WHEN @i <= 10 THEN    N'Between 5 and 10'
				   WHEN @i > 10 THEN    N'More than 10'
				   ELSE    N'Unknown'
			  END;
SELECT @result AS result;
GO
DECLARE @i int = 1;
WHILE @i <= 10
BEGIN    
	PRINT @i;    
	SET @i = @i + 1;
END;
GO


--Challenges
DECLARE @salesOrderNumber NVARCHAR(30) = 'Probando',        @customerID INT = 29847
SELECT @salesOrderNumber = SalesOrderNumber FROM SalesLT.SalesOrderHeader WHERE CustomerID = @customerID
SELECT @salesOrderNumber OrderNumbergo
DECLARE @customerID AS INT = 1;
DECLARE @fname AS NVARCHAR(20);DECLARE @lname AS NVARCHAR(30);
WHILE @customerID <=10
BEGIN    
SET @customerID += 1;
END;
go
DECLARE @customerID AS INT = 1;
DECLARE @fname AS NVARCHAR(20);
DECLARE @lname AS NVARCHAR(30);
WHILE @customerID <=10
BEGIN    
SELECT @fname = FirstName, @lname = LastName FROM SalesLT.Customer        WHERE CustomerID = @CustomerID;   
PRINT @fname + N' ' + @lname;    SET @customerID += 1;
END;