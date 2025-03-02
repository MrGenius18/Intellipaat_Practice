-- Create ABC Fashion Database and use this Database 
create database ABC_Fashion;
use ABC_Fashion;
-- =============================================

-- Salesman table creation & record insertion 
CREATE TABLE Salesman (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT);

INSERT INTO Salesman 
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);
-- =============================================

-- Customer table creation & record insertion
CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT);

INSERT INTO Customer
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);
-- =============================================

-- Orders table Creation & record insertion
CREATE TABLE Orders (
	OrderId int, 
	CustomerId int, 
	SalesmanId int, 
	Orderdate Date, 
	Amount money);

INSERT INTO Orders 
Values 
	(5001,2345,101,'2021-07-01',550),
	(5003,1234,105,'2022-02-15',1500);
-- =============================================

-- execute all tables 
select  * from Salesman;
select * from Customer;
select * from Orders;
-- ==============================================

--  Insert a new record in your Orders table. 
insert into Orders 
values 
	(5004, 4004, 103, GETDATE(), 1280);
-- ==============================================

-- Add Primary key constraint for SalesmanId column in Salesman table. 
ALTER TABLE Salesman 
ALTER COLUMN SalesmanId 
	INT NOT NULL;

ALTER TABLE Salesman 
ADD CONSTRAINT PK_SalesmanId 
	PRIMARY KEY (SalesmanId);
-- ==============================================

-- Add default constraint for City column in Salesman table. 
ALTER TABLE Salesman
ADD CONSTRAINT DF_City 
	DEFAULT 'New York' FOR City;
-- ==============================================

-- Add Foreign key constraint for SalesmanId column in Customer table. 
-- identify conflict
select distinct SalesmanId from Customer
where SalesmanId not in (select SalesmanId from Salesman);

-- handle conflict
insert into Salesman
values
	(107, 'unknown', 0, 'unknown', 0),
	(110, 'unknown', 0, 'unknown', 0);

alter table Customer
add constraint FK_SalesmanId
	Foreign key (SalesmanId)
	References Salesman(SalesmanId);
-- ==============================================

-- Add not null constraint in Customer_name column for the Customer table.
ALTER TABLE Customer
ALTER COLUMN CustomerName 
	VARCHAR(255) NOT NULL;
-- ===============================================

-- Fetch the data where the Customer’s name is ending with ‘N’ 
-- also get the purchase amount value greater than 500.
select * from Customer
where CustomerName like '%n' and PurchaseAmount>500;
-- ===============================================

-- Using SET operators, 
-- retrieve the first result with unique SalesmanId values from two tables, 
select SalesmanId from Salesman
union
select SalesmanId from Orders;

-- and the other result containing SalesmanId with duplicates from two tables.
select SalesmanId from Salesman
union all
select SalesmanId from Orders;
-- ===============================================

-- Display the below columns which has the matching data.
-- Orderdate, Salesman Name, Customer Name, Commission, and City 
-- which has the range of Purchase Amount between 500 to 1500.
select O.Orderdate, S.Name as Salesman, C.CustomerName, S.Commission, S.City
FROM Salesman AS S
JOIN Customer AS C ON C.SalesmanId = S.SalesmanId
JOIN Orders AS O ON O.CustomerId = C.CustomerId
where C.PurchaseAmount between 500 and 1500;
-- ===============================================

-- Using right join fetch all the results from Salesman and Orders table.
SELECT * FROM Salesman AS S 
RIGHT JOIN Orders AS O
	ON O.SalesmanId = S.SalesmanId;
-- ===============================================