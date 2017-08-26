Use Dafesty
go
--User View
/*
CREATE VIEW view-name(column-name,¡K ) AS query
*/
CREATE VIEW GoodCustomer
AS SELECT CustomerID, CustomerName,
MemberCategory,CountryCode
FROM Customers
WHERE MemberCategory IN ('A','B')

UPDATE GoodCustomer--allow
SET MemberCategory = 'C'
WHERE CustomerID = 1000

INSERT INTO GoodCustomer (CustomerID,MemberCategory, CountryCode)--Allow
VALUES ( '5000','C', 'USA' )

SELECT *--not in view table
FROM GoodCustomer
WHERE CustomerID='5000'
--With Check option
CREATE VIEW GoodCustomerView2 AS 
SELECT CustomerID, CustomerName,MemberCategory,CountryCode
FROM Customers
WHERE MemberCategory IN ('A','B')
WITH CHECK OPTION

INSERT INTO GoodCustomerView2 (CustomerID,MemberCategory, CountryCode)--Not Allow
VALUES ( '5000','C', 'USA' )

--If user view with too many querys, update may not allow
--Mostly for simplfy retrival 

--Creating Stored Procedure
/*
CREATE PROCEDURE procedure_name
AS
BEGIN
¡K.
SQL_statements
¡K.
END
*/
Use Northwind
go
--Example
CREATE PROCEDURE sp_test_1
AS
BEGIN
SELECT * FROM customers;
SELECT * FROM products;
END

EXEC sp_test_1
--Declaring Stored Procedures that takes arguments:
use Dafesty
go

CREATE PROCEDURE MyProcedure (@var1 CHAR(2), @var2 INTEGER)
AS
BEGIN
     SELECT *
     FROM Movies
     WHERE Rating= @var1 and TotalStock > @var2;
END

EXEC MyProcedure 'PG',1
