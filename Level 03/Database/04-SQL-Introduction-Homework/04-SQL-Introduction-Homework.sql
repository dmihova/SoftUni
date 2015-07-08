-- Problem 4.	Write a SQL query to find all information about all departments.
SELECT *  FROM Departments

-- Problem 5.	Write a SQL query to find all department names

SELECT Name  FROM Departments

--Problem 6.	Write a SQL query to find the salary of each employee. 
SELECT FirstName, LastName, Salary FROM Employees

--Problem 7.	Write a SQL to find the full name of each employee. 
SELECT (FirstName +' '+ LastName) as FullName FROM Employees

--Problem 8.	Write a SQL query to find the email addresses of each employee.
--Write a SQL query to find the email addresses of each employee. (by his first and last name).
-- Consider that the mail domain is softuni.bg. Emails should look like “John.Doe@softuni.bg". The produced column should be named "Full Email Addresses".
SELECT (FirstName +' '+ LastName) as FullName , (FirstName +'.'+ LastName+'@softuni.bg') as Email FROM Employees

--Problem 9.Write a SQL query to find all different employee salaries. 
SELECT DISTINCT Salary FROM Employees  

--Problem 10.	Write a SQL query to find all information about the employees whose job title is “Sales Representative“.
SELECT FirstName, LastName FROM Employees WHERE JobTitle = 'Sales Representative'
 
 --Problem 11.	Write a SQL query to find the names of all employees whose first name starts with "SA".
 SELECT FirstName,LastName FROM Employees WHERE FirstName like 'SA%'

 --Problem 12.	Write a SQL query to find the names of all employees whose last name contains "ei".
  SELECT FirstName,LastName FROM Employees WHERE LastName like '%ei%'
 
-- Problem 13.	Write a SQL query to find the salary of all employees whose salary is in the range [20000…30000].
    SELECT  Salary   FROM Employees WHERE Salary BETWEEN  20000 AND 30000 

--Problem 14.	Write a SQL query to find the names of all employees whose salary is 25000, 14000, 12500 or 23600.
  SELECT FirstName,LastName,Salary FROM Employees WHERE Salary in   (25000, 14000, 12500, 23600)

 -- Problem 15.	Write a SQL query to find all employees that do not have manager.
  SELECT FirstName,LastName,Salary FROM Employees WHERE ManagerID IS NULL

 --Problem 16.	Write a SQL query to find all employees that have salary more than 50000. Order them in decreasing order by salary.
   SELECT FirstName,LastName,Salary FROM Employees WHERE Salary >5000 ORDER BY Salary DESC

 --Problem 17.	Write a SQL query to find the top 5 best paid employees.
   SELECT TOP 5 FirstName,LastName,Salary FROM Employees  ORDER BY Salary DESC

--Problem 18.	Write a SQL query to find all employees along with their address.
 SELECT  FirstName,LastName,t.Name as TownName,AddressText 
 FROM Employees e  join Addresses a on e.AddressID=a.AddressID
 join Towns t  on a.TownId =t.TownID

-- Problem 19.	Write a SQL query to find all employees and their address.
 SELECT  FirstName,LastName,t.Name as TownName,AddressText 
 FROM Employees e, Addresses a, Towns t
 WHERE e.AddressID=a.AddressID AND a.TownId =t.TownID

 --Problem 20.	Write a SQL query to find all employees along with their manager.
  SELECT e.FirstName,e.LastName, (m.FirstName +' '+ m.LastName) as Manager  FROM Employees e join Employees m
  on e.ManagerID=m.EmployeeID
 
-- Problem 21.	Write a SQL query to find all employees, along with their manager and their address.
  SELECT e.FirstName,e.LastName, (m.FirstName +' '+ m.LastName) as Manager ,
		t.Name as TownName,AddressText  
  FROM Employees e join Employees m   on e.ManagerID=m.EmployeeID
	join Addresses a on e.AddressID=a.AddressID
	join Towns t  on a.TownId =t.TownID

--Problem 22.	Write a SQL query to find all departments and all town names as a single list.
SELECT d.Name FROM Departments d union SELECT t.Name FROM Towns t

--Problem 23.	Write a SQL query to find all the employees and the manager for each of them along with the employees that do not have manager. 
  SELECT e.FirstName,e.LastName, (m.FirstName +' '+ m.LastName) as Manager  FROM Employees e left join Employees m
  on e.ManagerID=m.EmployeeID

   SELECT e.FirstName,e.LastName, (m.FirstName +' '+ m.LastName) as Manager  FROM Employees m right join Employees e
  on e.ManagerID=m.EmployeeID

 -- Problem 24.	Write a SQL query to find the names of all employees from the departments "Sales" and "Finance" 
 --whose hire year is between 1995 and 2005

 SELECT e.FirstName, e.LastName,YEAR(e.HireDate) as HireYear,d.Name as DepartmentName FROM Employees e join Departments d on e.DepartmentID=d.DepartmentID
  WHERE d.Name in ('Sales', 'Finance') AND YEAR(e.HireDate) BETWEEN 1995 AND 2005

  --risk with data format
 SELECT e.FirstName, e.LastName, e.HireDate, d.Name as DepartmentName FROM Employees e  JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE  d.Name in ('Sales', 'Finance')  AND (e.HireDate BETWEEN '1995-01-01' AND '2005-12-31') 