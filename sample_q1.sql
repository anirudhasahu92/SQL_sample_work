CREATE DATABASE New_assignment_Intel
--1. Create a customer table which comprises of these columns: ‘customer_id’,‘first_name’, ‘last_name’, ‘email’, ‘address’, ‘city’,’state’,’zip’
CREATE TABLE customer 
(customer_id int,
first_name varchar(30), 
last_name varchar(30), 
email varchar(40) , 
address varchar(40),
city varchar(30),
state varchar(30),
zip int)
GO
--2. Insert 5 new records into the table
insert into customer values
(101, 'Gavin', 'Miller', 'gavinmiller@gmail.com', 'Park Avenue', 'San Jose', 'California, USA', '95101'),
(102, 'Saurabh', 'Verma', 'saurabhverma@gmail.com', 'Marine Drive', 'Mumbai', 'Maharashtra', '400001'),
(103, 'Divya', 'Sharma', 'divyasharma@gmail.com', 'Salt Lake City', 'Kolkata', 'West Bengal', '700091'),
(104, 'Rakesh', 'Kumar', 'rakeshkumar@gmail.com', 'Anna Nagar', 'Chennai', 'Tamil Nadu', '600040'),
(105, 'Neha', 'Patel', 'nehapatel@gmail.com', 'Banjara Hills', 'Hyderabad', 'Telangana', '500034')
GO
select*FROM customer
--3. Select only the ‘first_name’ and ‘last_name’ columns from the customer table
select
first_name,
last_name
from customer;
--4. Select those records where ‘first_name’ starts with “G” and city is ‘San Jose’
select*from customer where first_name like 'G%' and city='San Jose';
--5. Select those records where Email has only ‘gmail’.
select*from customer where email like '%gmail%';
--6. Select those records where the ‘last_name’ doesn't end with “A”.
select*from customer where last_name not like '%a';
--Thank you for the assignment---it was fun