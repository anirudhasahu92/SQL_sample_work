--PROJECT 1 : Querying a Large Relational Database
/*
Location:
https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks
File Name: AdventureWorks2012.bak

STEPS TO RESTORE THE DATABASE IN THE SQL SERVER :
1) DOWNLOAD THE FILE WITH THE PROVIDED NAME EXACTLY FROM THE LINK
2) Move the file to the backup folder in the SQL SERVER
PATH :
Download 'AdventureWorks2012.bak' under 'AdventureWorks (OLTP) full database backups' using the link:
'https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks' ---> Copy the file from the download --> go to
--> C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup ---> Paste the 'AdventureWorks2012.bak' file here --
--> In the SQL server --> Go to object Explorer ---> Right click on 'Databases' ---> Click on 'Restore Database' ---> Select 'Device' ---
--> click the '...' button ---> Ensure that in between file and url file is selected ---> Click on Add ---> The window automatically ---
---> opens up to the above path in the system to the backup folder where we pasted the file earlier ---> Select the file ---> Press 'OK' ---
---> A status bar will show the progress of restoration ---> A window will appear say that the restoration has been complete.

After this u can see that in the 'Databases'----> 'AdventureWorks2012' also shows up
--U can check the tables it conatains and now its ready to use.
*/

use AdventureWorks2012;

--3. Perform the following with help of the above database:

--a. Get all the details from the person table including email ID, phone number and phone number type.
select * from Person.EmailAddress;--If the table is not present in the default schema we have to use the respective schema
select * from Person.PersonPhone;
select * from Person.PhoneNumberType;
select * from Person.Person;
select p.*,e.EmailAddress,Ph.PhoneNumber,Pht.PhoneNumberTypeID
from Person.Person p, Person.EmailAddress e, Person.PersonPhone Ph, Person.PhoneNumberType Pht
where p.BusinessEntityID = e.BusinessEntityID and ph.BusinessEntityID = p.BusinessEntityID
and Ph.PhoneNumberTypeID = Pht.PhoneNumberTypeID;
--b. Get the details of the sales header order made in May 2011.
select * from [Sales].[SalesOrderHeader] where year(OrderDate) = 2011 and Month(OrderDate) = 5;
--c. Get the details of the sales details order made in the month of May 2011
select * from [Sales].[SalesOrderDetail] where SalesOrderID in (select SalesOrderID 
from [Sales].[SalesOrderHeader] where year(OrderDate) = 2011 and Month(OrderDate) = 5);
--d. Get the total sales made in May 2011.
select sum(LineTotal) as [Total_Sales_May2011] from [Sales].[SalesOrderDetail] where SalesOrderID in (select SalesOrderID 
from [Sales].[SalesOrderHeader] where year(OrderDate) = 2011 and Month(OrderDate) = 5);
--e. Get the total sales made in the year 2011 by month order by increasing sales.
SELECT Q.MONTH, Q.TOTAL_SALES FROM (SELECT 
    MONTH(soh.OrderDate) AS Month_NUM,
    SUM(soh.TotalDue) AS TOTAL_SALES,
	CASE
		WHEN MONTH(soh.OrderDate) = 1 THEN 'Jan'
	    WHEN MONTH(soh.OrderDate) = 2 then 'Feb'
	    WHEN MONTH(soh.OrderDate) = 3 then 'Mar'
	    WHEN MONTH(soh.OrderDate) = 4 then 'Apr'
	    WHEN MONTH(soh.OrderDate) = 5 then 'May'
	    WHEN MONTH(soh.OrderDate) = 6 then 'Jun'
	    WHEN MONTH(soh.OrderDate) = 7 then 'Jul'
	    WHEN MONTH(soh.OrderDate) = 8 then 'Aug'
	    WHEN MONTH(soh.OrderDate) = 9 then 'Sep'
	    WHEN MONTH(soh.OrderDate) = 10 then 'Oct'
	    WHEN MONTH(soh.OrderDate) = 11 then 'Nov'
	    WHEN MONTH(soh.OrderDate) = 12 then 'Dec'
	END AS 'MONTH'
FROM 
    Sales.SalesOrderHeader AS soh
WHERE 
    YEAR(soh.OrderDate) = 2011
GROUP BY 
    MONTH(soh.OrderDate))Q ORDER BY Q.TOTAL_SALES DESC;

--f. Get the total sales made to the customer with FirstName='Gustavo' and LastName ='Achong'
SELECT 
    p.FirstName,
    p.LastName,
    SUM(soh.TotalDue) AS TotalSales
FROM 
    Person.Person AS p
JOIN 
    Sales.Customer AS c
ON 
    p.BusinessEntityID = c.PersonID
JOIN 
    Sales.SalesOrderHeader AS soh
ON 
    c.CustomerID = soh.CustomerID
WHERE 
    p.FirstName = 'Gustavo'
    AND p.LastName = 'Achong'
GROUP BY 
    p.FirstName, p.LastName;
--Really Enjoyed the assignment. Thank you. 