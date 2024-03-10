--IITR_assign6
--1. Create a view named ‘customer_san_jose’ which comprises of only those customers who are from San Jose
select*from customer;
create view customer_san_jose as select*from customer where city like 'San Jose' 
GO
select*from customer_san_jose;
--2. Inside a transaction, update the first name of the customer to Francis where the last name is Jordan:
select*into customer2 from customer;
select*from customer2;
update customer2 set last_name='Jordan' where customer_id=101;
begin transaction
update customer2 set first_name='Francis' where last_name='Jordan';
commit
--a. Rollback the transaction
begin transaction
update customer2 set first_name='Francis' where last_name='Jordan';
rollback
--note: once committed the transaction cannot be rolled back
--Lets go back and update the values to as it is to redo the task again and rollback
select*from customer
update customer2 set first_name='Gavin' where last_name='Jordan';
begin transaction
update customer2 set first_name='Francis' where last_name='Jordan';
rollback
select*from customer2
--b. Set the first name of customer to Alex, where the last name is Jordan
begin transaction
update customer2 set first_name='Alex' where last_name='Jordan';
commit
select*from customer2
--3. Inside a TRY... CATCH block, divide 100 with 0, print the default error message.
BEGIN TRY
    select 100 / 0
END TRY
BEGIN CATCH
    select ERROR_MESSAGE()
END CATCH;
--gives two result windows. need only one.
BEGIN TRY
    select 100 / 0
END TRY
BEGIN CATCH
    print ERROR_MESSAGE()
END CATCH;
--No error message showing. either print statement not working or the calculation is not throwing error.
 select 100 / 0
 --This separately shows error. Lets do things in a bit different way.
 declare @val1 int
 declare @val2 int
 BEGIN TRY
    set @val1=100
	set @val2=100/0
	print 'Operation successful'
END TRY
BEGIN CATCH
    print ERROR_MESSAGE()
END CATCH;
--It works. But this time lets try select statement instead of print for the error message.
 declare @val1 int
 declare @val2 int
 BEGIN TRY
    set @val1=100
	set @val2=100/0
	print 'Operation successful'
END TRY
BEGIN CATCH
    select ERROR_MESSAGE() as 'Bad_day'
END CATCH;
--This works. This is if you use select statement for the error message. This was interesting. Try dividing by 2 as well. 
declare @val1 int
 declare @val2 int
 BEGIN TRY
    set @val1=100
	set @val2=100/2
	print @val2 
	print 'Operation successful'
END TRY
BEGIN CATCH
    print ERROR_MESSAGE()
END CATCH;
--4. Create a transaction to insert a new record to Orders table and save it.
select*from orders;
select * into orders2 from orders;
select*from orders2;
--Since I did not want to change the original 'Orders' table I created a new table 'orders2' to operate on it.
BEGIN TRANSACTION 
insert into orders2 (order_id, order_date, amount, customer_id)
values (1006, '2023-07-08', 220, 107)
COMMIT;
select*from orders2;