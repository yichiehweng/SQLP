--DDL DML Workshop
use Dafesty
go

--1
CREATE TABLE Member_Categories 
(
 MemberCategory       nvarchar(2)   not null,
 MemberCatDescription nvarchar(200) not null,
 PRIMARY KEY (MemberCategory)
)

SELECT *
FROM Member_Categories

--2
INSERT INTO Member_Categories
VALUES ('A', 'Class A Members'),
       ('B', 'Class B Members'),
       ('C', 'Class C Members')

SELECT *
FROM Member_Categories

--3
CREATE TABLE GoodCustomers 
(
   CustomerName   nvarchar(50)  NOT NULL,
   Address        nvarchar(65),
   PhoneNumber    nvarchar(9)   NOT NULL,
   MemberCategory nvarchar(2)   
   PRIMARY KEY (CustomerName,PhoneNumber),
   FOREIGN KEY (MemberCategory) REFERENCES Member_Categories (MemberCategory)
)

SELECT *
FROM GoodCustomers

--4
INSERT INTO GoodCustomers
(CustomerName,Address,PhoneNumber,MemberCategory)
SELECT
CustomerName,' ',PhoneNumber,MemberCategory
FROM Customers
WHERE MemberCategory in ('A','B')

SELECT *
FROM GoodCustomers

--5
INSERT INTO GoodCustomers
VALUES('Tracy Tan',' ','736572','B')

SELECT *
FROM GoodCustomers

--6
INSERT INTO GoodCustomers
VALUES('Grace Leong','15 Bukit Purmei Road, Singapore 0904','278865','A')

SELECT *
FROM GoodCustomers
--7
--INSERT INTO GoodCustomers
--VALUES('Lynn Lim','15 Bukit Purmei Road, Singapore 0904','278865','P')

--8
UPDATE GoodCustomers
SET Address = '22 Bukit Purmei Road, Singapore 0904'
WHERE CustomerName = 'Grace Leong'
SELECT *
FROM GoodCustomers

--9
/*
ALTER TABLE GoodCustomers
ADD CustomerID nvarchar(4); 

ALTER TABLE GoodCustomers
DROP Column  CustomerID; 

SELECT *
FROM GoodCustomers
*/

UPDATE GoodCustomers
SET MemberCategory = 'B'
WHERE CustomerName = (SELECT CustomerName
                     FROM Customers
					 WHERE CustomerID='5108') 
SELECT *
FROM GoodCustomers

--10
DELETE FROM GoodCustomers
WHERE CustomerName='Grace Leong'

SELECT *
FROM GoodCustomers

--11
DELETE FROM GoodCustomers
WHERE MemberCategory='B'

SELECT *
FROM GoodCustomers

--12
ALTER TABLE GoodCustomers
ADD FaxNumber nvarchar(25); 
SELECT *
FROM GoodCustomers

--13
ALTER TABLE GoodCustomers
ALTER Column Address nvarchar(5); 
SELECT *
FROM GoodCustomers

SELECT Address
FROM GoodCustomers
WHERE  CustomerName = 'Grace Leong'

--14
ALTER TABLE GoodCustomers
ADD ICNumber nvarchar(10); 
SELECT *
FROM GoodCustomers

ALTER TABLE GoodCustomers
DROP Column ICNumber; 


--15
--ALTER TABLE GoodCustomers
--ADD UNIQUE (ICNumber)

--16
CREATE UNIQUE INDEX FaxNumber ON GoodCustomers(FaxNumber)

--17
DROP INDEX FaxNumber ON GoodCustomers
--18
ALTER TABLE GoodCustomers
DROP Column FaxNumber; 

SELECT *
FROM GoodCustomers

--19
DELETE FROM GoodCustomers

SELECT *
FROM GoodCustomers

--20
DROP TABLE GoodCustomers
DROP TABLE Member_Categories


