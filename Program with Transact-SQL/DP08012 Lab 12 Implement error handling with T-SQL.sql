RAISERROR (N'%s %d', -- Message text,
    10, -- Severity,
    1, -- State,
    N'Custom error message number',
    2)
go    
THROW 50001, 'An Error Occured',0
GO
--bad use
RAISERROR(N'Message', 16, 1);
IF @@ERROR <> 0
PRINT 'Error=' + CAST(@@ERROR AS VARCHAR(8));
GO
--good use
DECLARE @ErrorValue int;
RAISERROR(N'Message', 16, 1);
SET @ErrorValue = @@ERROR;
IF @ErrorValue <> 0
PRINT 'Error=' + CAST(@ErrorValue AS VARCHAR(8));
--DP-080-12: LAB 12 Implement error handling with T-SQL
SELECT CAST(N'Some text' AS int);
GO
BEGIN TRY
    SELECT CAST(N'Some text' AS int);
END TRY
BEGIN CATCH
    PRINT 'Error';
END CATCH;
GO
DECLARE @num varchar(20) = '0';

BEGIN TRY
    PRINT 5. / CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;
go
DECLARE @num varchar(20) = 'A';

BEGIN TRY
    PRINT 5. / CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;
GO
DECLARE @num varchar(20) = ' 1000000000';

BEGIN TRY
    PRINT 5. / CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;
GO
DECLARE @num varchar(20) = 'A';

BEGIN TRY
    PRINT 5. / CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() IN (245, 8114)
    BEGIN
        PRINT 'Handling conversion error...'
    END
    ELSE
    BEGIN 
        PRINT 'Handling non-conversion error...';
    END;

    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;
GO

DECLARE @num varchar(20) = '0';

BEGIN TRY
    PRINT 5. / CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() IN (245, 8114)
    BEGIN
        PRINT 'Handling conversion error...'
    END
    ELSE
    BEGIN 
        PRINT 'Handling non-conversion error...';
    END;

    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;
GO
CREATE PROCEDURE dbo.GetErrorInfo AS
PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
PRINT 'Error Message: ' + ERROR_MESSAGE();
PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS varchar(10));
PRINT 'Error State: ' + CAST(ERROR_STATE() AS varchar(10));
PRINT 'Error Line: ' + CAST(ERROR_LINE() AS varchar(10));
PRINT 'Error Proc: ' + COALESCE(ERROR_PROCEDURE(), 'Not within procedure');
GO
DECLARE @num varchar(20) = '0';

BEGIN TRY
    PRINT 5. / CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    EXECUTE dbo.GetErrorInfo;
END CATCH;
GO
DECLARE @num varchar(20) = '0';

BEGIN TRY
    PRINT 5. / CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    EXECUTE dbo.GetErrorInfo; 
    THROW;
END CATCH;
GO
DECLARE @num varchar(20) = 'A';

BEGIN TRY
    PRINT 5. / CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    EXECUTE dbo.GetErrorInfo;

    IF ERROR_NUMBER() = 8134
    BEGIN
        PRINT 'Handling devision by zero...';
    END
    ELSE 
    BEGIN
        PRINT 'Throwing original error';
        THROW;
    END;

END CATCH;

---Incio Challenges
GO
DECLARE @customerID AS INT = 30110;
DECLARE @fname AS NVARCHAR(20);
DECLARE @lname AS NVARCHAR(30);
DECLARE @maxReturns AS INT = 1;

WHILE @maxReturns <= 10
BEGIN
    BEGIN TRY
        SELECT @fname = FirstName, @lname = LastName FROM SalesLT.Customer
            WHERE CustomerID = @CustomerID;

        PRINT CAST(@customerID as NVARCHAR(20)) + N' ' + @fname + N' ' + @lname;
    END TRY
    BEGIN CATCH

    END CATCH;

    SET @maxReturns += 1;
    SET @CustomerID += 1;
END;
GO
DECLARE @customerID AS INT = 30110;
DECLARE @fname AS NVARCHAR(20);
DECLARE @lname AS NVARCHAR(30);
DECLARE @maxReturns AS INT = 1;

WHILE @maxReturns <= 10
BEGIN
    BEGIN TRY
        SELECT @fname = FirstName, @lname = LastName FROM SalesLT.Customer
            WHERE CustomerID = @CustomerID;

            PRINT CAST(@customerID as NVARCHAR(20)) + N' ' + @fname + N' ' + @lname;
    END TRY
    BEGIN CATCH
        PRINT 'Unable to run query'
    END CATCH;

    SET @maxReturns += 1;
    SET @CustomerID += 1;
END;
GO
DECLARE @customerID AS INT = 30110;
DECLARE @fname AS NVARCHAR(20);
DECLARE @lname AS NVARCHAR(30);
DECLARE @maxReturns AS INT = 1;

WHILE @maxReturns <= 10
BEGIN
    BEGIN TRY
        SELECT @fname = FirstName, @lname = LastName FROM SalesLT.Customer
            WHERE CustomerID = @CustomerID;

        IF @@ROWCOUNT > 0 
        BEGIN
            PRINT CAST(@customerID as NVARCHAR(20)) + N' ' + @fname + N' ' + @lname;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Unable to run query'
    END CATCH

    SET @maxReturns += 1;
    SET @CustomerID += 1;
END;
GO
DECLARE @num varchar(20) = 'Challenge 2';

BEGIN TRY
    PRINT 'Casting: ' + CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH

END CATCH;
go
CREATE PROCEDURE dbo.DisplayErrorDetails AS
PRINT 'ERROR INFORMATION';
PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
PRINT 'Error Message: ' + ERROR_MESSAGE();
PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS varchar(10));
go
DECLARE @num varchar(20) = 'Challenge 2';

BEGIN TRY
    PRINT 'Casting: ' + CAST(@num AS numeric(10,4));
END TRY
BEGIN CATCH
    EXECUTE dbo.DisplayErrorDetails;
END CATCH;