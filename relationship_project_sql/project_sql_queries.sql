-- PROJECT 2 : Relational Database Design
/*
Problem Statement:
How to convert a relational design into tables in SQL Server?
Topics:
In this project, you will work on converting a relational design that enlists various
users, their roles, user accounts and their statuses into different tables in SQL
Server and insert data into them. Having at least two rows in each of the tables,
you have to ensure that you have created respective foreign keys.

Tasks To Be Performed: (refer the diagram from the pdf of PROJECT2 to create the tables)
Location of the file in the system : D:\Courses\Intelipaat\IITR_assignments\Projects

--> Define relations/attributes
--> Define primary keys
--> Create foreign keys

STEPWISE EXPLANATION OF HOW THE TASK WAS PERFORMED:
1) A database was created called 'user_roles' using the create database command in the query window.
(Alternatively --> go to Object Explorer --> Right click --> create new database --> Write the database name --> click add ---> ok)
2) Refresh the object explorer window--> click the + adjacent to Databases --> You can find the new Database
3) click the + button of the database user_roles and go to ---> Database Diagrams --> Right click on it --> create new Database Diagram

1. Insert data into each of the above tables. With at least two rows in each of
the tables. Make sure that you have created respective foreign keys.


2. Delete all the data from each of the tables.


*/

create database user_roles;

/* So when you go to --> Database Diagrams (under user_roles database) --> It shows to select tables for creating the diagram --> If the tables
are not created the pannel is empty --> So, lets create the tables first --> This time using the Object explorer tools and not by writing a query
as this is a part of the training --> for this --> Go to Tables (under user_roles database) --> right click on it --> got to new ---> Table --
--> enter column names, data type, null or not null--> select the column --> right click --> there u can set primary key if u want --> then-->
---> click the save button in the tool bar below the Menu bar --> Give table name and save

Issues encountered while saving and how it was handled :
1) 2 tables :
table 1 : dbo.user_has_role 
table 2 : dbo.user_has_status
both had 2 columns asking the data type to be [timestamp]. 
ISSUE : The current version of SQL server allows only one [timestamp] data type column.
SOLUTION : [datetime] was used instead of [timestamp]

2) table 3 : dbo.status
ISSUE : [bool] data type is not supported in the current SSMS version.
SOLUTION : [bit] was used instead

TO ESTABLISH RELATIONSHIPS AND CREATE FOREIGN KEYS :
--> Go to database diagrams --> right click --> new database diagram --> from the window --> hold ctrl + (Left mouse click all tables individually)--
--> click add --> All the tables are now shown in the diagram window --> select a table --> right click on it --> go to --> relationships--
--> A window will open saying foreign key relationships --> click on add to add a foreign key --> then go to [General] --> Tables and columns specifications --
--> select the table from where u want to take the primary key and the specific column and the goal table column which has to be related with --
--> primary key of the other doner table for the foreign key --> click ok --> check back the diagram --> u can see the foreign key is set

TO INSERT VALUES :
We used queries as we do in general.

TO DELETE TABLES :
We used queries as we do in general.

*/

select * from dbo.role;
insert into dbo.role values (1,'Developer'),(2,'Analyst'),(3,'Tester'),(4,'Manager'),(5,'HR'),(6,'CEO'),(7,'Director');

select * from dbo.user_account;
insert into dbo.user_account values 
(21,'Anirudh','asahu23@gmail.com','ani123','anisalt','anihash'),
(22,'Sonia','sonia23@gmail.com','sonia123','soniasalt','soniahash'),
(23,'Yash','yash23@gmail.com','yash123','yashsalt','yashhash'),
(24,'Anuradha','anu23@gmail.com','anu123','anusalt','anuhash'),
(25,'Chandrakant','chand23@gmail.com','chan123','chansalt','chanhash'),
(26,'Simran','sim23@gmail.com','sim123','simsalt','simhash'),
(27,'Rahul','rahu23@gmail.com','rah123','rahusalt','rahuhash');

select * from dbo.user_has_role;
-- Assuming you already have the 'user_has_role' table created
-- Insert 7 random records into the 'user_has_role' table

INSERT INTO user_has_role VALUES
    (31, '2023-10-02 08:00:00', '2023-10-02 17:00:00', 21, 1),
    (32, '2023-10-03 09:00:00', '2023-10-03 18:00:00', 22, 2),
    (33, '2023-10-04 10:00:00', '2023-10-04 19:00:00', 23, 3),
    (34, '2023-10-05 11:00:00', '2023-10-05 20:00:00', 24, 4),
    (35, '2023-10-06 12:00:00', '2023-10-06 21:00:00', 25, 5),
    (36, '2023-10-07 13:00:00', '2023-10-07 22:00:00', 26, 6),
    (37, '2023-10-08 14:00:00', '2023-10-08 23:00:00', 27, 7);

select * from dbo.status
-- Insert 5 random records into the 'dbo.status' table

INSERT INTO dbo.status (id, status_name, is_user_working) VALUES
(001, 'Active', 1),
(002, 'Inactive', 0),
(003, 'On Vacation', 0),
(004, 'Away', 1),
(005, 'Busy', 1);

select * from user_has_status;
insert into dbo.user_has_status values
(51, '2023-10-02 08:00:00', '2023-10-02 17:00:00', 21, 001),
(52, '2023-10-03 09:00:00', '2023-10-03 18:00:00', 22, 002),
(53, '2023-10-06 12:00:00', '2023-10-06 21:00:00', 25, 003),
(54, '2023-10-07 13:00:00', '2023-10-07 22:00:00', 26, 004),
(55, '2023-10-08 14:00:00', '2023-10-08 23:00:00', 27, 005);

--Lets check the tables we created with values :
select * from dbo.role;
select * from [dbo].[status];
select * from [dbo].[user_account];
select * from [dbo].[user_has_role];
select * from [dbo].[user_has_status];

--2. Delete all the data from each of the tables.
delete dbo.role;
--output:
/*
Msg 547, Level 16, State 0, Line 93
The DELETE statement conflicted with the REFERENCE constraint "FK_user_has_role_role". The conflict occurred in database "user_roles", table "dbo.user_has_role", column 'role_id'.
The statement has been terminated.

Completion time: 2023-10-02T21:12:04.5132650+05:30
*/
delete [dbo].[status];
--output:
/*
Msg 547, Level 16, State 0, Line 102
The DELETE statement conflicted with the REFERENCE constraint "FK_user_has_status_status". The conflict occurred in database "user_roles", table "dbo.user_has_status", column 'status_id'.
The statement has been terminated.

Completion time: 2023-10-02T21:12:54.2071368+05:30
*/
delete [dbo].[user_account];
--output:
/*
Msg 547, Level 16, State 0, Line 111
The DELETE statement conflicted with the REFERENCE constraint "FK_user_has_role_user_account". The conflict occurred in database "user_roles", table "dbo.user_has_role", column 'user_account_id'.
The statement has been terminated.

Completion time: 2023-10-02T21:14:04.4044186+05:30
*/
delete [dbo].[user_has_role];
--output:
/*
(7 rows affected)

Completion time: 2023-10-02T21:14:15.0138121+05:30
*/
delete [dbo].[user_has_status];
--output:
/*
(5 rows affected)

Completion time: 2023-10-02T21:14:32.7387280+05:30
*/
--NOTE : The tables those provide there column for reference as foreign key to another table cannot be deleted
--NOTE : The other tables can be deleted.