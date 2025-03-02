------- create database -------
-- drop database if exists case_study_2;
create database case_study_2;
use case_study_2;
-------------------------------


------- Create Tables -------
------- create LOCATION tables -------
-- drop table if exists LOCATION;
CREATE TABLE LOCATION (
	Location_ID INT PRIMARY KEY,
	City VARCHAR(50));

INSERT INTO LOCATION
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');
-------------------------------

------- create DEPARTMENT tables -------
-- drop table if exists DEPARTMENT;
CREATE TABLE DEPARTMENT (
	Department_Id INT PRIMARY KEY,
	Name VARCHAR(50),
	Location_Id INT FOREIGN KEY REFERENCES LOCATION(Location_ID));

INSERT INTO DEPARTMENT
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);
-------------------------------

------- create JOB tables -------
-- drop table if exists JOB;
CREATE TABLE JOB (
	Job_ID INT PRIMARY KEY,
	Designation VARCHAR(50));

INSERT INTO JOB 
VALUES  (667, 'CLERK'),
		(668,'STAFF'),
		(669,'ANALYST'),
		(670,'SALES_PERSON'),
		(671,'MANAGER'),
		(672, 'PRESIDENT');
-------------------------------

------- create EMPLOYEE tables -------
-- drop table if exists EMPLOYEE;
CREATE TABLE EMPLOYEE (
	EMPLOYEE_ID INT,
	LAST_NAME VARCHAR(20),
	FIRST_NAME VARCHAR(20),
	MIDDLE_NAME CHAR(1),
	JOB_ID INT FOREIGN KEY REFERENCES JOB(JOB_ID),
	MANAGER_ID INT,
	HIRE_DATE DATE,
	SALARY INT,
	COMM INT,
	DEPARTMENT_ID  INT FOREIGN KEY REFERENCES DEPARTMENT(DEPARTMENT_ID));

INSERT INTO EMPLOYEE 
VALUES  (7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
		(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
		(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
		(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
		(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
		(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30);
-------------------------------
-------------------------------


------- view all table -------
select * from LOCATION;
select * from DEPARTMENT;
select * from JOB;
select * from EMPLOYEE;
-------------------------------


------- Simple Queries -------
-- 1. List out the First Name, Last Name, Salary, Commission for all Employees. 
select 
	FIRST_NAME, LAST_NAME, SALARY, COMM
from EMPLOYEE;
--------------------------------------

-- 2. List out the Employee ID, Last Name, Department ID for all employees and alias 
--    Employee ID as "ID of the Employee", Last Name as "Name of the  Employee", Department ID as "Dep_id".
select 
	EMPLOYEE_ID as ID_of_the_Employee, 
	LAST_NAME as Name_of_the_Employee, 
	DEPARTMENT_ID as Dep_id
from EMPLOYEE;
--------------------------------------

-- 3. List out the annual salary of the employees with their names only. 
select 
	FIRST_NAME, SALARY 
from EMPLOYEE;
--------------------------------------
--------------------------------------


------- WHERE Condition -------
-- 1. List the details about "Smith".
select * 
from EMPLOYEE 
where LAST_NAME = 'SMITH';
--------------------------------------

-- 2. List out the employees who are working in department 20. 
select * 
from EMPLOYEE 
where DEPARTMENT_ID = 20;
--------------------------------------

-- 3. List out the employees who are earning salary between 2000 and 3000.
select * 
from EMPLOYEE 
where SALARY between 2000 and 3000;
-------------------------------------- 

-- 4. List out the employees who are working in department 10 or 20. 
select * from EMPLOYEE 
where DEPARTMENT_ID in (10, 20);
--------------------------------------

-- 5. Find out the employees who are not working in department 10 or 30. 
select * 
from EMPLOYEE 
where DEPARTMENT_ID not in (10, 30);
--------------------------------------

-- 6. List out the employees whose name starts with 'L'. 
select * 
from EMPLOYEE 
where FIRST_NAME like 'L%';
--------------------------------------

-- 7. List out the employees whose name starts with 'L' and ends with 'E'. 
select * 
from EMPLOYEE 
where FIRST_NAME like 'L%E';
--------------------------------------

-- 8. List out the employees whose name length is 4 and start with 'J'. 
select * 
from EMPLOYEE 
where len(FIRST_NAME) = 4 and FIRST_NAME like 'J%';
--------------------------------------

-- 9. List out the employees who are working in department 30 and draw the salaries more than 2500. 
select * 
from EMPLOYEE 
where DEPARTMENT_ID = 30 and SALARY > 2500;
--------------------------------------

-- 10. List out the employees who are not receiving commission. 
select * 
from EMPLOYEE 
where COMM is null;
--------------------------------------
--------------------------------------


------- ORDER BY Clause -------
-- 1. List out the Employee ID and Last Name in ascending order based on the Employee ID. 
select EMPLOYEE_ID, LAST_NAME 
from EMPLOYEE 
order by EMPLOYEE_ID;
-------------------------------------- 

-- 2. List out the Employee ID and Name in descending order based on salary.  
select EMPLOYEE_ID, FIRST_NAME 
from EMPLOYEE 
order by SALARY desc;
--------------------------------------

-- 3. List out the employee details according to their Last Name in ascending-order.  
select * 
from EMPLOYEE 
order by LAST_NAME;
--------------------------------------

-- 4. List out the employee details according to their Last Name in ascending order 
--	  and then Department ID in descending order. 
select * 
from EMPLOYEE 
order by LAST_NAME, DEPARTMENT_ID desc;
--------------------------------------
--------------------------------------


------- GROUP BY and HAVING Clause -------
-- 1. List out the department wise maximum salary, minimum salary and average salary of the employees. 
select 
	DEPARTMENT_ID, 
	max(salary) as max_salaray, 
	min(salary) as min_salary, 
	avg(salary) as avg_salary 
from EMPLOYEE
group by DEPARTMENT_ID;
--------------------------------------

-- 2. List out the job wise maximum salary, minimum salary and average salary of the employees. 
select 
	JOB_ID,
	max(salary) as max_salary,
	min(salary) as min_salary,
	avg(salary) as avg_salary
from EMPLOYEE
group by JOB_ID;
--------------------------------------

-- 3. List out the number of employees who joined each month in ascending order. 
select 
	count(distinct EMPLOYEE_ID) as number_of_emp,
	MONTH(HIRE_DATE) as month
from EMPLOYEE
group by MONTH(HIRE_DATE)
order by month;
--------------------------------------

-- 4. List out the number of employees for each month and year in ascending order based on the year and month. 
select 
	count(distinct EMPLOYEE_ID) as no_of_emp,
	YEAR(HIRE_DATE) as year,
	MONTH(HIRE_DATE) as month
from EMPLOYEE
group by YEAR(HIRE_DATE), MONTH(HIRE_DATE)
order by year, month;
--------------------------------------

-- 5. List out the Department ID having at least four employees. 
select 
	DEPARTMENT_ID,
	count(distinct EMPLOYEE_ID) as no_of_emp
from EMPLOYEE
group by DEPARTMENT_ID
having count(distinct EMPLOYEE_ID) >= 4;
--------------------------------------

-- 6. How many employees joined in February month. 
select 
	count(distinct EMPLOYEE_ID) as no_of_emp_join_in_fab
from EMPLOYEE
group by month(HIRE_DATE)
having month(HIRE_DATE) = 2;
--------------------------------------

-- 7. How many employees joined in May or June month. 
select 
	count(distinct EMPLOYEE_ID) as no_of_emp_join,
	month(HIRE_DATE) as month
from EMPLOYEE
group by month(HIRE_DATE)
having month(HIRE_DATE) IN (5, 6);
--------------------------------------

-- 8. How many employees joined in 1985? 
select 
	count(distinct EMPLOYEE_ID) as emp_join_in_1985
from EMPLOYEE
group by year(HIRE_DATE)
having year(HIRE_DATE) = 1985;
--------------------------------------

-- 9. How many employees joined each month in 1985? 
select 
	count(distinct EMPLOYEE_ID) as emp_join_in_1985,
	month(HIRE_DATE) as month
from EMPLOYEE
group by year(HIRE_DATE), month(HIRE_DATE)
having year(HIRE_DATE) = 1985;
--------------------------------------

-- 10. How many employees were joined in April 1985? 
select  
	count(distinct EMPLOYEE_ID) as emp_join_april_1985
from EMPLOYEE
group by year(HIRE_DATE), month(HIRE_DATE)
having year(HIRE_DATE) = 1985 and month(HIRE_DATE) = 4;
--------------------------------------

-- 11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985? 
select 
	DEPARTMENT_ID,
	count(distinct EMPLOYEE_ID) as emp_join_april_1985
from EMPLOYEE
group by DEPARTMENT_ID, year(HIRE_DATE), month(HIRE_DATE)
having year(HIRE_DATE) = 1985 and month(HIRE_DATE) = 4 and count(distinct EMPLOYEE_ID) >=3;
--------------------------------------
--------------------------------------


------- Joins -------
-- 1. List out employees with their department names. 
select 
	e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.SALARY, 
	d.Name
from EMPLOYEE as e
left join DEPARTMENT as d on d.Department_Id = e.DEPARTMENT_ID;
--------------------------------------

-- 2. Display employees with their designations. 
select 
	e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.SALARY, 
	j.Designation
from EMPLOYEE as e
left join JOB as j on j.Job_ID = e.Job_ID;
--------------------------------------

-- 3. Display the employees with their department names and city. 
select 
	e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.SALARY, 
	d.Name, 
	l.City
from EMPLOYEE as e
left join DEPARTMENT as d on e.DEPARTMENT_ID = d.Department_Id
join LOCATION as l on l.Location_ID = d.Location_Id;
--------------------------------------

-- 4. How many employees are working in different departments? Display with department names. 
select 
	d.Name as dep_name,
	count(e.EMPLOYEE_ID) as no_of_emp
from EMPLOYEE as e
right join DEPARTMENT as d on d.Department_Id = e.DEPARTMENT_ID
group by d.Name;
--------------------------------------

-- 5. How many employees are working in the sales department? 
select 	
	count(e.EMPLOYEE_ID) as no_of_emp_in_sales_dep
from EMPLOYEE as e
right join DEPARTMENT as d on d.Department_Id = e.DEPARTMENT_ID
group by d.Name
having d.Name in ('Sales');
--------------------------------------

-- 6. Which is the department having greater than or equal to 3 employees and 
-- display the department names in ascending order. 
select 
	d.Name,
	count(e.EMPLOYEE_ID) as no_of_emp
from EMPLOYEE as e
join DEPARTMENT as d on d.Department_Id=e.DEPARTMENT_ID
group by d.Name
having count(e.EMPLOYEE_ID) >= 3
order by d.Name;
--------------------------------------

-- 7. How many employees are working in 'Dallas'? 
select 
	count(e.EMPLOYEE_ID) as no_of_emp_work_in_Dallas 
from EMPLOYEE as e
join DEPARTMENT as d on d.Department_Id=e.DEPARTMENT_ID
join LOCATION as l on l.Location_ID=d.Location_Id
group by l.City
having l.City in ('DAllas');
--------------------------------------

-- 8. Display all employees in sales or operation departments.
select 
	e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.SALARY,
	d.Name
from EMPLOYEE as e
join DEPARTMENT as d on d.Department_Id=e.DEPARTMENT_ID
where d.Name in ('sales', 'operations');
--------------------------------------
--------------------------------------


------- CONDITIONAL STATEMENT -------
-- 1. Display the employee details with salary grades. Use conditional statement to create a grade column. 
select 
	EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY,
	case
		when SALARY > 2000 then 'A'
		when SALARY > 1000 then 'B'
		else 'C'
	end as salary_grade
from EMPLOYEE;
--------------------------------------

-- 2. List out the number of employees grade wise. Use conditional statement to create a grade column. 
select 
	salary_grade,
	count(EMPLOYEE_ID) as no_of_emp
from (
	select *,
		case
			when SALARY > 2000 then 'A'
			when SALARY > 1000 then 'B'
			else 'C'
		end as salary_grade
	from EMPLOYEE) as sub_query
group by salary_grade;
--------------------------------------

-- 3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
select 
	Grade,
	count(EMPLOYEE_ID) as no_of_emp_btw_2to5k
from (
	select *,
		case
			when SALARY>2000 then 'A'
			when SALARY>1000 then 'B'
			else 'C'
		end as Grade
	from EMPLOYEE
	where SALARY between 2000 and 5000) as sub_query
group by Grade;
--------------------------------------
--------------------------------------


------- Subqueries -------
-- 1. Display the employees list who got the maximum salary. 
select * 
from EMPLOYEE
where SALARY in (select max(SALARY) from EMPLOYEE);
--------------------------------------

-- 2. Display the employees who are working in the sales department. 
select *
from EMPLOYEE
where DEPARTMENT_ID in (select DEPARTMENT_ID from DEPARTMENT 
						where Name in ('Sales'));
--------------------------------------

-- 3. Display the employees who are working as 'Clerk'. 
select * 
from EMPLOYEE
where JOB_ID in (select JOB_ID from JOB 
				where Designation in ('Clerk'));
--------------------------------------

-- 4. Display the list of employees who are living in 'Boston'. 
select *
from EMPLOYEE
where DEPARTMENT_ID in (select DEPARTMENT_ID from DEPARTMENT 
						where Location_Id in (select Location_Id from LOCATION 
											  where City in ('Boston')));
--------------------------------------

-- 5. Find out the number of employees working in the sales department. 
select 
	count(EMPLOYEE_ID) as no_of_emp_work_on_sales_dep
from EMPLOYEE
where DEPARTMENT_ID in (select DEPARTMENT_ID from DEPARTMENT
						where Name in ('Sales'));
--------------------------------------

-- 6. Update the salaries of employees who are working as clerks on the basis of 10%. 
update EMPLOYEE
set SALARY = SALARY * 1.1
where JOB_ID in (select Job_ID from JOB
				 where Designation in ('CLERK'));

select * from EMPLOYEE;
--------------------------------------

-- 7. Display the second highest salary drawing employee details. 
select top 1 * 
from EMPLOYEE
where SALARY < (select max(SALARY) from EMPLOYEE)
order by SALARY desc;

-- use ranking method
select *
from (
	select 
		*,
		DENSE_RANK() over (order by SALARY desc) as rank
	from EMPLOYEE) as sub_query
where rank = 2;
--------------------------------------

-- 8. List out the employees who earn more than every employee in department 30.
select * 
from EMPLOYEE
where SALARY > (select max(SALARY) from EMPLOYEE
				where DEPARTMENT_ID = 30);
-------------------------------------- 

-- 9. Find out which department has no employees. 
select Name
from DEPARTMENT
where Department_Id not in (select distinct DEPARTMENT_ID from EMPLOYEE);
--------------------------------------

-- 10. Find out the employees who earn greater than the average salary for their department.
select * 
from EMPLOYEE as e
where salary > (select avg(SALARY) from EMPLOYEE
				where DEPARTMENT_ID = e.DEPARTMENT_ID);
--------------------------------------
--------------------------------------