use Dafesty
go
/*
CREATE PROCEDURE sp_test_1
AS
BEGIN
END
*/
--Exercise Stored Procedure 1
CREATE PROCEDURE ACustomerList
AS
BEGIN
SELECT CustomerName
FROM Customers
WHERE MemberCategory = 'A'
END

EXEC ACustomerList

--Exercise Stored Procedure 2

CREATE PROCEDURE ShowCustomerList(@var1 nvarchar(2))
AS
BEGIN
SELECT CustomerName
FROM Customers
WHERE MemberCategory =@var1
END

EXEC ShowCustomerList 'B'
EXEC ShowCustomerList 'Z'