USE [Dafesty]
GO

--inner join (can extract column from both tables)
--a) Method_1(394)
SELECT a.CustomerName, b.*
FROM Customers a,IssueTran b
WHERE a.CustomerID=b.CustomerID
--b) Method_2(394)
SELECT a.CustomerName, b.*
FROM Customers a inner join IssueTran b
ON a.CustomerID=b.CustomerID

--additional conditions
--a) (5)
SELECT a.CustomerName, b.*
FROM Customers a,IssueTran b
WHERE a.CustomerID=b.CustomerID and CustomerName='Steven Ou'
--b) (5)
SELECT a.CustomerName, b.*
FROM Customers a INNER JOIN IssueTran b
ON a.CustomerID=b.CustomerID
WHERE CustomerName='Steven Ou'

--Left Join
SELECT a.CustomerName, b.CustomerID
FROM Customers a LEFT JOIN IssueTran b
ON a.CustomerID=b.CustomerID
--Self Join
use Northwind
go
--Method_1(Inner join:8)
SELECT staff.LastName as Staff,supervisor.LastName as Supervisor
FROM Employees staff,Employees supervisor
WHERE staff.ReportsTo=supervisor.EmployeeID
--Method_2(left join:9)
SELECT staff.LastName as Staff,supervisor.LastName as Supervisor
FROM Employees staff LEFT JOIN Employees supervisor
ON staff.ReportsTo=supervisor.EmployeeID

--GROUP BY
USE [Dafesty]
GO

SELECT CountryCode,COUNT(*)
FROM Customers
GROUP BY CountryCode
--HAVING
SELECT CountryCode,COUNT(*)
FROM Customers
GROUP BY CountryCode
HAVING COUNT(*)>=2
--WHERE and HAVING
SELECT CountryCode,COUNT(*)
FROM Customers
WHERE ContactTitle='MR'
GROUP BY CountryCode
HAVING COUNT(*)>=2
--GROUP BY multiple variables
SELECT CountryCode,MemberCategory,COUNT(*)
FROM Customers
GROUP BY CountryCode,MemberCategory
--GROUP BY and sunquary
SELECT CountryCode,COUNT(*)
FROM Customers
GROUP BY CountryCode
HAVING COUNT(*)> (SELECT count(*)
                  FROM Customers
                  WHERE CountryCode='GER')

--UNION

--fititious column
--SELECT ' '
--TOP
