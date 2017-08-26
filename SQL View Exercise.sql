use Northwind
go
--Exercise Userview 1
CREATE VIEW Customer1998 AS
SELECT e.*,f.ProductName
FROM 
(SELECT c.CustomerID,c.CompanyName, c.ContactName, d.ProductID,d.OrderDate,d.ShipVia
FROM Customers c right join (SELECT a.CustomerID, a.OrderID,a.OrderDate,b.ProductID,a.ShipVia
                             FROM Orders a left join [Order Details] b
                             ON a.OrderID=b.OrderID
                             WHERE YEAR(OrderDate)='1998') d
ON c.CustomerID=d.CustomerID) e left join Products f
ON e.ProductID=f.ProductID 

DROP VIEW Customer1998

--Exercise Userview 2
SELECT a.CompanyName as CustomerName,a.ProductName,b.CompanyName as ShipperName
FROM Customer1998 a left join Shippers b
ON a.ShipVia=b.ShipperID

--Exercise Userview 3
SELECT CustomerID,COUNT(ProductID) AS NumberOfProduct
FROM Customer1998
GROUP BY CustomerID

--Exercise Userview 4
--a)
CREATE VIEW TotalBusinessMadeByCustomer AS
SELECT a.CustomerID,SUM(b.Amount)as TotalBusinessMade
FROM Orders a left join  (SELECT OrderID,(UnitPrice*Quantity) as Amount
                          FROM [Order Details]) b
ON a.OrderID=b.OrderID
GROUP BY a.CustomerID


--b)
SELECT AVG(TotalBusinessMade) AS AverageBusinessMade
FROM TotalBusinessMadeByCustomer

