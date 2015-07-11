--Problem 1.	Easy Nested SELECT Statement
--Write a SQL query to find the full name of the employee, his manager full name and the JobTitle
--from Sales department. Use nested select statement

SELECT e.FirstName + ' ' + e.LastName AS  Employee ,e.JobTitle, m.FirstName + ' ' + m.LastName AS  Manager 
FROM Employees AS e  JOIN Employees AS m ON e.ManagerID = m.EmployeeID
WHERE e.DepartmentID IN  (SELECT d.DepartmentID FROM Departments AS d  WHERE d.Name = 'Sales')

--Problem 2.	Nested SELECT Statement
--Write a SQL query to find the FullName, Salary and Department Name for the top 5 employees ordered by salary in descending order,
-- under the average salary for their department. 

SELECT TOP 5 e.FirstName, e.LastName, e.Salary,d.Name 
	FROM  Employees e  JOIN Departments d on e.DepartmentID =d.DepartmentID
	WHERE Salary <(SELECT AVG(s.Salary) as AVGS FROM Employees s 
				   WHERE s.DepartmentID=d.DepartmentID 
				   GROUP By s.DepartmentID)
	ORDER BY e.Salary DESC

-- Problem 3.	Aggregating Data
-- Display all project with the sum of their employee’s salaries.
 SELECT p.Name,sum(e.Salary) as [Employee Salaries]
FROM Projects p join EmployeesProjects ep on p.ProjectID=ep.ProjectID
join Employees e on ep.EmployeeID=e.EmployeeID
GROUP By p.Name
ORDER BY p.Name

--Problem 4.	Data Definition Language
--Create two tables. Companies and Conferences. 
--Companies have Name, EmployeesCount, FoundedIn. 
--Conferences have Name, Price (optional), FreeSeats, Venue and Organizer (Company).
 
CREATE TABLE Companies (
	ID int IDENTITY,
	Name nvarchar(50) NOT NULL,
	EmployeesCount int NOT NULL,
	FoundedIn int NOT NULL
	CONSTRAINT PK_Companies PRIMARY KEY(ID))
 
CREATE TABLE Conferences (
	ID int IDENTITY,
	Name nvarchar(50) NOT NULL,
	Price int,
	FreeSeats int NOT NULL,
	Venue nvarchar(50) NOT NULL,
	OrganizerID int NOT NULL,
	CONSTRAINT PK_Conferences PRIMARY KEY(ID),
	CONSTRAINT FK_Conferences_Companies FOREIGN KEY (OrganizerID) REFERENCES Companies(ID))

ALTER TABLE Conferences ADD TwitterAccount nvarchar(50) NOT NULL