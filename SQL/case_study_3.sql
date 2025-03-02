-- ############ Problem Statement ############
-- You are the database developer of an international bank. 
-- You are responsible for managing the bank’s database. 
-- You want to use the data to answer a few questions about your customers regarding withdrawal, deposit and 
-- so on, especially about the transaction amount on a particular date across various regions of the world. 
-- Perform SQL queries to get the key insights of a customer.
-- #####################################################

-- ############ 3 key datasets ############
-- 1. Continent: region_id, region_name
-- 2. Customers: customer_id, region_id, start_date, end_date
-- 3. Transactions: customer_id, txn_date, txn_type, txn_amount
-- #####################################################

-- ############ create database ############
create database case_study_3;
use case_study_3;
-- #####################################################

-- ############ create Tables & insert data ############
-- convert csv to sql using python code file
-- #####################################################

-- ############ view Tables ############
select * from Continent;
select * from Customers;
select * from Transactions;
-- #####################################################

-- #####################################################
-- 1. Display the count of customers in each region who have done the transaction in the year 2020.
select 	
	r.region_name,
	count(distinct c.customer_id) as no_of_cust_tran_in_2020
from Customers as c
left join Continent as r on r.region_id = c.region_id
where customer_id in (select customer_id from Transactions
					  where YEAR(txn_date) in (2020))
group by  r.region_name;
--------------------------------------------

-- 2. Display the maximum and minimum transaction amount of each transaction type.
select 
	txn_type,
	max(txn_amount) as max_amount,
	min(txn_amount) as min_amount
from Transactions
group by txn_type;
--------------------------------------------

-- 3. Display the customer id, region name and transaction amount 
--    where transaction type is deposit and transaction amount > 900.
select DISTINCT 
	t.customer_id,
	r.region_name,
	t.txn_amount
from Transactions as t
join Customers as c on t.customer_id = c.customer_id
join Continent as r on c.region_id = r.region_id
where t.txn_type in ('deposit') and t.txn_amount > 900
order by t.customer_id;
--------------------------------------------

-- 4. Find duplicate records in the Customer table.
SELECT *, COUNT(*) 
FROM Customers
GROUP BY customer_id, region_id, start_date, end_date
HAVING COUNT(*) > 1;
--------------------------------------------

-- 5. Display the customer id, region name, transaction type and transaction amount 
--    for the minimum transaction amount in deposit.
select DISTINCT 
	t.customer_id,
	r.region_name,
	t.txn_type,
	t.txn_amount
from Transactions as t
join Customers as c on t.customer_id = c.customer_id
join Continent as r on c.region_id = r.region_id
where t.txn_amount = (select min(txn_amount) from Transactions
					  where t.txn_type in ('deposit'));
--------------------------------------------

-- 6. Create a stored procedure to display details of customers in the Transaction table 
--    where the transaction date is greater than march 2020.
-- drop procedure if exists transaction_after_march2020;
create procedure transaction_after_march2020
as
begin
	SELECT 
        t.txn_date,
        t.customer_id,
        c.region_id,
        r.region_name,
        t.txn_type,
        t.txn_amount
    FROM Transactions AS t
    JOIN Customers AS c ON t.customer_id = c.customer_id
    JOIN Continent AS r ON c.region_id = r.region_id
    WHERE t.txn_date > '2020-03-31'
    ORDER BY t.txn_date;
end;
EXEC transaction_after_march2020;
--------------------------------------------
-- #####################################################







































