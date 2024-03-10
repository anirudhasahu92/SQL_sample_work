--1. Find out the selling cost average for packages developed in Pascal.
SELECT AVG(SCOST) as Selling_cost_Avg 
FROM SOFTWARE
WHERE DEVELOPIN = 'PASCAL';
--2. Display the names and ages of all programmers.
select PNAME as 'Programmer_Name', YEAR(GETDATE())-YEAR(DOB) as 'Age' from programmer;
--3. Display the names of those who have done the DAP Course.
select PNAME as 'Programmer_Name', COURSE from studies where COURSE = 'DAP';
--4. Display the names and date of birth of all programmers born in January.
select PNAME as 'Programmer_Name', DOB from programmer where month(DOB) = 1; 
--5. What is the highest number of copies sold by a package?
--6. Display lowest course fee.
SELECT 
MIN(COURSE_FEE) as 'Least_course_fee' 
FROM studies;
--7. How many programmers have done the PGDCA Course?
select count(PNAME) as 'COUNT_PNAME_PGDCA' from studies where COURSE = 'PGDCA';
--8. How much revenue has been earned through sales of packages
--developed in C?
SELECT
SUM(SOLD*SCOST) as 'Revenue_from_c'
FROM software
WHERE DEVELOPIN='c';
--9. Display the details of the software developed by Ramesh.
SELECT*FROM software WHERE PNAME='RAMESH'
GO
--10. How many programmers studied at Sabhari?
SELECT
COUNT(PNAME) AS 'PROGRAMMER'
FROM studies
WHERE INSTITUTE='Sabhari';
/*(To check who all studies at 'Sabhari' we can proceed as below:
Note that the values in the rows and columns or even the name of the rows are not case sensitive 
when they are required to be called upon but when we need to 
create a new column (using alias) or update a new value we need to take care of the case.)*/
SELECT
PNAME as 'PROGRAMMER',
INSTITUTE 
FROM studies
WHERE INSTITUTE='SABHARI';
--11. Display details of packages whose sales crossed the 2000 mark.
select*from software where SCOST < 2000 order by SCOST desc;
--12. Display the details of packages for which development costs have been recovered.
select *,(SCOST * SOLD) AS [RECOVERY] from software where (SCOST * SOLD) >= DCOST ORDER BY [RECOVERY] DESC; 
--13. What is the cost of the costliest software development in Basic?
select TITLE as [SOFTWARE], DEVELOPIN, DCOST as [DEV_COST] from software where DCOST=(select max(DCOST) from software where DEVELOPIN='BASIC') and DEVELOPIN like 'BASIC';
--or we can use TOP() function and do it as below:
select TOP(1) TITLE as [SOFTWARE], DEVELOPIN, DCOST as [DEV_COST] from software where DEVELOPIN = 'BASIC' order by DCOST desc;
--14. How many packages have been developed in dBase?
select count(TITLE) as [No_of_Packages_dBase] from software where DEVELOPIN = 'DBASE';
--To see the packages those have been developed in dBase we can use the query below:
select TITLE, DEVELOPIN from software where DEVELOPIN = 'DBASE';
--15. How many programmers studied in Pragathi?
select count(PNAME) as [No_of_Programmers_Pragathi] from studies where INSTITUTE = 'PRAGATHI';
--16. How many programmers paid 5000 to 10000 for their course?
SELECT PNAME AS [PROGRAMMER], INSTITUTE, COURSE_FEE FROM STUDIES WHERE COURSE_FEE BETWEEN 5000 AND 10000 ORDER BY COURSE_FEE ASC;
--17. What is the average course fee?
SELECT AVG(COURSE_FEE) AS [AVG_COURSE_FEE] FROM STUDIES;
--18. Display the details of the programmers knowing C.
SELECT*FROM PROGRAMMER WHERE PROF1 = 'C' OR PROF2 = 'C';
--19. How many programmers know either COBOL or Pascal?
SELECT
COUNT(PNAME) AS 'PROGRAMMER'
FROM programmer
WHERE PROF1='COBOL' OR PROF1='PASCAL' OR PROF2='COBOL' OR PROF2='PASCAL';
--20. How many programmers don’t know Pascal and C?
SELECT
PNAME AS 'PROGRAMMER',
PROF1 AS 'LANGUAGE_1',
PROF2 AS 'LANGUAGE_2'
FROM programmer
WHERE PROF1='COBOL' OR PROF1='PASCAL' OR PROF2='COBOL' OR PROF2='PASCAL';
--21. How old is the oldest male programmer?
select max(year(GETDATE())-year(DOB)) as 'Age' from programmer WHERE GENDER='M';
--Getting the answer but not the name of the programmer
Select 
PNAME as 'Programmer',
year(GETDATE())-year(DOB) as 'Age'
from programmer WHERE GENDER='M' AND year(GETDATE())-year(DOB)= (SELECT MAX(year(GETDATE())-year(DOB)) FROM programmer) 
GROUP BY PNAME,DOB,GENDER
GO
--Does not show the age because the oldest person is a female.
--Lets use a bit lenghty strategy but it will still work. Lets create a temporary table with age and then use it.
Select 
PNAME as 'Programmer',
year(GETDATE())-year(DOB) as 'Age',
GENDER into #Temp_prog_M 
FROM programmer WHERE GENDER='M'
GO
SELECT*FROM #Temp_prog_M
select * from #Temp_prog_M where Age= (SELECT(Max(Age))FROM #Temp_prog_M);
--Works but lengthy. More easy way is to use the TOP keyword
SELECT TOP(1) WITH TIES 
PNAME,
year(GETDATE())-year(DOB) as 'Age',
GENDER
FROM programmer
WHERE gender = 'M' 
ORDER BY Age desc;
--Note that WITH TIES is used to break the tie if more than one people are having the same age. Here we don't want that so lets remove it.
SELECT TOP(1)  
PNAME,
year(GETDATE())-year(DOB) as 'Age',
GENDER
FROM programmer
WHERE gender = 'M'
ORDER BY Age desc
--Works great
--22. What is the average age of female programmers?
SELECT 
AVG(year(GETDATE())-year(DOB)) as 'Avg_age_F'
FROM programmer 
WHERE GENDER='F';
--23. Calculate the experience in years for each programmer and display with their names in descending order.
select
PNAME as 'Programmer',
year(GETDATE())-year(DOJ) as 'Experience'
from programmer
ORDER BY 'Experience' DESC
GO
--24. Who are the programmers who celebrate their birthdays during the current month?
select PNAME as [Programmer], DOB from programmer where MONTH(DOB)=MONTH(getdate());
--25. How many female programmers are there?
SELECT COUNT(GENDER) as 'Female_programmers' FROM programmer WHERE GENDER='F';
--26. What are the languages studied by male programmers?
SELECT*FROM programmer
SELECT PNAME AS 'Male_programmers', PROF1 as 'Language1', PROF2 as 'Language2', GENDER
FROM programmer WHERE GENDER='M' GROUP BY PNAME,PROF1,PROF2,GENDER;
--27. What is the average salary?
SELECT AVG(SALARY) AS 'Avg_Salary' FROM programmer;
--28. How many people draw a salary between 2000 to 4000?
SELECT
COUNT(PNAME) AS 'PROGRAMMER'
FROM programmer
WHERE SALARY BETWEEN 2000 AND 5000;
--TO SEE THE Programmers WHO draw a salary between 2000 to 4000
SELECT
PNAME AS 'PROGRAMMER',
SALARY
FROM programmer
WHERE  SALARY BETWEEN 2000 AND 5000
ORDER BY SALARY;
--29. Display the details of those who don’t know Clipper, COBOL or Pascal.
select*from programmer WHERE PROF1!='Clipper' AND PROF1!='C' AND 
PROF1!='PASCAL' and PROF2!='Clipper' AND PROF2!='C' AND PROF2!='PASCAL';
--30. Display the cost of packages developed by each programmer.
select PNAME as 'Programmer', TITLE as 'Packages', DCOST as 'Development_Cost' 
from software Group by PNAME,TITLE,DCOST order by PNAME;
--31. Display the sales value of the packages developed by each programmer.
select PNAME as 'Programmer', TITLE as 'Packages', SCOST as 'Selling_Price' 
from software Group by PNAME,TITLE,SCOST order by PNAME;
--32. Display the number of packages sold by each programmer.
select PNAME as 'Programmer', count(TITLE) as 'Packages_sold' from software group by PNAME order by  'Packages_sold' desc;
--33. Display the sales cost of the packages developed by each programmer language wise.
select PNAME as 'Programmer',TITLE as 'Packages',DEVELOPIN as 'Language',SCOST as 'Selling_Price' 
from software group by PNAME,TITLE,SCOST,DEVELOPIN order by DEVELOPIN;
--34. Display each language name with the average development cost, average selling cost and average price per copy.
select DEVELOPIN as 'language',avg(DCOST) as 'AVG_Dev_cost',avg(SCOST) as 'AVG_Selling_cost' from software group by DEVELOPIN order by DEVELOPIN;
--35. Display each programmer’s name and the costliest and cheapest packages developed by him or her.
select p.PNAME as [Programmer], max(s.SCOST) as [Costliest_Package], min(s.SCOST) as [Cheapest_Package] 
from programmer p, software s where p.PNAME=s.PNAME group by p.PNAME;
--36. Display each institute’s name with the number of courses and the average cost per course.
select INSTITUTE, count(COURSE) as [No_of_courses], avg(COURSE_FEE) as [avg_course_cost] from studies group by INSTITUTE order by avg(COURSE_FEE);
--37. Display each institute’s name with the number of students.
select INSTITUTE, count(PNAME) as [No_of_students] from studies group by INSTITUTE order by count(PNAME) desc;
--38. Display names of male and female programmers along with their gender.
select PNAME as [PROGRAMMER], GENDER from programmer;
--39. Display the name of programmers and their packages.
SELECT
PNAME as 'Programmer',
TITLE as 'Packages'
FROM software
ORDER BY PNAME
GO
--40. Display the number of packages in each language except C and C++.
select TITLE as [PACKAGE], DEVELOPIN as [Language] from software where DEVELOPIN != 'C' and DEVELOPIN != 'C++';
--41. Display the number of packages in each language for which development cost is less than 1000.
select*from software
SELECT DEVELOPIN AS Language, COUNT(DEVELOPIN) AS PackageCount
FROM software
WHERE DCOST < 1000
GROUP BY DEVELOPIN;
--42. Display the average difference between SCOST and DCOST for each package.
select TITLE AS 'PACKAGE', avg(abs(SCOST-DCOST)) as 'Avg(SCOST-DCOST)' FROM software group by TITLE order by avg(abs(SCOST-DCOST)) desc;
--43. Display the total SCOST, DCOST and the amount to be recovered for each programmer whose cost has not yet been recovered.
select PNAME as [Programemr], sum(SCOST) as [Total_SCOST],sum(DCOST) as [Total_DCOST] from software group by PNAME;
--44. Display the highest, lowest and average salaries for those earning more than 2000.
select*from programmer
select
max(SALARY) as 'Max_salary',
Min(SALARY) as 'Min_salary',
avg(SALARY) as 'avg_salary'
from programmer where SALARY>2000;
--45. Who is the highest paid C programmer?
select TOP (1) PNAME as 'Programmer',PROF1, PROF2, SALARY
from PROGRAMMER WHERE PROF1='C' 
OR PROF2='C' ORDER BY SALARY DESC;
--46. Who is the highest paid female COBOL programmer?
select TOP (1) PNAME as 'Programmer',PROF1, PROF2, SALARY
from PROGRAMMER WHERE GENDER='F' AND PROF1='COBOL' 
--47. Display the names of the highest paid programmers for each language.
--48. Who is the least experienced programmer?
SELECT TOP(1) WITH TIES
PNAME as 'Programmer',
YEAR(GETDATE())-YEAR(DOJ) as 'Experience',
GENDER,
DOB,
DOJ
FROM programmer 
ORDER BY 'Experience' asc
GO
--We don't need to mention order by asc (ascending) because it is a default setting unless mentioned otherwise.
--49. Who is the most experienced male programmer knowing PASCAL?
select*from programmer
SELECT TOP(1) WITH TIES
PNAME as 'Programmer',
YEAR(GETDATE())-YEAR(DOJ) as 'Experience',
GENDER,
DOB,
DOJ
FROM programmer 
WHERE GENDER='M' AND PROF1='PASCAL' OR PROF2='PASCAL'
ORDER BY 'Experience' desc
GO
--50. Which language is known by only one programmer?
SELECT*FROM programmer
SELECT PROF1 as 'Language' FROM PROGRAMMER 
GROUP BY PROF1 HAVING PROF1 NOT IN (SELECT PROF2 FROM PROGRAMMER) AND COUNT(PROF1)=1 
UNION SELECT PROF2 FROM PROGRAMMER GROUP BY PROF2 HAVING PROF2 NOT IN (SELECT PROF1 FROM PROGRAMMER) AND COUNT(PROF2)=1;
---This does not give name of the programmers.
-----------------------------------------------------Lets try this
SELECT*FROM programmer
SELECT DISTINCT P.PNAME as 'Programmer', Q.knownLanguage
from programmer P cross apply  (select P.PROF1 as knownLanguage union all select P.PROF2 as knownLanguage ) Q 
where Q.knownLanguage in (SELECT Q.knownLanguage
from programmer P cross apply (select P.PROF1 as knownLanguage union all select P.PROF2 as knownLanguage ) Q 
group by Q.knownLanguage having count(*)=1);
--This gives the names of the programmers as well. Here we have used the 'CROSS APPLY' operater and 'IN' operator that makes our work so easy.
--Here P and Q are used as alias. P is for the programmer table as a whole and Q is for the query which in future will give us a new column derived
--from the query we are going to give in the cross apply which is origibally derived from P. The column will be the union of PROF1 and PROF2 whole 
--in one column. But we donot want that. We want Programmer name and the unique language they know. So, we put a where condition and now we use IN
--operator. IN operator is similar to like. In the where clause we specify that the new column knownLanguage derived from the query Q should have 
--only one count. The query for including the name of the programmer we did that already in the main query. To understand more clearly we can run
--the part before the where clause separately and the part after IN separately to understand how the whole query is functioning.
--Thank you for the question. It was really interesting and also one of the most toughest question in this assignment.
--CROSS APPLY and IN are important (very powerful)
--51. Who is the above programmer referred in 50?
SELECT DISTINCT P.PNAME as 'Programmer', Q.knownLanguage
from programmer P cross apply  (select P.PROF1 as knownLanguage union all select P.PROF2 as knownLanguage ) Q 
where Q.knownLanguage in (SELECT Q.knownLanguage
from programmer P cross apply (select P.PROF1 as knownLanguage union all select P.PROF2 as knownLanguage ) Q 
group by Q.knownLanguage having count(*)=1);
--52. Who is the youngest programmer knowing dBase?
SELECT TOP(1) WITH TIES
PNAME as 'Programmer',
YEAR(getdate())-YEAR(DOB) as 'Age',
PROF1 as 'Language_1',
PROF2 as 'Language_2'
FROM programmer
WHERE PROF1='DBASE' or PROF2='DBASE' 
ORDER BY 'Age'
GO
--53. Which female programmer earning more than 3000 does not know C, C++, Oracle or dBase?
SELECT
PNAME as 'Programmer',
PROF1 as 'Language_1',
PROF2 as 'Language_2',
SALARY, GENDER
FROM programmer
WHERE GENDER='F' AND SALARY>3000 AND PROF1!='C' AND  PROF1!='C++' AND PROF1!='ORACLE' AND PROF1!='DBASE' AND PROF2!='C' 
AND PROF2!='C++' AND PROF2!='ORACLE' AND PROF2!='DBASE';
--As the programmer does not know any of the above languages we need to use 'AND' operator instead of 'OR'. Do not go by the words.
--54. Which institute has the most number of students?
select TOP(1) INSTITUTE, count(PNAME) as 'No_of_students' from studies group by INSTITUTE order by count (PNAME) desc;
--55. What is the costliest course?
select COURSE, COURSE_FEE from studies where COURSE_FEE=(select max(COURSE_FEE) from studies);
--56. Which course has been done by the most number of students?
select TOP(1) with ties COURSE, count(PNAME) as 'No_of_students' from studies group by COURSE order by count (PNAME) desc;
--57. Which institute conducts the costliest course?
select INSTITUTE, COURSE_FEE from studies where COURSE_FEE=(select max(COURSE_FEE) from studies);
--or we can use top
select TOP(1) INSTITUTE, COURSE_FEE from studies group by INSTITUTE, COURSE_FEE order by COURSE_FEE desc;
--58. Display the name of the institute and the course which has below average course fee.
select DISTINCT INSTITUTE, COURSE, COURSE_FEE from studies 
where COURSE_FEE<(select avg(COURSE_FEE)from studies) order by COURSE_FEE desc;
--59. Display the names of the courses whose fees are within 1000 (+ or -) of the average fee.
select COURSE, COURSE_FEE from studies 
where COURSE_FEE between (select avg(COURSE_FEE)-1000 from studies) and (select avg(COURSE_FEE)+1000 from studies);
--60. Which package has the highest development cost?
select TITLE as [Package], DCOST as [Development_cost] from software where DCOST=(select max(DCOST) from software);
--61. Which course has below average number of students?
SELECT*FROM STUDIES;
SELECT Q.COURSE, Q.NO_OF_STUDENTS FROM (SELECT COURSE, COUNT(PNAME) AS [NO_OF_STUDENTS] 
FROM STUDIES GROUP BY COURSE)Q WHERE
Q.NO_OF_STUDENTS <
(SELECT AVG(Q.NO_OF_STUDENTS) AS [AVG_NO_OF_STUDENTS] 
FROM (SELECT COURSE, COUNT(PNAME) AS [NO_OF_STUDENTS] 
FROM STUDIES GROUP BY COURSE)Q);
--LET'S CHECK WHY OUR ANSWER IS EMPTY
SELECT AVG(Q.NO_OF_STUDENTS) AS [AVG_NO_OF_STUDENTS] FROM (SELECT COURSE, COUNT(PNAME) AS [NO_OF_STUDENTS] FROM STUDIES GROUP BY COURSE)Q;
--WE CAN SEE HERE THAT THE AVG NUMBER OF STUDENTS IS 1 (WHICH IS ACTUALLY 1.87, BUT IN SQL USING THE AVG() IT GIVES 1)
--ALREADY TRIED USING FLOOR() AND CELING(). DIDN'T WORK. SAME ANSWER FOR AVG() I.E; 1.
--SINCE AVG() STUDENTS JOINING ANY COURSE IS ONE THERE IS NO COURSE THAT TAKES STUDENT LESS THAN ONE. LET'S CHECK IF ANY COURSE TAKES STUDENT
--EQUAL TO THE AVG NUMBER OF STUDENTS BELOW:(FOR THIS JUST CHANGE THE < SIGN TO = )
SELECT Q.COURSE, Q.NO_OF_STUDENTS FROM (SELECT COURSE, COUNT(PNAME) AS [NO_OF_STUDENTS] 
FROM STUDIES GROUP BY COURSE)Q WHERE
Q.NO_OF_STUDENTS =
(SELECT AVG(Q.NO_OF_STUDENTS) AS [AVG_NO_OF_STUDENTS] 
FROM (SELECT COURSE, COUNT(PNAME) AS [NO_OF_STUDENTS] 
FROM STUDIES GROUP BY COURSE)Q);
--WE CAN SEE OUR QUERY WORKS CORRECTLY
--LET'S CHECK IF ANY COURSE TAKES STUDENT > THE AVG NUMBER OF STUDENTS BELOW:(FOR THIS JUST CHANGE THE < SIGN TO > )
SELECT Q.COURSE, Q.NO_OF_STUDENTS FROM (SELECT COURSE, COUNT(PNAME) AS [NO_OF_STUDENTS] 
FROM STUDIES GROUP BY COURSE)Q WHERE
Q.NO_OF_STUDENTS >
(SELECT AVG(Q.NO_OF_STUDENTS) AS [AVG_NO_OF_STUDENTS] 
FROM (SELECT COURSE, COUNT(PNAME) AS [NO_OF_STUDENTS] 
FROM STUDIES GROUP BY COURSE)Q);
--HERE WE SEE OUR QUERY STILL WORKS
--62. Which package has the lowest selling cost?
SELECT DISTINCT
TITLE as 'Package',
SCOST as 'Selling_cost'
FROM software
WHERE SCOST=(SELECT(MIN(SCOST))FROM software);
--or we can use TOP clause as shown below:
select distinct TOP(1) with ties
TITLE as 'Package',
SCOST as 'Selling_cost'
from software order by SCOST asc;
--63. Who developed the package that has sold the least number of copies?
select PNAME as [Programmer], TITLE as [Package], SOLD from software where SOLD=(select min(SOLD) from software);
--64. Which language has been used to develop the package which has the highest sales amount?
select DEVELOPIN as [Language], TITLE as [Package],SCOST*SOLD as [Sales_amount]
from software where SCOST*SOLD = (select max(SCOST*SOLD) from software);
--65. How many copies of the package that has the least difference between development and selling cost were sold?
select TITLE as 'Package', SOLD as 'Copies_sold', ABS(DCOST-SCOST) as 'DCOST-SCOST' 
from software where ABS(DCOST-SCOST)= (select min(ABS(DCOST-SCOST)) from software);
--66. Which is the costliest package developed in Pascal?
select TITLE as 'Package', DEVELOPIN as 'Language', SCOST as 'Selling_Price' 
from software where SCOST=(select max(scost) from software where DEVELOPIN='PASCAL') AND DEVELOPIN='PASCAL';
--67. Which language was used to develop the most number of packages?
select top(1) DEVELOPIN, count(TITLE) as [No_of_packages] from software group by DEVELOPIN order by count(TITLE) desc;
--68. Which programmer has developed the highest number of packages?
select top(1) PNAME as [Programmer], count(TITLE) as [No_of_packages] from software group by PNAME order by count(TITLE) desc;
--69. Who is the author of the costliest package?
--If we consider the costliest package to be based on the 'Development Cost' of the package
select*from software;
select PNAME as 'Author',TITLE as 'Package', DCOST as 'Dev_cost' 
from software where DCOST=(select(max(DCOST)) from software);
--70. Display the names of the packages which have sold less than the average number of copies.
select TITLE as 'Package', SOLD as 'Copies_sold' 
from software where SOLD<(select avg(SOLD) from software) order by SOLD;
--71. Who are the authors of the packages which have recovered more than double the development cost?
SELECT DISTINCT
PNAME as 'Authors',
TITLE as 'Package',
DCOST as 'Development_cost',
SCOST*SOLD as 'Recovery',
SCOST*SOLD-DCOST as 'Profit',
SCOST*SOLD/DCOST as 'Times_recovery'
FROM software
WHERE SCOST*SOLD>2*DCOST
ORDER BY 'Times_recovery'
GO
--72. Display the programmer names and the cheapest packages developed by them in each language.
SELECT*FROM software;
SELECT S.PNAME, Q.DEVELOPIN, Q.MIN_SCOST FROM (SELECT DEVELOPIN,MIN(SCOST) AS [MIN_SCOST] 
FROM SOFTWARE GROUP BY DEVELOPIN)Q, SOFTWARE S WHERE S.SCOST = Q.MIN_SCOST ORDER BY Q.MIN_SCOST;
--73. Display the language used by each programmer to develop the highest selling and lowest selling package.
SELECT T.PNAME, T.DEVELOPIN, T.SCOST, T.SCOST_HIGH_OR_LOW FROM (SELECT R.PNAME, R.DEVELOPIN, R.SCOST, R.D_RANK, 
CASE
	WHEN R.D_RANK = 1 THEN 'HIGHEST'
END AS 'SCOST_HIGH_OR_LOW'
FROM (SELECT Q.PNAME, Q.DEVELOPIN, Q.SCOST, DENSE_RANK()OVER(PARTITION BY PNAME ORDER BY Q.SCOST DESC) AS D_RANK
FROM (select PNAME, DEVELOPIN, max(SCOST) AS [SCOST] from software group by PNAME,DEVELOPIN
UNION
select PNAME, DEVELOPIN, MIN(SCOST) As [SCOST] from software group by PNAME,DEVELOPIN)Q)R
UNION
SELECT S.PNAME, S.DEVELOPIN, S.SCOST, S.D_RANK, 
CASE
	WHEN S.D_RANK = 1 THEN 'LEAST'
END AS 'SCOST_HIGH_OR_LOW'
FROM (SELECT Q.PNAME, Q.DEVELOPIN, Q.SCOST, DENSE_RANK()OVER(PARTITION BY PNAME ORDER BY Q.SCOST ASC) AS D_RANK
FROM (select PNAME, DEVELOPIN, max(SCOST) AS [SCOST] from software group by PNAME,DEVELOPIN
UNION
select PNAME, DEVELOPIN, MIN(SCOST) As [SCOST] from software group by PNAME,DEVELOPIN)Q)S)T WHERE T.SCOST_HIGH_OR_LOW IN ('LEAST','HIGHEST');
--NOTE : Since there are few programmers those have developed only one package both HIGHEST and LEAST SCOST for them will be the same as shown
-- in the output. Thank you for the question. Hope this answer is satisfactory.

--74. Who is the youngest male programmer born in 1965?
SELECT TOP(1) WITH TIES
PNAME as 'Programmer',
YEAR(getdate())-year(DOB) as 'Age',
DOB
FROM programmer
WHERE GENDER='M' AND YEAR(DOB)='1965'
ORDER BY DOB desc
GO
--If you order by age as there is difference in month and days as well we might not get the required result. So, order by DOB.
--If you order in ascending order 
--as we can see 08 is smaller in 1965-08-31 than 11 in 1965-11-10 so the system takes QADIR as younger which is not correct.
--Thus, order by Desc to get the right answer.
--There is month difference inbetween the persons. So, lets try another way of find the Age. 
SELECT TOP(1) WITH TIES
PNAME as 'Programmer',
datediff(MONTH,DOB, getdate())/12 - case when month(DOB)=month(getdate()) and day(DOB) > day(getdate()) then 1 else 0 end as 'Age',
DOB
FROM programmer
WHERE GENDER='M' AND YEAR(DOB)='1965'
ORDER BY DOB desc
GO
/* First we find the month difference between the two dates. 
We calculate the age by dividing this number by 12. With the 
“case when month(birthDate)=month(getdate()) and day(birthdate) > day(getdate())
then 1 else 0” code, we check whether the month of the current date and the month of the birth date 
are the same month and Is the day of the month he was born greater than the day of the current date?
*/
--The age calculation is now a bit more correct than earlier.
--75. Who is the oldest female programmer who joined in 1992?
SELECT TOP(1) WITH TIES
PNAME as 'Programmer',
YEAR(GETDATE())-YEAR(DOB) as 'Age',
GENDER,
DOB,
DOJ
FROM programmer 
WHERE GENDER='F' AND YEAR(DOJ)='1992'
ORDER BY 'Age' desc
GO
--76. In which year was the most number of programmers born?
SELECT TOP 1 YEAR(DOB) AS BirthYear, 
COUNT(PNAME) AS NumberOfProgrammers
FROM programmer
GROUP BY YEAR(DOB)
ORDER BY NumberOfProgrammers DESC;
--77. In which month did the most number of programmers join?
SELECT TOP 1 MONTH(DOJ) as 'Month_of_joining_irrespective_of_year', 
COUNT(PNAME) AS NumberOfProgrammers
FROM programmer
GROUP BY MONTH(DOJ)
ORDER BY NumberOfProgrammers DESC;
--78. In which language are most of the programmer’s proficient?
select PROF, Programmers from (select PROF, count(PNAME) as Programmers from 
(select PNAME, PROF1 as PROF from programmer UNION ALL select PNAME, PROF2 as PROF from programmer) 
as query group by PROF) as subquery2 where 
Programmers=(select max(programmers) from (select PROF, count(PNAME) as Programmers from 
(select PNAME, PROF1 as PROF from programmer UNION ALL select PNAME, PROF2 as PROF from programmer) 
as query group by PROF) as subquery3);
--removed the order by clause within the subqueries as it was creating trouble
--79. Who are the male programmers earning below the average salary of female programmers?
select PNAME as 'Programmer', GENDER, SALARY from programmer
where SALARY<(select avg(salary) from programmer where Gender='F') and GENDER='M';
--80. Who are the female programmers earning more than the highest paid?
select PNAME as 'Programmer', GENDER, SALARY from programmer
where SALARY>(select max(salary) from programmer where GENDER='M') and GENDER='F';
--81. Which language has been stated as the proficiency by most of the programmers?
select PROF, Programmers from (select PROF, count(PNAME) as Programmers from 
(select PNAME, PROF1 as PROF from programmer UNION ALL select PNAME, PROF2 as PROF from programmer) 
as query group by PROF) as subquery2 where 
Programmers=(select max(programmers) from (select PROF, count(PNAME) as Programmers from 
(select PNAME, PROF1 as PROF from programmer UNION ALL select PNAME, PROF2 as PROF from programmer) 
as query group by PROF) as subquery3);
--removed the order by clause within the subqueries as it was creating trouble
--82. Display the details of those who are drawing the same salary.
--Lets check the table first:
select*from programmer;
--We can use the SALARY from the query below as sub-query:
select SALARY,count(PNAME) as  [No_of_Programmers] from programmer group by SALARY having count(PNAME) > 1);
--Lets do it:
select * from programmer where SALARY = (select SALARY from programmer group by SALARY having count(PNAME) > 1);
--Throws error:
/*
Msg 512, Level 16, State 1, Line 450
Subquery returned more than 1 value. This is not permitted when the subquery follows =, !=, <, <= , >, >= or when the subquery is used as an expression.

Completion time: 2023-09-24T23:21:14.8198481+05:30
*/
--Soluiton. Use IN operator:
select * from programmer where SALARY in (select SALARY from programmer group by SALARY having count(PNAME) > 1) order by SALARY desc;
--The above  is the final query
--solved. Thank you for the question.
--83. Display the details of the software developed by the male programmers earning more than 3000.
select s.PNAME,p.GENDER, p.SALARY, s.TITLE,s.DEVELOPIN,s.SCOST,s.DCOST,s.SOLD 
from software s,programmer p where s.PNAME=p.PNAME and p.SALARY>3000 and p.GENDER='M';
--84. Display the details of the packages developed in Pascal by the female programmers.
select s.*, p.GENDER from software s,programmer p  where s.PNAME=p.PNAME and s.DEVELOPIN='PASCAL' and p.GENDER='F';
--85. Display the details of the programmers who joined before 1990.
select*from programmer where year(DOJ)<1990; 
--86. Display the details of the software developed in C by the female programmers at Pragathi.
select s.*, p.GENDER, sd.INSTITUTE from software s join programmer p on s.PNAME=p.PNAME join studies sd on p.PNAME=sd.PNAME 
where s.DEVELOPIN='C' and sd.INSTITUTE='Pragathi' p.GENDER='F';
--alternate way of writing the same query
select s.*, p.GENDER, sd.INSTITUTE from software s,programmer p, studies sd where s.PNAME=p.PNAME and p.PNAME=sd.PNAME 
and s.DEVELOPIN='C' and sd.INSTITUTE='Pragathi' and p.GENDER='F';
--so, there are no softwares developed in C at Pragathi. Therefore, not looking for females any more.
--87. Display the number of packages, number of copies sold and sales value of each programmer institute wise.
SELECT s.PNAME AS ProgrammerName,
       p.INSTITUTE AS Institute,
       COUNT(s.PNAME) AS NumberOfPackages,
       SUM(s.SOLD) AS NumberOfCopiesSold,
       SUM(s.SCOST * s.SOLD) AS SalesValue
FROM software s
JOIN studies p ON s.PNAME = p.PNAME
GROUP BY s.PNAME, p.INSTITUTE;
--88. Display the details of the software developed in dBase by male programmers who belong to the institute in which the most number of
--programmers studied.
--Lets check the table first:
select * from software;
select*from programmer;
--Lets write the query:
select s.TITLE as [Software], s.DEVELOPIN as [Language], s.DCOST,s.SCOST,s.SOLD, p.PNAME as [Developer], p.GENDER 
from software s, programmer p where s.PNAME = p.PNAME and s.DEVELOPIN = 'DBASE' and p.GENDER = 'M';
--89. Display the details of the software developed by the male programmers born before 1965 and female programmers born after 1975.
select s.TITLE as [Software], s.DEVELOPIN as [Language], s.DCOST,s.SCOST,s.SOLD, p.PNAME as [Developer], year(DOB) as [Birth_year], p.GENDER 
from software s, programmer p where s.PNAME = p.PNAME and p.GENDER = 'M' and year(DOB) < 1965 
UNION
select s.TITLE as [Software], s.DEVELOPIN as [Language], s.DCOST,s.SCOST,s.SOLD, p.PNAME as [Developer], year(DOB) as [Birth_year], p.GENDER 
from software s, programmer p where s.PNAME = p.PNAME and p.GENDER = 'F' and year(DOB) > 1975;
--No records found
--90. Display the details of the software that has been developed in the language which is neither the first nor the second proficiency of the
--programmers.
select * from software where DEVELOPIN not in (select prof1 from programmer)
intersect
select * from software where DEVELOPIN not in (select prof2 from programmer)
--or we can use this:
select * from software where DEVELOPIN not in (select prof1 from programmer) and DEVELOPIN not in (select prof2 from programmer);
--91. Display the details of the software developed by the male students at Sabhari.
select s.*, p.GENDER, sd.INSTITUTE from software s join programmer p on s.PNAME=p.PNAME join studies sd on p.PNAME=sd.PNAME 
where sd.INSTITUTE='Sabhari' and p.GENDER='M';
--92. Display the names of the programmers who have not developed any packages.
select q.PROGRAMMER, q.TITLE as [Package] from (select distinct p.PNAME as [PROGRAMMER], s.TITLE 
from programmer p left join software s on p.PNAME=s.PNAME) q where q.TITLE IS NULL;
--the above one was a bit complicated. WE can use a simpler query as shown below
select distinct p.PNAME as [PROGRAMMER], s.TITLE from programmer p left join software s on p.PNAME=s.PNAME where s.TITLE IS NULL;
--note we cannot say where TITLE='NULL'. It didn't work. I tried. Instead use IS NULL operator.
--93. What is the total cost of the software developed by the programmers of Apple?
SELECT Q.PNAME, SUM(Q.DCOST) AS [TOTAL_DEV_COST], SUM(Q.SCOST * Q.SOLD) AS [TOTAL_SALES_VALUE] FROM 
(SELECT * FROM SOFTWARE WHERE PNAME = (SELECT PNAME FROM STUDIES WHERE INSTITUTE = 'Apple'))Q GROUP BY Q.PNAME;
--94. Who are the programmers who joined on the same day?
--Programmers who joined exactly on the same day:
SELECT A.PNAME AS Programmer1, B.PNAME AS Programmer2, A.DOJ AS JoinDate
FROM programmer A
INNER JOIN programmer B ON A.PNAME < B.PNAME AND A.DOJ = B.DOJ;
--This is an interesting approach where I learned we can use < or > during joining instead of always an = . 
/*
By specifying A.PNAME < B.PNAME, we are essentially saying that we want to pair up programmers where the name of the first programmer (A) 
comes before the name of the second programmer (B) when sorted alphabetically.This condition ensures that each pair of programmers is 
considered only once, avoiding duplicates like (Programmer1, Programmer2) and (Programmer2, Programmer1) for the same pair.
*/
/*
--To inderstand better lets try every possible scenario:
SELECT A.PNAME AS Programmer1, B.PNAME AS Programmer2, A.DOJ AS JoinDate
FROM programmer A
INNER JOIN programmer B ON A.PNAME = B.PNAME AND A.DOJ = B.DOJ; --Regular Inner join where we can see all the values from both the tables are taken

SELECT A.PNAME AS Programmer1, B.PNAME AS Programmer2, A.DOJ AS JoinDate
FROM programmer A
INNER JOIN programmer B ON A.PNAME < B.PNAME AND A.DOJ = B.DOJ;  --First value for comparision is taken from Table A and compared to value in Table B. No duplicates.

SELECT A.PNAME AS Programmer1, B.PNAME AS Programmer2, A.DOJ AS JoinDate
FROM programmer A
INNER JOIN programmer B ON A.PNAME > B.PNAME AND A.DOJ = B.DOJ; -- First value for comparision is taken from Table B follwed by Table A. No duplicates.
SELECT A.PNAME AS Programmer1, B.PNAME AS Programmer2, A.DOJ AS JoinDate
FROM programmer A
INNER JOIN programmer B ON A.PNAME <> B.PNAME AND A.DOJ = B.DOJ;    -- goes both ways (Programmer1,Programmer2) and (Programmer2,Programmer1)
*/

--95. Who are the programmers who have the same Prof2?
--Lets use the same strategy as in question number 94 :
SELECT A.PNAME AS Programmer1, B.PNAME AS Programmer2, A.PROF2 AS PROF2
FROM programmer A
INNER JOIN programmer B ON A.PNAME < B.PNAME AND A.PROF2 = B.PROF2;
--The result gives programmer names in pairs those have the same PROF2
--Serves the purpose. Thank you for the question.
--96. Display the total sales value of the software institute wise.
SELECT p.INSTITUTE AS Institute,
       SUM(s.SCOST * s.SOLD) AS SalesValue
FROM software s
JOIN studies p ON s.PNAME = p.PNAME
GROUP BY p.INSTITUTE;
--97. In which institute does the person who developed the costliest package study?
SELECT*FROM SOFTWARE;
SELECT*FROM PROGRAMMER;
SELECT*FROM STUDIES;
select S.PNAME as [DEVELOPER], D.INSTITUTE, S.TITLE AS [PACKAGE], S.SCOST AS [PACKAGE_SCOST_HIGHEST] 
FROM SOFTWARE S, STUDIES D, PROGRAMMER P WHERE S.PNAME = P.PNAME AND P.PNAME = D.PNAME 
AND S.SCOST = (SELECT MAX(SCOST) AS [MAX_SCOST] FROM SOFTWARE);
--98. Which language listed in Prof1, Prof2 has not been used to develop any package?
select PROF1 as [Language_not_used_to_develop_any_package] from programmer where PROF1 not in (select developin from software) 
UNION
select PROF2 as [Language_not_used_to_develop_any_package] from programmer where PROF2 not in (select developin from software) 
--99. How much does the person who developed the highest selling package earn and what course did he/she undergo?
select*from studies 
select*from software
-- Lets first get the person with the highest selling:
select S.PNAME,S.SOLD,(S.SCOST*S.SOLD)-S.DCOST as [Earnings] from software S 
where S.SOLD = (Select max(SOLD) from software);
--We got 2 names from above. Now lets get there schools:
select S.PNAME,S.SOLD,(S.SCOST*S.SOLD)-S.DCOST as [Earnings], D.COURSE from software S, 
studies D where S.PNAME = D.PNAME AND S.SOLD in (Select max(SOLD) from software);
--We got only the name of Mary. This suggests that the name 'Pattrick' is not there is 'Studies'. Checked
--> Instead 'PATRICK' is there in studies and 'PATTRICK' is there is software. There is a spelling mistake. 
-- Thus to get both the names we can do a LEFT JOIN putting SOFTWARE in the left as shown below:
SELECT S.PNAME, S.SOLD, (S.SCOST * S.SOLD) - S.DCOST AS [Earnings], D.COURSE
FROM software S
LEFT JOIN studies D ON S.PNAME = D.PNAME
WHERE S.SOLD IN (SELECT MAX(SOLD) FROM software);	
--100. What is the average salary for those whose software sales is more than 50,000?
SELECT AVG(R.SALARY) AS [AVG_SALARY_OF_PROGRAMMERS_WHOSE_SALES_AMOUNT_>_50K] FROM 
(SELECT Q.PNAME, Q.SALES_AMOUNT, Q.SALARY AS [SALARY] FROM (SELECT P.PNAME, P.SALARY,
(S.SCOST * S.SOLD) AS [SALES_AMOUNT] FROM PROGRAMMER P, 
SOFTWARE S WHERE P.PNAME = S.PNAME)Q WHERE Q.SALES_AMOUNT > 50000)R;
--101. How many packages were developed by students who studied in institutes that charge the lowest course fee?
SELECT*FROM SOFTWARE;
SELECT Q.PNAME, COUNT(S.TITLE) AS [NO_OF_PACKAGES] FROM 
(SELECT PNAME FROM STUDIES WHERE COURSE_FEE IN (SELECT MIN(COURSE_FEE) FROM STUDIES))Q, SOFTWARE S WHERE Q.PNAME = S.PNAME GROUP BY Q.PNAME;
--102. How many packages were developed by the person who developed the cheapest package? Where did he/she study?
SELECT Q.PNAME, COUNT(S.TITLE) AS [NO_OF_PACKAGES], S.DCOST AS [PACKAGE_DCOST] FROM 
(SELECT PNAME FROM SOFTWARE WHERE DCOST IN (SELECT MIN(DCOST) FROM SOFTWARE))Q, SOFTWARE S WHERE Q.PNAME = S.PNAME GROUP BY Q.PNAME,S.DCOST;
--103. How many packages were developed by female programmers earning more than the highest paid male programmer?
select count(s.TITLE) as [Packages] from software s, programmer p where s.PNAME=p.PNAME
and p.GENDER='F' and p.SALARY>(select max(SALARY) from programmer where Gender='M');
--104. How many packages are developed by the most experienced programmers from BDPS?
SELECT TOP(1) Q.PNAME, Q.EXPERIENCE, F.PACKAGE_COUNT, Q.INSTITUTE 
FROM (SELECT P.PNAME, YEAR (GETDATE())-YEAR(P.DOJ) AS [EXPERIENCE], D.INSTITUTE 
FROM PROGRAMMER P, STUDIES D WHERE P.PNAME = D.PNAME)Q,
(SELECT PNAME,COUNT(DEVELOPIN) AS [PACKAGE_COUNT] FROM SOFTWARE GROUP BY PNAME)F
WHERE Q.PNAME = F.PNAME AND Q.INSTITUTE = 'BDPS' ORDER BY Q.EXPERIENCE DESC;
--It's really inetresting to see how we can use different subqueries with alias as tables and use them after where clause using commas.
--105. List the programmers (from the software table) and the institutes they studied at.
SELECT distinct s.PNAME as 'Programmer', Sd.INSTITUTE  
from SOFTWARE S, STUDIES sd where s.PNAME=sd.PNAME;
--106. List each PROF with the number of programmers having that PROF and the number of the packages in that PROF.
select q.PROF, count(pr.pname) as [No_of_Programmers], count(s.TITLE) as [No_of_Packages] from (select distinct PROF1 as prof from programmer
union
select distinct prof2 as prof from programmer)q
left join programmer pr on q.prof = pr.PROF1 or q.prof =  pr.PROF2
left join software s on pr.PNAME = s.PNAME group by q.prof;  --The count() does not count NULL values. So, chill.
--Solved. Thank you for the question. Cleared my doubt regarding Joins and intersects. We do not need to have same number of columns to operate
--joins as we can see above. Something like this cannot be done with Intersect as it requires same number of columns to perform an Intersect.
--107. List the programmer names (from the programmer table) and the number of packages each has developed.
select P.PNAME as 'Programmer',COUNT(S.TITLE) as 'No_of_packages_developed' 
from PROGRAMMER P, SOFTWARE S where P.PNAME=S.PNAME group by P.PNAME;

