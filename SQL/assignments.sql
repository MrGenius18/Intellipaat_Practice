create database Assignment;
use Assignment;
-- use master;
-- drop database Assignment;
------------------ Assignment 2 -----------------------------------

-- Q1. Create a customer table which comprises of these columns: 
-- ‘customer_id’, ‘first_name’, ‘last_name’, ‘email’, ‘address’, ‘city’,’state’,’zip’
create table customer(
	customer_id int Primary key,
	first_name varchar(50) not null,
	last_name varchar(50), 
	email varchar(50),
	address varchar(350),
	city varchar(50),
	state varchar(50),
	zip int);

select * from customer;

-- Q2. Insert 5 new records into the table 
insert into customer
values 
	(1, 'John', 'Doe', 'john.doe@email.com', '123 Main St', 'New York', 'NY', 10001),
    (2, 'Jane', 'Smith', 'jane.smith@email.com', '456 Oak St', 'Los Angeles', 'CA', 90001),
    (3, 'Michael', 'Johnson', 'michael.j@gmail.com', '789 Pine St', 'Chicago', 'IL', 60601),
    (4, 'Emily', 'Davis', 'emily.davis@email.com', '101 Maple Ave', 'Houston', 'TX', 77001),
    (5, 'David', 'Brown', 'david.brown@gmail.com', '202 Birch Rd', 'New York', 'FL', 33101);

select * from customer;

-- Q3. Select only the ‘first_name’ and ‘last_name’ columns from the customer table
select first_name, last_name from customer;

-- Q4. Select those records where ‘first_name’ starts with “J” and city is ‘New York’.
select * from customer
where first_name like 'J%' and city = 'New York';

-- Q5. Select those records where Email has only ‘gmail’.
select * from customer
where email like '%gmail%';

-- Q6. Select those records where the ‘last_name’ doesn't end with “n”.
select * from customer
where last_name not like '%n';


------------------ Assignment 3 -----------------------------------

-- 1. Create an ‘Orders’ table which comprises of these columns: ‘order_id’, ‘order_date’, ‘amount’, ‘customer_id’.
create table Orders(
	order_id int primary key,
	order_date date,
	amount float,
	cutomer_id int);

select * from Orders;

-- 2. Insert 5 new records.
insert into Orders
values (101, '2024-01-12', 500, 1),
	   (102, '2024-03-24', 5000, 2),
	   (103, '2025-02-17', 8000, 3),
	   (104, '2024-06-05', 2230, 2),
	   (105, '2025-12-31', 200, 3);

select * from Orders;

-- 3. Make an inner join on ‘Customer’ and ‘Orders’ tables on the ‘customer_id’ column.
select c.customer_id, c.first_name, c.last_name, c.city, 
		o.order_id, o.order_date, o.amount
from customer as c
inner join Orders as o
on c.customer_id = o.cutomer_id;

-- 4. Make left and right joins on ‘Customer’ and ‘Orders’ tables on the ‘customer_id’ column.
select c.customer_id, c.first_name, c.last_name, c.city, 
		o.order_id, o.order_date, o.amount
from customer as c
left join Orders as o
on c.customer_id = o.cutomer_id;

select c.customer_id, c.first_name, c.last_name, c.city, 
		o.order_id, o.order_date, o.amount
from customer as c
right join Orders as o
on c.customer_id = o.cutomer_id;

-- 5. Make a full outer join on ‘Customer’ and ‘Orders’ table on the ‘customer_id’ column.
select c.customer_id, c.first_name, c.last_name, c.city, 
		o.order_id, o.order_date, o.amount
from customer as c
full outer join Orders as o
on c.customer_id = o.cutomer_id;

-- 6. Update the ‘Orders’ table and set the amount to be 100 where ‘customer_id’ is 3.
update Orders
set amount = 100
where cutomer_id = 3;

select * from Orders;


------------------ Assignment 4 -----------------------------------

--  1. Use the inbuilt functions and find the minimum, maximum and average amount from the orders table
select min(amount) as min_amount,
	   max(amount) as max_amount,
	   avg(amount) as avg_amount
from Orders;

-- 2. Create a user-defined function which will multiply the given number with 10.
-- DROP FUNCTION IF EXISTS multiply_by_10;
create function multiply_by_10 (@number int)
returns int
as 
begin 
	return @number * 10;
end;

select dbo.multiply_by_10(5);

-- 3. Use the case statement to check if 100 is less than 200, greater than 200 or equal to 200 and print the corresponding value.
select
case 
	when 100 < 200 then '100 is less than 200'
	when 100 > 200 then '100 is greater than 200'
	else '100 is  equal to 200'
end as result;

-- 4. Using a case statement, find the status of the amount. 
-- Set the status of the amount as high amount, low amount or medium amount based upon the condition.
select *,
case 
	when amount < 500 then 'Low'
	when amount > 1000 then 'High'
	else 'Medium' 
end as Status
from Orders;

-- 5. Create a user-defined function, to fetch the amount greater than then given input.
-- drop function if exists fetch_amount_greater_than;
create function fetch_amount_greater_than (@input int)
returns table
as 
return (
	select * from Orders
	where amount > @input);

select * from dbo.fetch_amount_greater_than(500);


------------------ Assignment 5 -----------------------------------

--  1. Arrange the ‘Orders’ dataset in decreasing order of amount
select * from Orders order by amount desc;

-- 2. Create a table with the name ‘Employee_details1’ consisting of these columns: ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. 
-- Create another table with the name ‘Employee_details2’ consisting of the same columns as the first table.
create table Employee_details1(
	Emp_id int primary key,
	Emp_name varchar(50),
	Emp_salary int);

create table Employee_details2(
	Emp_id int primary key,
	Emp_name varchar(50),
	Emp_salary int);

insert into Employee_details1
values (1, 'Bhautik', 80000),
	   (2, 'Raj', 25000),
	   (3, 'Pinjal', 70000),
	   (4, 'Babita', 5000),
	   (5, 'Maan', 65000);

insert into Employee_details2
values (1, 'Bhautik', 80000),
	   (2, 'Sharmistha', 25000),
	   (3, 'Pinjal', 70000),
	   (4, 'Babita', 5000),
	   (5, 'Daya', 5000);

select * from Employee_details1;
select * from Employee_details2;

-- 3. Apply the UNION operator on these two tables
select * from Employee_details1
union
select * from Employee_details2;

-- 4. Apply the INTERSECT operator on these two tables
select * from Employee_details1
intersect
select * from Employee_details2;

-- 5. Apply the EXCEPT operator on these two tables
select * from Employee_details1
except
select * from Employee_details2;


------------------ Assignment 6 -----------------------------------

--  1. Create a view named ‘customer_New_York’ which comprises of only those customers who are from New York
-- drop view if exists customer_New_York;
create view customer_New_York as
select * from customer
where city = 'New York';

select * from dbo.customer_New_York;

-- 2. Inside a transaction, update the first name of the customer to Francis where the last name is Brown:
--		a. Rollback the transaction
--		b. Set the first name of customer to Alex, where the last name is Doe
begin transaction;
	update customer
	set first_name = 'Francis'
	where last_name  = 'Brown';
rollback;

begin transaction;
	update customer
	set first_name = 'Alex'
	where last_name = 'Doe';
commit;

select * from customer;

-- 3. Inside a TRY... CATCH block, divide 100 with 0, print the default error message
begin try
	select 100/0;
end try

begin catch
	print ERROR_MESSAGE();
end catch;

-- 4. Create a transaction to insert a new record to Orders table and save it.
begin transaction;
insert into Orders values (106, convert(date,  getdate()), 2000, 4);
commit;

select * from Orders;