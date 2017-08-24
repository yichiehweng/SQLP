use [Northwind]
go
/*SQL Query Workshop*/
--1 a) (3)
SELECT *
FROM Shippers;
--1 b) (3)
SELECT *
FROM Shippers
ORDER BY CompanyName;
--2 a) (9)
SELECT FirstName,LastName,Title,BirthDate,City
FROM Employees;
--2 b) (4)
SELECT DISTINCT Title
FROM Employees;
--3 (2)
SELECT *
FROM Orders
WHERE OrderDate='1997-05-19 00:00:00.000';
--4 (9)
SELECT *
FROM Customers
WHERE City='London'OR CITY='Madrid';
--5 (7)
SELECT CustomerID, ContactName
FROM Customers
WHERE Country='UK';
--6 (14)
SELECT OrderID,OrderDate
FROM Orders
WHERE CustomerID='Hanar';
--7 (9)
SELECT TitleOfCourtesy+FirstName+LastName AS qualifiedNames
FROM Employees;
--8 (7)
SELECT Count(*)
FROM(SELECT OrderID,OrderDate
   FROM Orders
    WHERE CustomerID= (SELECT CustomerID 
                       FROM Customers 
				       WHERE CompanyName='Maison Dewey')) as a;
--9 (2)
SELECT *
FROM Products
WHERE ProductName LIKE '%lager%';

--10 (3)
SELECT CustomerID, ContactName
FROM Customers
WHERE CustomerID not in (SELECT CustomerID
                         FROM Orders);

--11 (28.8663)
SELECT AVG(UnitPrice)
FROM Products;

--12 (70)
SELECT DISTINCT City
FROM Customers;

--13 (89)
SELECT COUNT(*)
FROM Customers
WHERE CustomerID IN (SELECT CustomerID
                     FROM Orders);

--14 (23)
SELECT CompanyName, Phone
FROM Customers
WHERE Fax is null;

--15 (135468.59)
SELECT SUM(unitPrice*Quantity)
FROM [Order Details Extended];

--16 (24)
SELECT *
FROM Orders
WHERE CustomerID in (SELECT CustomerID
                     FROM Customers
                     WHERE CompanyName='Alan Out'OR CompanyName='Blone Coy');

--17 (89)
SELECT CustomerID,COUNT(*)as numberOfOrders
FROM Orders
GROUP BY CustomerID;

--18 (17)
SELECT a.CustomerID,a.CompanyName,b.OrderID
FROM Customers a left join Orders b
ON a.CustomerID=b.CustomerID
WHERE a.CustomerID='BONAP'


--19 a) (28)
SELECT *
FROM (SELECT a.CustomerID,CompanyName,Count(OrderID) as NumberOfOrders
      FROM Customers a left join Orders b
      ON a.CustomerID=b.CustomerID
      GROUP BY a.CustomerID,CompanyName) as c
WHERE c.NumberOfOrders>10
ORDER BY NumberOfOrders DESC

--19 b) (1)
SELECT count(OrderID) as OrderCount, c.CustomerID,c.CompanyName
FROM (SELECT b.CustomerID,b.CompanyName,a.OrderID
      FROM orders a right join Customers b
      on a.CustomerID=b.CustomerID) as c
GROUP BY CustomerID,c.CompanyName
HAVING CustomerID='BONAP';
--19 c) (8)
SELECT *
FROM (SELECT count(OrderID) as OrderCount, c.CustomerID,c.CompanyName
      FROM (SELECT b.CustomerID,b.CompanyName,a.OrderID
            FROM orders a, Customers b
            WHERE a.CustomerID=b.CustomerID) as c
      GROUP BY CustomerID,c.CompanyName) as d
WHERE OrderCount> (SELECT count(OrderID) as OrderCount
                   FROM (SELECT b.CustomerID,b.CompanyName,a.OrderID
                         FROM orders a, Customers b
                         WHERE a.CustomerID=b.CustomerID) as c
                   GROUP BY CustomerID,c.CompanyName
                   HAVING CustomerID='BONAP');

SELECT *
FROM (SELECT a.CustomerID,a.CompanyName,count(b.OrderID) as NumberOfOrders
      FROM Customers a left join Orders b
      ON a.CustomerID=b.CustomerID
      GROUP BY a.CustomerID,a.CompanyName) as c
WHERE NumberOfOrders> (SELECT count(OrderID) as OrderCount
                       FROM (SELECT b.CustomerID,b.CompanyName,a.OrderID
                             FROM orders a right join Customers b
                             ON a.CustomerID=b.CustomerID) as c
                       GROUP BY CustomerID,c.CompanyName
                       HAVING CustomerID='BONAP');

--20 a) (24)
SELECT a.ProductID,b.CategoryName, a.ProductName
FROM Products as a right join (SELECT *
                               FROM Categories 
                               WHERE CategoryName='Beverages' or CategoryName='Condiments')as b
on a.CategoryID=b.CategoryID
ORDER BY ProductID,ProductName;
--20 b) (24)
SELECT a.ProductID,b.CategoryName, a.ProductName
FROM Products as a right join (SELECT *
                               FROM Categories 
                               WHERE CategoryName='Beverages' or CategoryName='Condiments')as b
on a.CategoryID=b.CategoryID
ORDER BY ProductID,ProductName;

--21 a) (9)
SELECT COUNT(EmployeeID)
FROM Employees
--21 b) (5)
SELECT COUNT(EmployeeID)
FROM Employees
WHERE Country = 'USA'
--22  (227)
SELECT c.*
FROM (SELECT a.*
      FROM Orders a inner join Shippers b
      ON a.ShipVia=b.ShipperID
      WHERE b.CompanyName='United Package') c inner join Employees d
ON c.EmployeeID=d.EmployeeID
WHERE d.Title='Sales Representative'

--23 
SELECT EmployeeName,(TitleOfCourtesy+FirstName+LastName) as ManagerName
FROM (SELECT  TitleOfCourtesy+FirstName+LastName as EmployeeName, ReportsTo
      FROM Employees) a left join Employees b
on  a.ReportsTo=b.EmployeeID

--24
SELECT Distinct Top 5 OrderID,ProductID,DiscountAmount
FROM (SELECT OrderID,ProductID,(UnitPrice*Discount) as DiscountAmount
      FROM [Order Details])as a
ORDER BY DiscountAmount DESC 

--25 (77)
SELECT CompanyName
FROM Customers
WHERE City not in  (SELECT Distinct City
                   FROM Suppliers)

--26 (14)
SELECT a.City
FROM Customers a inner join Suppliers b
on a.City=b.City

--27 a) (121)
SELECT CompanyName,Address,Phone
FROM Customers
UNION
SELECT CompanyName,Address,Phone
FROM Suppliers

--27 b)
SELECT CompanyName,Address,Phone
FROM Customers
UNION
SELECT CompanyName,Address,Phone
FROM Suppliers
UNION
SELECT CompanyName,' ' as Address,Phone
FROM Shippers

--28
SELECT (TitleOfCourtesy+FirstName+LastName) as Manager
FROM (SELECT EmployeeID,ReportsTo
      FROM Employees
      WHERE EmployeeID=(SELECT EmployeeID
                        FROM Orders
                        WHERE OrderID='10248')) as a, Employees as b
WHERE a.ReportsTo=b.EmployeeID

--29 (25)
SELECT ProductID,ProductName,UnitPrice
FROM Products
WHERE UnitPrice> (SELECT AVG(UnitPrice) as AveragePrice
                  FROM Products)

--30 (6)
SELECT OrderID,Amount 
FROM (SELECT *,(UnitPrice*Quantity)as Amount
      FROM [Order Details]) as a
WHERE Amount>10000

--31
SELECT b.*,c.CustomerID
FROM (SELECT OrderID,Amount 
      FROM (SELECT *,(UnitPrice*Quantity)as Amount
      FROM [Order Details]) as a
      WHERE Amount>10000) as b LEFT JOIN Orders c
ON b.OrderID=c.OrderID

--32
SELECT d.*,e.CompanyName
FROM (SELECT b.*,c.CustomerID
      FROM (SELECT OrderID,Amount 
            FROM (SELECT *,(UnitPrice*Quantity)as Amount
                  FROM [Order Details]) as a
            WHERE Amount>10000) as b LEFT JOIN Orders c
       ON b.OrderID=c.OrderID) as d LEFT JOIN Customers as e
ON d.CustomerID=e.CustomerID

--33
SELECT CustomerID,sum(Amount) as CustomerAmount
FROM  (SELECT d.*,e.CompanyName
       FROM (SELECT b.*,c.CustomerID
             FROM (SELECT OrderID,Amount 
                   FROM (SELECT *,(UnitPrice*Quantity)as Amount
                         FROM [Order Details]) as a
                   ) as b LEFT JOIN Orders c
                   ON b.OrderID=c.OrderID) as d LEFT JOIN Customers as e
ON d.CustomerID=e.CustomerID) as f
GROUP BY CustomerID

--34
SELECT AVG(Amount) as AvgAmount
FROM  (SELECT d.*,e.CompanyName
       FROM (SELECT b.*,c.CustomerID
             FROM (SELECT OrderID,Amount 
                   FROM (SELECT *,(UnitPrice*Quantity)as Amount
                         FROM [Order Details]) as a
            ) as b LEFT JOIN Orders c
       ON b.OrderID=c.OrderID) as d LEFT JOIN Customers as e
ON d.CustomerID=e.CustomerID) as f

--35
SELECT c.CustomerID,CompanyName
FROM
(SELECT a.OrderID,CustomerID,Amount
FROM
(SELECT OrderID, (UnitPrice*Quantity)as Amount
FROM [Order Details])as a left join Orders as b
on a.OrderID=b.OrderID) as c left join Customers as d
on c.CustomerID=d.CustomerID
WHERE Amount>
(SELECT AVG(Amount) as AvgAmount
FROM  (SELECT d.*,e.CompanyName
       FROM (SELECT b.*,c.CustomerID
             FROM (SELECT OrderID,Amount 
            FROM (SELECT *,(UnitPrice*Quantity)as Amount
            FROM [Order Details]) as a
            ) as b LEFT JOIN Orders c
       ON b.OrderID=c.OrderID) as d LEFT JOIN Customers as e
ON d.CustomerID=e.CustomerID) as f) 

--36
SELECT c.CustomerID,c.Amount
FROM
(SELECT CustomerID,Year(OrderDate) as OrderYear,Amount
FROM (SELECT OrderID, (UnitPrice*Quantity) as Amount
      FROM [Order Details]) as a left join Orders as b
      on a.OrderID=b.OrderID) as c
WHERE c.OrderYear='1997'









