--IITR_assign5
--1. Arrange the ‘Orders’ dataset in decreasing order of amount
select*from orders 
group by order_id,order_date,customer_id,amount 
order by amount desc;
--2. Create a table with the name ‘Employee_details1’ consisting of these columns: ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. 
--Create another table with the name ‘Employee_details2’ consisting of the same columns as the first table.
create table Employee_details1 (Emp_id int,Emp_name varchar(30),Emp_salary int);
insert into Employee_details1 values ('1001', 'John Smith', '50000'),
('1002', 'Emily Johnson', '60000'),
('1003', 'Michael Williams', '55000'),
('1004', 'Jessica Davis', '65000'),
('1005', 'Daniel Brown', '70000'),
('1006', 'Olivia Taylor', '48000'),
('1007', 'James Miller', '52000'),
('1008', 'Sophia Anderson', '58000'),
('1009', 'William Jackson', '53000'),
('1010', 'Ava Martinez', '62000'),
('1011', 'Alexander Lopez', '57000'),
('1012', 'Mia Garcia', '55000'),
('1013', 'Benjamin Hernandez', '68000'),
('1014', 'Charlotte Adams', '50000'),
('1015', 'Henry Clark', '60000'),
('1016', 'Amelia Hill', '51000'),
('1017', 'David Turner', '57000'),
('1018', 'Ella Scott', '54000'),
('1019', 'Joseph Green', '63000'),
('1020', 'Victoria Hall', '56000')
GO
create table Employee_details2 (Emp_id int,Emp_name varchar(30),Emp_salary int);
insert into Employee_details2 values ('1001', 'John Smith', '50000'),
('1002', 'Emily Johnson', '60000'),
('1003', 'Michael Williams', '55000'),
('1004', 'Jessica Davis', '65000'),
('1005', 'Daniel Brown', '70000'),
('1006', 'Olivia Taylor', '48000'),
('1007', 'James Miller', '52000'),
('1008', 'Sophia Anderson', '58000'),
('1009', 'William Jackson', '53000'),
('1010', 'Ava Martinez', '62000'),
('1011', 'Alexander Lopez', '57000'),
('1012', 'Mia Garcia', '55000'),
('1013', 'Benjamin Hernandez', '68000'),
('1014', 'Charlotte Adams', '50000'),
('1015', 'Henry Clark', '60000'),
('1016', 'Amelia Hill', '51000'),
('1017', 'David Turner', '57000'),
('1018', 'Ella Scott', '54000'),
('1019', 'Joseph Green', '63000'),
('1020', 'Victoria Hall', '56000'),
('1021', 'Isabella Lee', '59000'),
('1022', 'Liam Wilson', '57000'),
('1023', 'Sophia Thompson', '52000'),
('1024', 'Noah Harris', '63000'),
('1025', 'Emily Martin', '54000'),
('1026', 'James Robinson', '65000'),
('1027', 'Olivia Walker', '50000'),
('1028', 'Benjamin King', '59000'),
('1029', 'Ava White', '56000'),
('1030', 'Lucas Young', '61000')
GO
select*from Employee_details1;
select*from Employee_details2;
--3. Apply the UNION operator on these two tables
select*from Employee_details1 union select*from Employee_details2;
--4. Apply the INTERSECT operator on these two tables
select*from Employee_details1 intersect select*from Employee_details2;
--5. Apply the EXCEPT operator on these two tables
select*from Employee_details2 except select*from Employee_details1;
-----------------------------------------------------------------------------------end