CREATE DATABASE CASESTUDY3;

USE CASESTUDY3;

SELECT*FROM CONTINENT;
SELECT*FROM Customers;
SELECT*FROM [Transaction];
--SINCE SQL IS IDENTIFYING TRANSACTION AS A KEYWORD WE NEED TO USE [] (SQUARE BRACKETS) TO SAY SQL THAT IT IS A TABLE AND NOT A KEYWORRD

--1. Display the count of customers in each region who have done the transaction in the year 2020.
select c.region_name, count(t.customer_id) as [No_of_customers], year(txn_date) as [txn_year] 
from [Transaction] t, continent c, Customers u where year(txn_date) = 2020 
and c.region_id = u.region_id and t.customer_id = u.customer_id group by c.region_name, year(txn_date) order by [No_of_customers] desc;
--2. Display the maximum and minimum transaction amount of each transaction type.
select txn_type, max(txn_amount) as [Max_txn_amount],min(txn_amount) as [Min_txn_amount] from [Transaction] group by txn_type;
--3. Display the customer id, region name and transaction amount where transaction type is deposit and transaction amount > 2000.
select u.customer_id, c.region_name, t.txn_amount from Customers u, Continent c, [Transaction] t 
where c.region_id = u.region_id and t.customer_id = u.customer_id and t.txn_type = 'deposit' and t.txn_amount > 2000;
--4. Find duplicate records in the customer table.
--5. Display the customer id, region name, transaction type and transaction amount for the minimum transaction amount in deposit.
select distinct u.customer_id, c.region_name,t.txn_date,t.txn_type, t.txn_amount from Customers u, Continent c, [Transaction] t 
where c.region_id = u.region_id and t.customer_id = u.customer_id and t.txn_type = 'deposit' 
and t.txn_amount = (select min(txn_amount) as 'Min_txn_amount' from [Transaction]);
--6. Create a stored procedure to display details of customers in the Transaction table where the transaction date is greater than Jun 2020.
create procedure txn_post_jun2020
as
select t.*, u.*, c.* from [Transaction] t, Customers u, Continent c where t.customer_id = u.customer_id and u.region_id = c.region_id and
month(txn_date) > 6 and year(txn_date) > 2020;

exec txn_post_jun2020;
--7. Create a stored procedure to insert a record in the Continent table.
--Since I don't want to change anything in the Continent table I created a replica table CONTINENT2 to do the task:
CREATE TABLE CONTINENT2 (REGION_ID INT, REGION_NAME VARCHAR(15));
INSERT INTO CONTINENT2 SELECT * FROM Continent;
SELECT*FROM CONTINENT2;
--note that the syntax is very specific for writing to insert values via stored procedure. 
--The constraints for the arguments should be given while setting up the arguments and not after that anywhere. 
--write the query within a begin-end block  (not mandatory but good practice for readability) 
CREATE PROCEDURE INSERT_RECORD
(@REGION_ID INT, @REGION_NAME VARCHAR(15))
AS
BEGIN
    INSERT INTO CONTINENT2 (REGION_ID, REGION_NAME)
    VALUES (@REGION_ID, @REGION_NAME)
END

-- Executing the procedure with values for parameters
EXEC INSERT_RECORD @REGION_ID = 6, @REGION_NAME = 'Russia'

--Also you can use BEGIN-ROLLBACK TRANSACTION BLOCK also with stored procedure to reverse the change made by the stored procedure
BEGIN TRANSACTION
EXEC INSERT_RECORD @REGION_ID = 7, @REGION_NAME = 'Antartica'
Rollback Transaction
select*from continent2;
--8. Create a stored procedure to display the details of transactions that happened on a specific day.
--As, check constraint in SQL only works in tables we have to use IF-ELSE blocks to check we collect the right input from the user followed by our action
CREATE PROCEDURE TXN_BROWSER
(
    @Day INT,
    @Month INT,
    @Year INT
)
AS
BEGIN
    -- Check if the provided date is valid
    IF (
        @Day >= 1
        AND (
            (@Month = 1 AND @Day <= 31)
            OR (@Month = 2 AND @Year % 4 = 0 AND @Day <= 29)
            OR (@Month = 2 AND @Year % 4 <> 0 AND @Day <= 28)
            OR (@Month = 3 AND @Day <= 31)
            OR (@Month = 4 AND @Day <= 30)
            OR (@Month = 5 AND @Day <= 31)
            OR (@Month = 6 AND @Day <= 30)
            OR (@Month = 7 AND @Day <= 31)
            OR (@Month = 8 AND @Day <= 31)
            OR (@Month = 9 AND @Day <= 30)
            OR (@Month = 10 AND @Day <= 31)
            OR (@Month = 11 AND @Day <= 30)
            OR (@Month = 12 AND @Day <= 31)
        )
    )
    BEGIN
        -- Perform your desired action here (e.g., select data)
        SELECT * FROM [Transaction]
        WHERE DAY(txn_date) = @Day
        AND MONTH(txn_date) = @Month
        AND YEAR(txn_date) = @Year;
    END
    ELSE
    BEGIN
        -- Handle the case where the provided date is not valid
        PRINT 'Invalid date provided.';
    END
END
-- Executing the procedure with values for parameters
EXEC TXN_BROWSER @day = 21, @month = 3, @year = 2020;

--9. Create a user defined function to add 10% of the transaction amount in a table.
CREATE FUNCTION UPDATETXNAMOUNT ()
RETURNS @UPDATEDTXN TABLE
(
customer_id INT, txn_date DATE,txn_type VARCHAR(15),txn_amount INT,updated_txn_amount FLOAT
)
AS
BEGIN
	INSERT INTO @UPDATEDTXN (customer_id,txn_date,txn_type,txn_amount,updated_txn_amount)
	SELECT customer_id,TXN_DATE,TXN_TYPE,TXN_AMOUNT,TXN_AMOUNT * 1.1 AS UPDATED_TXN_AMOUNT FROM [Transaction];
	RETURN;
END
-- Executing the TABLE-VALUED USER DEFINED FUNCTION :
SELECT * FROM UPDATETXNAMOUNT();

--10. Create a user defined function to find the total transaction amount for a given transaction type.
--Lets check the table first
select*from [Transaction];
--Defining the function (NOTE:basically we give the schema name as well but if we don't give it takes default schema)
create function find_txn_amount (@txn_type varchar(15)) 
returns varchar(30)
as 
	begin 
		declare @txn_amount varchar(30)
		IF EXISTS (SELECT 1 FROM [transaction] WHERE txn_type = @txn_type) --Using regular if without using query does not work. Use EXISTS (subquery with where clause)
		begin
	    select @txn_amount = cast (sum(txn_amount) as varchar(30)) from [transaction] where @txn_type = txn_type --cast the int to varchar so that we can set the @txn_amount to a string to type the error in the else statement
		end							-- 'equals to' can be used within the select query to assign the arguments to the table columns
		else
		-- Handle the case where the provided input is not valid
		begin
		set @txn_amount = 'Transaction type not found' --can be set to string as both return and @txn_amount are set to varchar(30) instead of int or float
		end
		return @txn_amount --using alias for @tnx_amount does not work in SQL function. Thus use alias while writing 
		                   --the select query using the function
	end

--Calling the function: (NOTE: Since there is no feature to give alias to return value in function use alias while calling the function)
select dbo.find_txn_amount('withdrawal') as 'Withdrwal';
select dbo.find_txn_amount('deposit') as 'Deposit';
select dbo.find_txn_amount('Borrowed') as 'Borrowed';

--Checking whether the function is working correctly or not:
select txn_type, sum(txn_amount) as txn_amount from [Transaction] group by txn_type;

--What all I tried and it didn't work and why ?
/*
Answer 1 : 
create function find_txn_amount (@txn_type varchar(15))
returns float
as 
	begin
		if @txn_type in (select txn_type from [Transaction]) 
			begin
				select sum(txn_amount) as [Total_txn_amount] from [transaction]
			end
	else
		begin
			print 'Invalid input'
		end
	end
What is the mistake ?
1) The SELECT statement inside the IF block is not correctly using the @txn_type parameter to filter the transactions.
2) We are trying to perform an IF check on a subquery result, which isn't a valid syntax for SQL Server scalar functions.
Solution for (1) and (2) : use IF EXISTS (subquery) syntax

if exists (SELECT 1 FROM [transaction] WHERE txn_type = @txn_type)

how does (SELECT 1 FROM [transaction] WHERE txn_type = @txn_type) work ?

In this example, the SELECT 1 FROM [transaction] WHERE txn_type = 'purchase' query is used to determine whether there are any rows in 
the [transaction] table where the txn_type column is equal to 'purchase'. If such rows exist, the IF EXISTS condition evaluates to true,
and you can execute the code in the first block. If no such rows exist, the code in the ELSE block is executed.
*/
--Lets try some more examples and see:
SELECT 1 FROM [transaction] WHERE txn_type = 'purchase'
-- Select basically works something like print in python. What it does is it creates a new column and writes 1 in whichever row the
--txn_type = 'purchase'
--Whatever you write instead of 1 will get printed in the new column in the given query. Lets try:
SELECT 5 FROM [transaction] WHERE txn_type = 'purchase'
SELECT null FROM [transaction] WHERE txn_type = 'purchase'
SELECT TRUE FROM [transaction] WHERE txn_type = 'purchase' --does not work
SELECT 'True' FROM [transaction] WHERE txn_type = 'purchase'
SELECT int FROM [transaction] WHERE txn_type = 'purchase'--does not work
SELECT 'viper' FROM [transaction] WHERE txn_type = 'purchase'--does not work
--NOTE : IF 'Purchase' is not there it won't write the values after select in the new column. 
--Exploiting this feature we use to figure out whether the required value asked in the where clause exists in the table or not in a particular column
--This feature we use with IF EXISTS to check our input is valid or not and present in the table or not
/*
3) In SQL Server, you cannot use the PRINT statement directly within a scalar function to display an error message in the 
same way you might do in a script or batch of SQL commands. The PRINT statement is typically used for debugging or informational 
purposes and is not suitable for returning error messages within a scalar function.

SOLUTION : Since a function only returns one type of data in the output that is initially set it is not possible to return an error messege
--which is a string while the correct output is actually a float. To solve this we initially define the return to be varchar(30). We cast the 
--txn_amount which is actually supposed to be an integer knowingly into varchar(30) so that in the else statement we can set @txn_amount to string
--'Transaction type not found' to get as error when the IF condition does not satisfy.
*/
--note that the syntax for calling an SQL function and SQL stored procedure is different. 
--For stored procedure: 
--1) without arguments:
--    Exec stored_procedure_name 
--2) With arguments:
--    Exec stored_procedure_name @arg1 = argument1_name, @arg2 = argument2_name....)
--NOTES:
--print statement usually works flawlessly with stored procedure even inside if-else and begin-end 
--blocks although there is no indentation system in SQL like python
/* 
For SQL function:
Calling syntax:
Without argument:
Select dbo.fun_name () as alias_name    -- (IF your schema name is not default you might need to change .dbo) --
With arguments:
Select dbo.fun_name (arg1, arg2,...so on) as alias_name
--> giving alias name is not compulsory but convenient.
--> Print statement does not work in a function if inside an if-else block
--> the function should always end with a return value
--> An SQL user defined scaler valued function can only return a single output in only one data type.
--> if u use exec to execute a function the function is executed without giving an output
--> use if exists operator instead in a table to check specific values in a column by writing a sub-query instead of if
--> if-else, begin-end and try-catch block can still be used in a function 
--> use return instead of print..but use it at last
--> unlike function print can be easily used in stored procedures and try-catch blocks
--> To drop an already created function use :
--> DROP Function function_name
*/

--11. Create a table value function which comprises the columns customer_id, region_id ,txn_date , txn_type ,
--txn_amount which will retrieve data from the above table.
--Lets check all the tables we need to use:
select*from [Transaction];
select*from Continent;
select*from Customers;
--Creating the required table-valued function:
CREATE FUNCTION Retrive_data()
RETURNS @retdata TABLE
(
customer_id int,  region_id int , txn_date date,  txn_type varchar(20), txn_amount int
)
AS
BEGIN
	INSERT INTO @retdata (customer_id,  region_id, txn_date,  txn_type, txn_amount)
	select distinct t.customer_id, c.region_id ,t.txn_date , t.txn_type , t.txn_amount from Customers c, [Transaction] t, Continent n
    where t.customer_id = c.customer_id and c.region_id = n.region_id order by t.customer_id;
	RETURN;
END
--Calling the function: (NOTE: Since there is no feature to give alias to return value in function use alias while calling the function)
select*from Retrive_data();
--It works. Hurray. Thank you for the question.

--12. Create a TRY...CATCH block to print a region id and region name in a single column.
--Lets write the TRY-CATCH block:
-- Set the value of @regionid
DECLARE @regionid INT;

-- Set the value of @regionid
SET @regionid = 7;

IF EXISTS (SELECT 1 FROM Continent WHERE region_id = @regionid)
BEGIN
    BEGIN TRY
        SELECT CONCAT(region_id, '-->', region_name) AS [REGION_ID_NAME] FROM Continent WHERE region_id = @regionid;
    END TRY
    BEGIN CATCH
        PRINT 'Region with region_id ' + CAST(@regionid AS VARCHAR(10)) + ' does not exist in the Continent table.';
    END CATCH
END
ELSE
BEGIN
    PRINT 'Region with region_id ' + CAST(@regionid AS VARCHAR(10)) + ' does not exist in the Continent table.';
END
--The catch block does not throw the required error so used an else statement for it.
--This is a simple query and does not require a try-catch block
--13. Create a TRY...CATCH block to insert a value in the Continent table.
select*from CONTINENT2;
--Lets write the TRY-CATCH block:
BEGIN TRY
    -- Your INSERT statement
    INSERT INTO CONTINENT2(region_id, region_name)
    VALUES (8, 'Antartica');
    -- If everything is successful, commit the transaction
    COMMIT;
END TRY
BEGIN CATCH
    -- Handle the error
    PRINT 'An error occurred: ' + ERROR_MESSAGE();
    ROLLBACK;
END CATCH;

--14. Create a trigger to prevent deleting a table in a database.
--Lets use this trigger on a replica table we created from the provided [Continent] table.
--For this first lets check the replica table named [Continent2]:
select*from Continent2;
--Lets start with the question.
--For this question we need to use 'instead of delete' trigger which means that when someone executes a query to delete any record from
--this table instead of running that query the query that is given within the 'instead of delete' trigger will be activated.
create trigger stop_delete on Continent2 --trigger name and on which table we need to apply on
instead of delete						 -- What type of Trigger we are using
as 
begin
raiserror ('DELETING RECORD FROM THIS TABLE IS NOT AUTHORIZED', 16,1)
end
----
select*from Continent2;
delete from CONTINENT2 where REGION_ID = 4;
----
--Note that since the Trigger is created; and activated on the particular row where 'REGION_ID = 4' once the query  
--'delete from CONTINENT2 where REGION_ID = 4;' is executed (NOTE: Once the query is promted the action is stored in a memory place called [delete]
-- which can be used as a table whenever necessay in the queries using the select statement like 'select * from [delete]' within the Trigger).
--although there is no deletion the ouput still shows :
--one row affected.
--Here is the output as below:
/*
Msg 50000, Level 16, State 1, Procedure stop_delete, Line 5 [Batch Start Line 276]
DELETING RECORD FROM THIS TABLE IS NOT AUTHORIZED

(1 row affected)

Completion time: 2023-09-19T23:24:07.9596138+05:30
*/
-- To avoid this lets add 'Rollback' in the trigger query so that when the trigger is activated and applied on the particular row mentioned 
--in the query 'Rollback' takes place thus no row is affected and thus we do not get any messege.

/*
The purpose of the ROLLBACK statement in this trigger is to prevent the delete operation from actually occurring on the "Continent2" table. 
When the trigger is activated, it raises an error message and rolls back any changes made within the transaction. 
As a result, the record is not deleted, and an error is returned to the user indicating that the deletion is not authorized.
*/
----
drop trigger stop_delete;				 -- To drop the previous trigger so that we can create a new one
----
create trigger stop_delete on Continent2 --trigger name and on which table we need to apply on
instead of delete						 -- What type of Trigger we are using
as 
begin
raiserror ('DELETING RECORD FROM THIS TABLE IS NOT AUTHORIZED', 16,1)
rollback								 -- issue handeled
end
----
--Lets check now :
select*from Continent2;
delete from CONTINENT2 where REGION_ID = 4; --Problem solved
--15. Create a trigger to audit the data in a table.
--Lets use the same table Continent 2 for this task.
select*from Continent2;
--To store the data generated by the audit trigger we first need to create an empty audit table.
--Basically an audit table keeps record of all the changes made to a particular table.
--In this case we are working wih only one table.
--Lets first create the audit table:
create table audit_table
(AuditTrailID INT IDENTITY(1,1) PRIMARY KEY,
    TableName VARCHAR(30),
    Action VARCHAR(10),
	REGION_ID INT,
	REGION_NAME VARCHAR(15),
    AuditDate DATETIME
);

CREATE TRIGGER AUDIT_TRAIL ON CONTINENT2
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
	BEGIN
	-- Insert audit records for INSERT operations
	 IF EXISTS (SELECT * FROM inserted)
	 INSERT INTO audit_table (TableName, Action, REGION_ID, REGION_NAME, AuditDate) --u don't need to mention primary key AuditTrailID
	 SELECT 'CONTINENT2', 'INSERT', i.REGION_ID, i.REGION_NAME, GETDATE()				--here. It will be taken automatically	
        FROM inserted i;
    END;
	-- Insert audit records for UPDATE operations
	BEGIN
	IF EXISTS (SELECT * FROM inserted)
	 INSERT INTO audit_table (TableName, Action, REGION_ID, REGION_NAME, AuditDate)  --Note the awesome syntax here. u don't need to write
	 SELECT 'CONTINENT2', 'UPDATE', i.REGION_ID, i.REGION_NAME, GETDATE()			 --from or anything before the select query to insert values
        FROM inserted i																 --into the audit table. It's ok if we write it just next to it
		inner join
		deleted d on i.REGION_ID = d.REGION_ID;
	END
	-- Insert audit records for DELETE operations
	BEGIN
	IF EXISTS (SELECT * FROM deleted)
	 INSERT INTO audit_table (TableName, Action, REGION_ID, REGION_NAME, AuditDate)
	 SELECT 'CONTINENT2', 'DELETE', d.REGION_ID, d.REGION_NAME, GETDATE()
        FROM deleted d;
	END
END

--Lets try if the trigger works:

--For INSERT:
insert into CONTINENT2 values (7,'India');
--Checking the CONTINENT2 table post INSERT operation:
select * from CONTINENT2;
--checking for the entry in the audit table post INSERT operation:
select * from CASESTUDY3.dbo.audit_table; --It's working
--Lets INSERT another record:
insert into CONTINENT2 values (8,'China');
--For UPDATE:
UPDATE CONTINENT2 SET REGION_NAME = 'Nepal' WHERE REGION_ID = 8; --Since updating takes 2 operations - insert and delete thus 
--Checking the CONTINENT2 table post UPDATE operation:			 -- There will be changes in 3 tables : INSERT table, DELETE TABLE and UPDATE table
select * from CONTINENT2;										 -- So, it will show 3 rows affected and there will be 3 entries in the Audit_table	
--checking for the entry in the audit table post UPDATE operation: --To distinguish update from insert and delete we can check the action timming of update when it occured
select * from CASESTUDY3.dbo.audit_table; --It's working			-- During an update action in the records we can see an INSERT record preceeding the Update record followed by a delete record
																 -- The sequence of operation depends on whether u have used the INSERT operation first or the DELETE operation
																 -- In the UPDATE operation within the TRIGGER
																  -- All the operations showing to be executed at the same time (Trick to spot an UPDATE).
--For DELETE:
DELETE FROM CONTINENT2 WHERE REGION_ID = 8;
--note that as we had already activated a trigger for not allowing deletion of record we might need to inactivate or drop the trigger
--before doing this operation
--Lets drop the trigger for a while to carry out the above operation
drop trigger stop_delete;			--DELETE operation got exectued after dropping the TRIGGER stop_delete	 
--Checking the CONTINENT2 table post DELETE operation:
select * from CONTINENT2;
--checking for the entry in the audit table post DELETE operation:
select * from CASESTUDY3.dbo.audit_table; --It's working
--Lets create back the stop_delete trigger on the table CONTINENT2 running the respective create trigger query above again.

--16. Create a trigger to prevent login of the same user id in multiple pages.
-- To perform the above action we need to create a different type of TRIGGER called the LOGON TRIGGER.
select * from sys.dm_exec_sessions; -- This is a table where all the login session details to the SSSMS server are stored in the system database
--We will use this table for creating our trigger.
--Lets create a trigger that prevents the user from logging in to the SQL server from more than 2 windows.
CREATE TRIGGER prevent_multiple_logins
ON ALL SERVER WITH EXECUTE AS 'sa' -- Why to execute as an 'sa' ? Explanation given afterwards
FOR LOGON 
AS
BEGIN 
	DECLARE @login nvarchar(100)
	SET @login = ORIGINAL_LOGIN()
IF (SELECT COUNT(*) FROM SYS.DM_EXEC_SESSIONS WHERE IS_USER_PROCESS = 1 AND original_login_name = @login) > 2 
--The user cannot login from more than 2 windows to the SQL server
BEGIN
PRINT 'CONNECTIOB BY' + @login + 'FAILED : THE SYSTEM DOES NOT ALLOW LOGIN FROM MORE THAN 2 WINDOWS'
ROLLBACK
END
END
-- I don't know why the error does not show up but the trigger still works. Thank you for the question.
DROP TRIGGER prevent_multiple_logins
--THE TRIGGER WORKS. NOW I NEED TO DROP IT SO THAT I CAN WORK COMFORTABLY. THANK YOU FOR THE QUESTIONS.
/*
OUTPUT:
Msg 3701, Level 11, State 5, Line 411
Cannot drop the trigger 'prevent_multiple_logins', because it does not exist or you do not have permission.

Completion time: 2023-09-22T23:34:34.1785733+05:30
--THAT'S WHY DELETED USING THE OBJECT EXPLORER AFTER GOING TO THE SERVER OBJECTS --> TRIGGER BUT AFTER RE-LOGGING. ONCE U DELETE IT
--BETTER TO RELOGIN AGAIN AND WORK
*/

/*
Why to Execute as an 'sa' i.e; System administrator :

1.Security Context: Logon triggers often need to perform actions that require elevated permissions or are not allowed for regular users. 
By executing the trigger with the 'sa', we ensure that the trigger has the necessary permissions to perform these actions.
2. Preventing Lockout: When designing a logon trigger, you must be careful not to inadvertently lock out all users, including administrators, 
by blocking their logins. By using 'sa' as the execution, we have a way to ensure that critical system administrators can still access 
the server even if the trigger blocks other logins.
3. Custom Security Context: You could use a different login with the necessary permissions instead of 'sa' if it is more appropriate for your 
specific scenario. However, be cautious when choosing the login, and make sure it has adequate privileges to perform the required actions within 
the trigger.
4. Testing and Maintenance: When implementing logon triggers in a production environment, thorough testing is crucial. 
Using 'sa' during development and testing allows you to verify the trigger's functionality without risking unintended consequences.
Once you are confident in the trigger's behavior, you can adjust the execution context as needed for your production environment.
5. Logging and Auditing: If the trigger performs auditing or logging operations, executing as 'sa' can ensure that the trigger has the 
necessary permissions to write to audit logs or perform other logging tasks.
*/
--17. Display top n customers on the basis of transaction type.
select * from [Transaction]
--for n = 1
select q.* from (SELECT txn_type, customer_id,sum(txn_amount) as 'Sum_txn_amount', DENSE_RANK()
over(partition by txn_type order by sum(txn_amount) desc) as d_rank from [Transaction] group by txn_type,customer_id)q where d_rank = 1;

--for n = 3 (top 3)
select q.* from (SELECT txn_type, customer_id,sum(txn_amount) as 'Sum_txn_amount', DENSE_RANK()
over(partition by txn_type order by sum(txn_amount) desc) as d_rank from [Transaction] group by txn_type,customer_id)q where d_rank between 1 and 3;

--for n = 10 (top 10)
select q.* from (SELECT txn_type, customer_id,sum(txn_amount) as 'Sum_txn_amount', DENSE_RANK()
over(partition by txn_type order by sum(txn_amount) desc) as d_rank from [Transaction] group by txn_type,customer_id)q where d_rank between 1 and 10;

--18. Create a pivot table to display the total purchase, withdrawal and deposit for all the customers.
select * from (select customer_id, txn_type, sum(txn_amount) as 'Sum_txn_amount' from [Transaction] group by customer_id,txn_type) as 
sourcetable pivot (sum(sum_txn_amount) for txn_type in ([purchase],[withdrawal],[deposit])) as pivottable ;