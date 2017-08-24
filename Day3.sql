use Dafesty
go
               --DML
			   --INSERT,UPDATE,DELETE
--Create Table
CREATE TABLE GoodCustomers
(CustomerID      nvarchar(4)  not null,
 CustomerName    nvarchar(50) not null,
 Address         nvarchar(65) not null,
 PhoneNumber     nvarchar(9),
 MemberCategory  nvarchar(2)  not null,
 PRIMARY KEY (CustomerID,MemberCategory))
--INSERT Statment
/*
INSERT INTO table-name (column-name)
VALUES([constant,NULL])
*/
  --Single-Row Insert (Without Column Names)
INSERT INTO ProducerWebSite
VALUES ('Columbia', 'www.Columbia.com')
  --Single-Row Insert (With Column Names)
INSERT INTO GoodCustomers
(CustomerID,CustomerName,Address, MemberCategory)
VALUES (9000,'Grace Leong','15 Bukit Purmei Road, Singapore 0904','A')
  --Insert using a Query (INSERT INTO¡K SELECT¡K FROM¡K )
INSERT INTO GoodCustomers
(CustomerID,CustomerName,Address,PhoneNumber,MemberCategory)
SELECT
CustomerID,CustomerName,Address,PhoneNumber,MemberCategory
FROM Customers
WHERE MemberCategory in ('A','B')
--UPDATE
/*
UPDATE table-name
SET (column-name=expression)
WHERE search-condition
*/
  --Selective Update
UPDATE GoodCustomers
SET PhoneNumber = 7775588
WHERE CustomerName = 'Grace Leong'
  --Update all rows
UPDATE GoodCustomers
SET PhoneNumber = 7775588
  --Update with Subquery
UPDATE GoodCustomers
SET PhoneNumber = 7775588
WHERE CustomerID in (SELECT CustomerID 
                     FROM Customers
                     WHERE MemberCategory ='B')
--DELETE
/*
DELETE FROM table-name
WHERE search-condition
*/
  --Delete Selected Rows
DELETE FROM GoodCustomers
WHERE MemberCategory = 'B'
  --Delete All Rows
DELETE FROM GoodCustomers
  --Delete Rows with Subquery
DELETE FROM GoodCustomers
WHERE CustomerID in (SELECT CustomerID 
                     FROM Customers
                     WHERE MemberCategory = 'A')

           --DDL
		   --CREATE,ALTER,DROP
--Create
  --Create Table
    --Example1
CREATE TABLE GoodCustomers2
(CustomerID      nvarchar(4)  not null,
 CustomerName    nvarchar(50) not null,
 Address         nvarchar(65) not null,
 PhoneNumber     nvarchar(9),
 MemberCategory  nvarchar(2)  not null,
 PRIMARY KEY (CustomerID,MemberCategory))
    --Example2 (with foreign key definition) 
 ALTER TABLE Producers ADD PRIMARY KEY (Producer);--Producr should be Primary Key

 CREATE TABLE ProducerWebSite2
(Producer nvarchar(50) not null,
 WebSite varchar(200) not null,
 PRIMARY KEY(Producer),
 FOREIGN KEY (Producer) REFERENCES Producers (Producer))
     --Example3 Alternative syntax (indicating constraint name) 
 CREATE TABLE ProducerWebSite3
(Producer nvarchar(50) not null,
WebSite   varchar(200) not null,
PRIMARY KEY(Producer),
CONSTRAINT ProducerWS_FK_1 FOREIGN KEY (Producer) REFERENCES Producers(Producer))

    --Create Index
	/*
	CREATE [UNIQUE] INDEX index-name
	ON table-name(column name)
	*/
  --1)
CREATE UNIQUE INDEX gdCust_idx ON GoodCustomers(PhoneNumber)
  --2)
CREATE UNIQUE INDEX gdCust_idx ON GoodCustomers(CustomerID,CustomerName)
  --3)
CREATE INDEX Cust_idx ON Customers(Address)

--DROP
/*
DROP table-name
DROP index-name ON table-name     
*/
  --DROP table
DROP TABLE GoodCustomers
  --DROP index
DROP INDEX Cust_idx ON GoodCustomers
--ALTER
/*
ALTER TABLE table-name
      ADD  column-name data-type
	  DROP column-name
	  ALTER COLUMN column-name column-type
	  ADD UNIQE
	  ADD PRIMARY KEY key-name
	  ADD FOREIGN KEY key-name REFERENCES table-name (colum-name)
	  DROP PRIMARY KEY
	  DROP FOREIGN KEY
	  DROP CHECK
*/

