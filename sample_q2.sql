--IITR_assign3
--1. Create an ‘Orders’ table which comprises of these columns: ‘order_id’,‘order_date’, ‘amount’, ‘customer_id’
--2. Insert 5 new records.
CREATE TABLE orders (order_id int,order_date date, amount float, customer_id int)
insert into orders values 
(1001,'2023-05-15',50.20,101),
(1002,'2023-06-02',75.80,102),
(1003,'2023-05-28',100.50,103),
(1004,'2023-06-01',200.00,104),
(1005,'2023-05-10',30.75,106)
GO
select*from orders
update orders set customer_id=106 where order_id like 1005;
--3. Make an inner join on ‘Customer’ and ‘Order’ tables on the ‘customer_id’column
select*from customer inner join orders on customer.customer_id=orders.customer_id;
--4. Make left and right joins on ‘Customer’ and ‘Order’ tables on the‘customer_id’ column
select*from customer left join orders on customer.customer_id=orders.customer_id;
select*from customer right join orders on customer.customer_id=orders.customer_id;
--5. Make a full outer join on ‘Customer’ and ‘Orders’ table on the ‘customer_id’ column.
select*from customer full outer join orders on customer.customer_id=orders.customer_id;
--6. Update the ‘Orders’ table and set the amount to be 100 where‘customer_id’ is 103
update orders set amount=100 where customer_id like 103;
select*from orders