
CREATE DATABASE CASESTUDY2;

USE CASESTUDY2;

CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');

CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20))

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

SELECT*FROM LOCATION;
SELECT*FROM DEPARTMENT;
SELECT*FROM JOB;
SELECT*FROM EMPLOYEE;

--Simple Queries:
--1. List all the employee details.
select*from EMPLOYEE;
--2. List all the department details.
SELECT*FROM DEPARTMENT;
--3. List all job details.
SELECT*FROM JOB;
--4. List all the locations.
SELECT CITY FROM LOCATION;
--5. List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT FIRST_NAME, LAST_NAME, SALARY, COMM AS 'COMMISSION' FROM EMPLOYEE;
--6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee",
--Last Name as "Name of the Employee", Department ID as "Dep_id".
SELECT*FROM LOCATION;
SELECT*FROM DEPARTMENT;
SELECT*FROM JOB;
SELECT*FROM EMPLOYEE;
select EMPLOYEE_ID AS [ID of the Employee], LAST_NAME [Name of the Employee], DEPARTMENT_ID [Dep_id] FROM EMPLOYEE;
--7. List out the annual salary of the employees with their names only.
SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME], SALARY AS [ANNUAL_SALARY] FROM EMPLOYEE;

--WHERE Condition:
--1. List the details about "Smith".
select distinct e.*,j.Designation,d.Name as [Department],l.City as[Work_place] 
from EMPLOYEE e,Location l,job j,DEPARTMENT d where e.JOB_ID = j.JOB_ID 
and e.DEPARTMENT_ID = d.Department_Id and l.Location_ID = d.Location_Id and LAST_NAME = 'Smith';
--2. List out the employees who are working in department 20.
select distinct employee_id, CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME], department_id 
from EMPLOYEE where DEPARTMENT_ID = 20;
--3. List out the employees who are earning salaries between 3000 and 4500.
select CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME], salary from employee where salary between 3000 and 4500;
--4. List out the employees who are working in department 10 or 20.
select distinct CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME], DEPARTMENT_ID 
from employee where DEPARTMENT_ID = 10 or DEPARTMENT_ID = 20;
--5. Find out the employees who are not working in department 10 or 30.
select distinct CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME], DEPARTMENT_ID 
from employee where DEPARTMENT_ID != 10 and DEPARTMENT_ID != 30;
--6. List out the employees whose name starts with 'S'.
select distinct first_name from EMPLOYEE where FIRST_NAME like 'S%';
--7. List out the employees whose name starts with 'S' and ends with 'H'.
SELECT distinct CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME] from EMPLOYEE where FIRST_NAME like 'S%' and LAST_NAME like '%H';
--8. List out the employees whose name length is 4 and start with 'S'.
SELECT FIRST_NAME FROM EMPLOYEE WHERE FIRST_NAME LIKE'S%' AND LEN(FIRST_NAME)=4;
--9. List out employees who are working in department 10 and draw salaries more than 3500.
SELECT distinct CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME],DEPARTMENT_ID, SALARY 
from EMPLOYEE where DEPARTMENT_ID = 10 AND SALARY > 3500;
--10. List out the employees who are not receiving commission.
SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME], COMM AS 'COMMISSION' FROM EMPLOYEE
WHERE COMM IS NULL;
--We need to use IS NULL operator here above.

--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
select Employee_id, last_name from EMPLOYEE order by Employee_id asc;
--It's not compulsory to use ASC keyword everytime when we need to sort in asending order as the default sorting 
--always takes place in ascending only.
--2. List out the Employee ID and Name in descending order based on salary.
select Employee_id, CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME] from EMPLOYEE order by Employee_id desc;
--3. List out the employee details according to their Last Name in ascending-order.
select*from EMPLOYEE order by last_name asc;
--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
select distinct * from EMPLOYEE order by last_name asc, department_id desc;

--GROUP BY and HAVING Clause:
--1. How many employees are in different departments in the organization?
select distinct first_name from EMPLOYEE;
SELECT d.Name as [Department], count(distinct e.employee_id) as [No_of_Employees] 
from EMPLOYEE e, DEPARTMENT d where e.DEPARTMENT_ID = d.Department_Id group by d.Name;
--2. List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT d.Name as [Department], max(e.SALARY) as [max_salary], min(e.SALARY) as [min_salary], avg(e.SALARY) as [avg_salary]
from EMPLOYEE e, DEPARTMENT d where e.DEPARTMENT_ID = d.Department_Id group by d.Name;
--3. List out the job wise maximum salary, minimum salary and average salary of the employees.
select j.designation, max(e.SALARY) as [max_salary], min(e.SALARY) as [min_salary], avg(e.SALARY) as [avg_salary]
from EMPLOYEE e, job j where e.JOB_ID = j.JOB_ID group by j.DESIGNATION;
--4. List out the number of employees who joined each month in ascending order.
select q.Joining_Month, count(q.employee_name) as [No_of_Employees_Joined] 
from (select distinct CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME],
case
	when month(HIRE_DATE) = 1 then 'Jan'
	when month(HIRE_DATE) = 2 then 'Feb'
	when month(HIRE_DATE) = 3 then 'Mar'
	when month(HIRE_DATE) = 4 then 'Apr'
	when month(HIRE_DATE) = 5 then 'May'
	when month(HIRE_DATE) = 6 then 'Jun'
	when month(HIRE_DATE) = 7 then 'Jul'
	when month(HIRE_DATE) = 8 then 'Aug'
	when month(HIRE_DATE) = 9 then 'Sep'
	when month(HIRE_DATE) = 10 then 'Oct'
	when month(HIRE_DATE) = 11 then 'Nov'
	when month(HIRE_DATE) = 12 then 'Dec'
	Else 'Invalid'
end as [Joining_Month]  
from EMPLOYEE)q group by q.Joining_Month order by [No_of_Employees_Joined];
--5. List out the number of employees for each month and year in ascending order based on the year and month.
select q.Joining_Month, q.Hire_year, count(q.employee_name) as [No_of_Employees_Joined]  
from (select distinct CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME],year(hire_date) as [Hire_year],
case
	when month(HIRE_DATE) = 1 then 'Jan'
	when month(HIRE_DATE) = 2 then 'Feb'
	when month(HIRE_DATE) = 3 then 'Mar'
	when month(HIRE_DATE) = 4 then 'Apr'
	when month(HIRE_DATE) = 5 then 'May'
	when month(HIRE_DATE) = 6 then 'Jun'
	when month(HIRE_DATE) = 7 then 'Jul'
	when month(HIRE_DATE) = 8 then 'Aug'
	when month(HIRE_DATE) = 9 then 'Sep'
	when month(HIRE_DATE) = 10 then 'Oct'
	when month(HIRE_DATE) = 11 then 'Nov'
	when month(HIRE_DATE) = 12 then 'Dec'
	Else 'Invalid'
end as [Joining_Month]  
from EMPLOYEE)q group by q.Joining_Month, q.Hire_year order by [No_of_Employees_Joined],q.Hire_year;
--6. List out the Department ID having at least four employees.
select q.department, q.No_of_Employees from (SELECT d.Name as [Department], count(distinct e.employee_id) as [No_of_Employees] 
from EMPLOYEE e, DEPARTMENT d where e.DEPARTMENT_ID = d.Department_Id group by d.Name)q where q.No_of_Employees >= 4;
--7. How many employees joined in the month of January?
select count(EMPLOYEE_ID) as [Emp_no_joined_Jan] from EMPLOYEE where month(hire_date) = 1;
--8. How many employees joined in the month of January or September?
select count(EMPLOYEE_ID) as [Emp_no_joined_Jan_or_sep] from EMPLOYEE where month(hire_date) = 1 or month(hire_date) = 9;
--9. How many employees joined in 1985?
select count(EMPLOYEE_ID) as [Emp_joined_1985] from EMPLOYEE where year(hire_date) = 1985; 
--10. How many employees joined each month in 1985?
select year(e.hire_date) as [Joining_year], q.Joining_Month, count(q.employee_name) as [No_of_Employees_Joined] 
from (select distinct CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME],
case
	when month(HIRE_DATE) = 1 then 'Jan'
	when month(HIRE_DATE) = 2 then 'Feb'
	when month(HIRE_DATE) = 3 then 'Mar'
	when month(HIRE_DATE) = 4 then 'Apr'
	when month(HIRE_DATE) = 5 then 'May'
	when month(HIRE_DATE) = 6 then 'Jun'
	when month(HIRE_DATE) = 7 then 'Jul'
	when month(HIRE_DATE) = 8 then 'Aug'
	when month(HIRE_DATE) = 9 then 'Sep'
	when month(HIRE_DATE) = 10 then 'Oct'
	when month(HIRE_DATE) = 11 then 'Nov'
	when month(HIRE_DATE) = 12 then 'Dec'
	Else 'Invalid'
end as [Joining_Month]  
from EMPLOYEE)q, EMPLOYEE e where year(e.hire_date) = 1985 
group by q.Joining_Month,year(e.HIRE_DATE) order by [No_of_Employees_Joined];
--11. How many employees joined in March 1985?
select count(EMPLOYEE_ID) as [Emp_joined_Mar_1985]from EMPLOYEE where month(HIRE_DATE) = 3 and year(HIRE_DATE) = 1985;
--12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
select q.department_id from (select department_id, month(hire_date) as [Joining_month], year(hire_date) as [Joining_year], count(employee_id) as [Emp_count]
from employee group by department_id, month(hire_date), year(hire_date))q where q.Joining_month = 4 and q.Joining_year = 1985 and q.Emp_count >= 3;

--Joins:
--1. List out employees with their department names.
select distinct concat(e.FIRST_NAME,' ',e.MIDDLE_NAME,' ',e.LAST_NAME) AS [EMPLOYEE_NAME], 
d.Name as [DEPARTMENT] from employee e inner join department d on e.DEPARTMENT_ID = d.Department_Id;
--2. Display employees with their designations.
select*from EMPLOYEE;
select*from DEPARTMENT;
select*from JOB;
select distinct concat(e.FIRST_NAME,' ',e.MIDDLE_NAME,' ',e.LAST_NAME) AS [EMPLOYEE_NAME],
j.DESIGNATION from EMPLOYEE e inner join job j on e.JOB_ID = j.JOB_ID order by j.DESIGNATION; 
--3. Display the employees with their department names and regional groups.
select*from [LOCATION];
select distinct concat(e.FIRST_NAME,' ',e.MIDDLE_NAME,' ',e.LAST_NAME) AS [EMPLOYEE_NAME], d.NAME as [DEPARTMENT], l.CITY as [REGION]
from EMPLOYEE e inner join DEPARTMENT d on e.DEPARTMENT_ID = d.Department_Id inner join [LOCATION] l on d.Location_Id = l.Location_ID;
--4. How many employees are working in different departments? Display with department names.
select d.NAME as [DEPARTMENT], count(e.EMPLOYEE_ID) AS [NO_OF_EMPLOYEES] 
FROM DEPARTMENT d inner join EMPLOYEE e on e.DEPARTMENT_ID = d.Department_Id group by d.NAME order by d.Name;
--5. How many employees are working in the sales department?
select Q.DEPARTMENT, Q.NO_OF_EMPLOYEES FROM (select d.NAME as [DEPARTMENT], count(e.EMPLOYEE_ID) AS [NO_OF_EMPLOYEES] 
FROM DEPARTMENT d inner join EMPLOYEE e on e.DEPARTMENT_ID = d.Department_Id group by d.NAME)Q WHERE Q.DEPARTMENT = 'Sales';
--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.
select Q.DEPARTMENT, Q.NO_OF_EMPLOYEES FROM (select d.NAME as [DEPARTMENT], count(e.EMPLOYEE_ID) AS [NO_OF_EMPLOYEES] 
FROM DEPARTMENT d inner join EMPLOYEE e on e.DEPARTMENT_ID = d.Department_Id group by d.NAME)Q where Q.NO_OF_EMPLOYEES >= 5 
ORDER BY Q.DEPARTMENT;
--7. How many jobs are there in the organization? Display with designations.
select row_number()over(order by job_id asc)SL_No, DESIGNATION, JOB_ID from job;
--8. How many employees are working in "New York"?
select*from LOCATION;
select*from EMPLOYEE;
select*from DEPARTMENT;
SELECT COUNT(Q.EMPLOYEE_NAME) AS [EMP_IN_NEWYORK], Q.LOCATION FROM (select DISTINCT concat(E.FIRST_NAME,' ',E.MIDDLE_NAME,' ',E.LAST_NAME) AS [EMPLOYEE_NAME], D.NAME as [DEPARTMENT], L.CITY as [LOCATION] from 
EMPLOYEE E INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id INNER JOIN LOCATION L ON D.Location_Id = L.Location_ID)Q WHERE Q.LOCATION = 'NEW YORK' GROUP BY Q.LOCATION;
--9. Display the employee details with salary grades. Use conditional statement to create a grade column.
select distinct e.*,j.Designation,d.Name as [Department],l.City as[Work_place],
CASE
	WHEN SALARY < 800 THEN '*'
	WHEN SALARY BETWEEN 800 AND 1000 THEN '* * *'
	WHEN SALARY BETWEEN 1000 AND 2000 THEN '* * * *'
	WHEN SALARY > 2000 THEN '* * * * *'
	ELSE 'INVALID'
END AS [SALARY_GRADE]
from EMPLOYEE e,Location l,job j,DEPARTMENT d where e.JOB_ID = j.JOB_ID 
and e.DEPARTMENT_ID = d.Department_Id and l.Location_ID = d.Location_Id;
--10. List out the number of employees grade wise. Use conditional statement to create a grade column.
select Q.SALARY_GRADE, COUNT(Q.EMPLOYEE_NAME) AS [NO_OF_EMPLOYEE] FROM (select distinct concat(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME],SALARY,
CASE
	WHEN SALARY < 800 THEN '*'
	WHEN SALARY BETWEEN 800 AND 1000 THEN '* * *'
	WHEN SALARY BETWEEN 1000 AND 2000 THEN '* * * *'
	WHEN SALARY > 2000 THEN '* * * * *'
	ELSE 'INVALID'
END AS [SALARY_GRADE]
from EMPLOYEE)Q GROUP BY Q.SALARY_GRADE ORDER BY Q.SALARY_GRADE DESC;
--11. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
select Q.SALARY_GRADE, COUNT(Q.EMPLOYEE_NAME) AS [NO_OF_EMPLOYEE_SALARY_B/W_2KTO5K] FROM 
(select distinct concat(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME],SALARY,
CASE
	WHEN SALARY < 800 THEN '*'
	WHEN SALARY BETWEEN 800 AND 1000 THEN '* * *'
	WHEN SALARY BETWEEN 1000 AND 2000 THEN '* * * *'
	WHEN SALARY > 2000 THEN '* * * * *'
	ELSE 'INVALID'
END AS [SALARY_GRADE]
from EMPLOYEE)Q WHERE SALARY BETWEEN 2000 AND 5000 GROUP BY Q.SALARY_GRADE ORDER BY Q.SALARY_GRADE DESC;
--12. Display all employees in sales or operation departments.
select distinct concat(e.FIRST_NAME,' ',e.MIDDLE_NAME,' ',e.LAST_NAME) AS [EMPLOYEE_NAME], 
d.Name as [DEPARTMENT] from employee e inner join department d on e.DEPARTMENT_ID = d.Department_Id WHERE d.Name IN ('RESEARCH','SALES');
--USING 'IN' OPERATOR FOR THE FIRST TIME. REALLY HELPFUL TO AVOID WRITING REPEATED EQUAL TOS' .

--SET Operators:
--1. List out the distinct jobs in sales and accounting departments.
SELECT*FROM JOB;
SELECT*FROM DEPARTMENT;
SELECT*FROM EMPLOYEE;
SELECT DISTINCT D.Name AS [DEPARTMENT], J.DESIGNATION FROM EMPLOYEE E, DEPARTMENT D, JOB J 
WHERE D.Department_Id = E.DEPARTMENT_ID AND E.JOB_ID = J.JOB_ID AND D.Name = 'Sales' or 
D.Department_Id = E.DEPARTMENT_ID AND E.JOB_ID = J.JOB_ID AND D.Name = 'Accounting' 
ORDER BY D.Name;
--2. List out all the jobs in sales and accounting departments.
SELECT D.Name AS [DEPARTMENT], J.DESIGNATION, E.FIRST_NAME AS [EMP_FIRST_NAME] FROM EMPLOYEE E, DEPARTMENT D, JOB J 
WHERE D.Department_Id = E.DEPARTMENT_ID AND E.JOB_ID = J.JOB_ID AND D.Name = 'Sales' or 
D.Department_Id = E.DEPARTMENT_ID AND E.JOB_ID = J.JOB_ID AND D.Name = 'Accounting' 
ORDER BY D.Name;
--OR WE CAN USE UNION--as shown below--
SELECT D.Name AS [DEPARTMENT], J.DESIGNATION, E.FIRST_NAME AS [EMP_FIRST_NAME] FROM EMPLOYEE E, DEPARTMENT D, JOB J 
WHERE D.Department_Id = E.DEPARTMENT_ID AND E.JOB_ID = J.JOB_ID AND D.Name = 'Sales'
UNION ALL
SELECT D.Name AS [DEPARTMENT], J.DESIGNATION, E.FIRST_NAME AS [EMP_FIRST_NAME] FROM EMPLOYEE E, DEPARTMENT D, JOB J 
WHERE D.Department_Id = E.DEPARTMENT_ID AND E.JOB_ID = J.JOB_ID AND D.Name = 'Accounting'

--3. List out the common jobs in research and accounting departments in ascending order.
SELECT Q.DEPARTMENT, Q.DESIGNATION FROM (SELECT  DISTINCT D.Name AS [DEPARTMENT], J.DESIGNATION, E.FIRST_NAME AS [EMP_FIRST_NAME] FROM EMPLOYEE E, DEPARTMENT D, JOB J 
WHERE D.Department_Id = E.DEPARTMENT_ID AND E.JOB_ID = J.JOB_ID)Q WHERE Q.DEPARTMENT  ='Research'
INTERSECT
SELECT Q.DEPARTMENT, Q.DESIGNATION FROM (SELECT  DISTINCT D.Name AS [DEPARTMENT], J.DESIGNATION, E.FIRST_NAME AS [EMP_FIRST_NAME] FROM EMPLOYEE E, DEPARTMENT D, JOB J 
WHERE D.Department_Id = E.DEPARTMENT_ID AND E.JOB_ID = J.JOB_ID)Q WHERE Q.DEPARTMENT  ='Accounting';


--Subqueries:
--1. Display the employees list who got the maximum salary.
SELECT  DISTINCT concat(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) AS [EMPLOYEE_NAME], SALARY 
FROM EMPLOYEE WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);
--2. Display the employees who are working in the sales department.
SELECT  DISTINCT concat(E.FIRST_NAME,' ',E.MIDDLE_NAME,' ',E.LAST_NAME) AS [EMPLOYEE_NAME], D.NAME AS [DEPARTMENT]  
FROM EMPLOYEE E, DEPARTMENT D WHERE E.DEPARTMENT_ID = D.Department_Id AND D.Name = 'Sales';
--3. Display the employees who are working as 'Clerk'.
SELECT DISTINCT concat(E.FIRST_NAME,' ',E.MIDDLE_NAME,' ',E.LAST_NAME) AS [EMPLOYEE_NAME], J.DESIGNATION   
FROM EMPLOYEE E, JOB J WHERE E.JOB_ID = J.JOB_ID AND J.DESIGNATION = 'Clerk';
--4. Display the list of employees who are living in "New York".
SELECT DISTINCT concat(E.FIRST_NAME,' ',E.MIDDLE_NAME,' ',E.LAST_NAME) AS [EMPLOYEE_NAME], L.CITY AS [STAY_AT_NEW_YORK]   
FROM EMPLOYEE E, LOCATION L, DEPARTMENT D WHERE E.DEPARTMENT_ID = D.Department_Id AND D.Location_Id = L.Location_ID AND L.CITY = 'New York';
--5. Find out the number of employees working in the sales department.
select d.Name as [DEPARTMENT], COUNT(E.EMPLOYEE_ID) AS [NO_OF_EMPLOYEE_IN_SALES]
from EMPLOYEE e,DEPARTMENT d where e.DEPARTMENT_ID = d.Department_Id AND D.Name = 'Sales' GROUP BY D.Name;
--6. Update the salaries of employees who are working as clerks on the basis of 10%.
--Lets check the original salary first:
SELECT FIRST_NAME, SALARY, JOB_ID FROM EMPLOYEE WHERE JOB_ID = (SELECT JOB_ID FROM JOB WHERE DESIGNATION = 'CLERK');
--We are putting are update query in a transaction block so that after doing the changes we can rollback to the original value.
--To do this please run the query including the begin transaction line and once you see the query is working you can 
--execute rollback transaction separately to rollback to the original values.
BEGIN TRANSACTION
UPDATE EMPLOYEE
SET SALARY = SALARY * 1.1
WHERE JOB_ID = (SELECT JOB_ID FROM JOB WHERE DESIGNATION = 'CLERK')
--As we do not want our original table to change we are using a 'begin-rollback TRANSACTION BLOCK' to rollback.
--This was fun
ROLLBACK TRANSACTION
--7. Delete the employees who are working in the accounting department.
--Note that the DELETE keyword deletes one or more rows when the provided condition satisfies
--Please execute the query along with BEGIN TRANSACTION to see the effect 
and then execute ROLLBACK TRANSACTION to reverse the effect
BEGIN TRANSACTION
DELETE FROM EMPLOYEE WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE Name = 'Accounting')
ROLLBACK TRANSACTION
--8. Display the second highest salary drawing employee details.
SELECT Q.EMPLOYEE_NAME, Q.SALARY FROM (SELECT DISTINCT FIRST_NAME AS [EMPLOYEE_NAME], SALARY, 
DENSE_RANK()OVER(ORDER BY SALARY DESC) AS [D_RANK] FROM EMPLOYEE)Q WHERE Q.D_RANK = 2;
--9. Display the nth highest salary drawing employee details.
--If n = 1
SELECT Q.EMPLOYEE_NAME, Q.SALARY FROM (SELECT DISTINCT FIRST_NAME AS [EMPLOYEE_NAME], SALARY, 
DENSE_RANK()OVER(ORDER BY SALARY DESC) AS [D_RANK] FROM EMPLOYEE)Q WHERE Q.D_RANK = 1;
--If n = 2
SELECT Q.EMPLOYEE_NAME, Q.SALARY FROM (SELECT DISTINCT FIRST_NAME AS [EMPLOYEE_NAME], SALARY, 
DENSE_RANK()OVER(ORDER BY SALARY DESC) AS [D_RANK] FROM EMPLOYEE)Q WHERE Q.D_RANK = 2;
--If n=3
SELECT Q.EMPLOYEE_NAME, Q.SALARY FROM (SELECT DISTINCT FIRST_NAME AS [EMPLOYEE_NAME], SALARY, 
DENSE_RANK()OVER(ORDER BY SALARY DESC) AS [D_RANK] FROM EMPLOYEE)Q WHERE Q.D_RANK = 3;
--If n=4
SELECT Q.EMPLOYEE_NAME, Q.SALARY FROM (SELECT DISTINCT FIRST_NAME AS [EMPLOYEE_NAME], SALARY, 
DENSE_RANK()OVER(ORDER BY SALARY DESC) AS [D_RANK] FROM EMPLOYEE)Q WHERE Q.D_RANK = 4;
--Likewise--
--10. List out the employees who earn more than every employee in department 30.
SELECT DISTINCT FIRST_NAME AS [EMPLOYEE_NAME], SALARY, DEPARTMENT_ID FROM EMPLOYEE WHERE 
SALARY > (SELECT MAX(SALARY) AS [MAX_SAL_DEPT30] FROM EMPLOYEE WHERE DEPARTMENT_ID = 30);
--11. List out the employees who earn more than the lowest salary in department. 
SELECT Q.EMP_NAME,Q.DEPARTMENT_ID,D.NAME AS [DEPARTMENT],Q.SALARY,Q.D_RANK_LOWEST_FIRST FROM(SELECT DISTINCT FIRST_NAME AS [EMP_NAME],DEPARTMENT_ID,SALARY,DENSE_RANK()OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY ASC) 
AS D_RANK_LOWEST_FIRST FROM EMPLOYEE GROUP BY DEPARTMENT_ID,FIRST_NAME,DEPARTMENT_ID,SALARY)Q, DEPARTMENT D WHERE Q.DEPARTMENT_ID = D.Department_Id AND Q.D_RANK_LOWEST_FIRST != 1 
UNION
SELECT Q.EMP_NAME,Q.DEPARTMENT_ID,D.NAME AS [DEPARTMENT],Q.SALARY,Q.D_RANK_LOWEST_FIRST FROM(SELECT DISTINCT FIRST_NAME AS [EMP_NAME],DEPARTMENT_ID,SALARY,DENSE_RANK()OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY ASC) 
AS D_RANK_LOWEST_FIRST FROM EMPLOYEE GROUP BY DEPARTMENT_ID,FIRST_NAME,DEPARTMENT_ID,SALARY)Q,DEPARTMENT D WHERE Q.DEPARTMENT_ID = D.Department_Id AND Q.DEPARTMENT_ID IN 
(SELECT Q.DEPARTMENT_ID FROM(SELECT DISTINCT FIRST_NAME AS [EMP_NAME],DEPARTMENT_ID,SALARY,DENSE_RANK()OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY ASC) 
AS D_RANK_LOWEST_FIRST FROM EMPLOYEE GROUP BY DEPARTMENT_ID,FIRST_NAME,DEPARTMENT_ID,SALARY)Q GROUP BY Q.DEPARTMENT_ID HAVING COUNT(Q.DEPARTMENT_ID) <2) ORDER BY Q.DEPARTMENT_ID;
--Here to find the employees those earn more than the lowest earning employee we DENSE_RANK them in ascending order and partition them by Dept. Thus, the employee earning the
--least in the Dept shows at [no. 1]. Then we ask for all employees where DENSE_RANK not equal to 1.
-- But the issues here is there are two departments namely:
--1) Sales and 2) Operations those have only one employee. Thus, they would be neglated if we use the above method. Thus, we write a separate query to add them using a 
--UNION operator asking where count(department_Id) < 2 using a UNION operator. Also note that to use UNION operator the Columns in both the queries should be same.
--12. Find out which department has no employees.
SELECT DISTINCT D.NAME AS [DEPARTMENT], E.FIRST_NAME AS [EMPLOYEE_NAME] FROM 
EMPLOYEE E RIGHT JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID WHERE E.FIRST_NAME IS NULL;
--13. Find out the employees who earn greater than the average salary for their department.
SELECT DISTINCT E.FIRST_NAME AS [EMPLOYEE_NAME], D.NAME AS [DEPARTMENT], E.SALARY FROM (SELECT E.DEPARTMENT_ID, D.NAME AS [DEPARTMENT], AVG(E.SALARY) AS 'AVG_SALARY' FROM EMPLOYEE E, 
DEPARTMENT D WHERE E.DEPARTMENT_ID = D.Department_Id GROUP BY D.Name,E.DEPARTMENT_ID)Q, EMPLOYEE E, DEPARTMENT D WHERE E.DEPARTMENT_ID = D.Department_Id AND E.DEPARTMENT_ID = Q.DEPARTMENT_ID AND E.SALARY > Q.AVG_SALARY;
--here joining E.DEPARTMENT_ID = D.Department_Id AND E.DEPARTMENT_ID = Q.DEPARTMENT_ID does not give error rather helps in joining the other tables with the inner query and
--helps solve the problem and get the output. Thank you for the question. It was really helpful.

---THANK YOU AGAIN FOR THE ASSIGNMENT. IT WAS REALLY FUN SOLVING THIS. REALLY ENJOYED-----
