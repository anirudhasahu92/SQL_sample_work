--IITR_assign4
--1. Use the inbuilt functions and find the minimum, maximum and average amount from the orders table
Select
min(amount) as 'Min_amount',
max(amount) as 'Max_amount',
avg(amount) as 'Avg_amount'
from orders;
--2. Create a user-defined function which will multiply the given number with 10
create function multiplybyten (@number int)
returns int
as
begin
declare @result int;
set @result=@number*10;
return @result
end;
select dbo.multiplybyten(7) as result;
---------------------------------------------lets try a more simpler way without declaring any variable.
create function mul_10 (@num int)
returns int
as
begin
return (@num*10)
end;
select dbo.mul_10(7) as result;
----liked the way it works. Great.
--3. Use the case statement to check if 100 is less than 200, greater than 200 or equal to 200 and print the corresponding value.
select
	case 
		when 100<200 then '100 is less than 200'
		when 100>200 then '100 is greater than 200'
	else '100 is equal to 200'
End as 'Result of question number 3';
--4. Using a case statement, find the status of the amount. Set the status of the
--amount as high amount, low amount or medium amount based upon the condition.
select*,
	case
		when amount < 40 then 'LOW AMOUNT'
		when amount between 40 and 80 then 'MEDIUM AMOUNT'
		else 'HIGH AMOUNT'
	end as 'AMOUNT_STATUS'
from orders;
--5. Create a user-defined function, to fetch the amount greater than the given input.
CREATE FUNCTION amount_greaterthan_input (@input_amount float)
returns table
as
return
(select amount from orders where amount > @input_amount);
----function is created----Lets try the function--Since it is a table valued function the syntax will be as follows:
select* from dbo.amount_greaterthan_input(50);
select*from dbo.amount_greaterthan_input(70);
select*from dbo.amount_greaterthan_input(100);
select*from dbo.amount_greaterthan_input(20);

--Thank you for the questions. It was interesting----
