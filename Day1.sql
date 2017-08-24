USE [Northwind]
GO
/**/
SELECT * FROM Customers;
SELECT CustomerID FROM Customers;
SELECT  DISTINCT City FROM Customers;
SELECT * FROM Customers where CustomerID=10000;
SELECT CustomerID AS ID FROM Customers;
/*SELECT * FROM Customers WHERE Race='CN'AND Age>=21;*/
SELECT ContactName FROM Customers where ContactName like '%Tan%';
SELECT * FROM Customers WHERE Address is null;
SELECT * FROM Customers ORDER BY City;
SELECT * FROM Customers ORDER BY City DESC;
SELECT COUNT(*)AS Total,COUNT(Address) as totalAddress FROM Customers;



