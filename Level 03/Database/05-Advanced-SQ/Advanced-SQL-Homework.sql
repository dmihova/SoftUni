--Problem 1.Write a SQL query to find the names and salaries of the employees that take the minimal salary 
--in the company.Use a nested SELECT statement.
SELECT e.FirstName, e.LastName, e.Salary FROM Employees e
	  WHERE Salary = (SELECT MIN(s.Salary) as Salary  FROM Employees s )

--Problem 2.Write a SQL query to find the names and salaries of the employees that have a salary that is up to 10%
-- higher than the minimal salary for the company.
SELECT e.FirstName, e.LastName, e.Salary FROM Employees e
	  WHERE Salary between	
	  (SELECT MIN(Salary) FROM Employees) 
		AND (SELECT MIN(Salary) * 1.1 FROM Employees)

--Problem 3.Write a SQL query to find the full name, salary and department of the employees 
--that take the minimal salary in their department.
SELECT (e.FirstName+' '+ e.LastName) as [Full Name], e.Salary ,d.Name
	FROM Employees e join Departments d ON e.DepartmentID=d.DepartmentID
	WHERE e.Salary =(SELECT MIN(s.Salary) FROM Employees s WHERE s.DepartmentID=e.DepartmentID)
	ORDER BY d.DepartmentID
 
--Problem 4.Write a SQL query to find the average salary in the department #1.
SELECT AVG(s.Salary) FROM Employees s WHERE s.DepartmentID=1

--Problem 5. Write a SQL query to find the average salary in the "Sales" department.
SELECT AVG(e.Salary ) as [Average Salary]
	FROM Employees e join Departments d ON e.DepartmentID=d.DepartmentID
	WHERE d.Name = 'Sales'

--Problem 6.Write a SQL query to find the number of employees in the "Sales" department.
SELECT COUNT(* ) as [Count]
	FROM Employees e join Departments d ON e.DepartmentID=d.DepartmentID
	WHERE d.Name = 'Sales'

--Problem 7.Write a SQL query to find the number of all employees that have manager.
SELECT COUNT(ManagerID ) as [Count]
	FROM Employees  

--Problem 8.	Write a SQL query to find the number of all employees that have no manager.
SELECT COUNT(EmployeeID ) as [Count]
	FROM Employees   WHERE ManagerID IS NULL

--Problem 9.	Write a SQL query to find all departments and the average salary for each of them.
SELECT  d.Name, AVG(e.Salary ) as [Average Salary]
	FROM Employees e join Departments d ON e.DepartmentID=d.DepartmentID
	GROUP BY d.Name
	ORDER BY d.Name

--Problem 10.	Write a SQL query to find the count of all employees in each department and for each town.
SELECT  t.Name as Town,d.Name as [Department],COUNT(e.EmployeeID)
	FROM Employees e join Departments d ON e.DepartmentID=d.DepartmentID
	JOIN Addresses a on e.AddressID= a.AddressID
	JOIN Towns t on a.TownID=t.TownID
	GROUP BY t.Name,d.DepartmentID, d.Name
	ORDER BY t.Name,d.Name 

--Problem 11. Write a SQL query to find all managers that have exactly 5 employees.
SELECT m.FirstName, m.LastName, COUNT(e.EmployeeID)
FROM Employees m JOIN Employees e ON e.ManagerID = m.EmployeeID
GROUP BY m.FirstName, m.LastName
HAVING COUNT(m.EmployeeID) = 5

--Problem 12.Write a SQL query to find all employees along with their managers.
SELECT (e.FirstName + ' '+e.LastName) as [Full Name],
ISNULL(m.FirstName + ' ' + m.LastName, 'No manager') as [Manager]
FROM Employees e left join Employees m ON e.ManagerID=m.EmployeeID


--Problem 13.Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. 
--Use the built-in LEN(str) function.
SELECT e.FirstName, e.LastName  FROM Employees e
	  WHERE LEN(e.LastName) = 5

--Problem 14.Write a SQL query to display the current date and time in the following format
-- "day.month.year hour:minutes:seconds:milliseconds". 
SELECT FORMAT ( GETDATE(), 'dd.MM.yyyy HH:mm:ss:fff') AS DateTime
SELECT FORMAT (GETDATE(),'dd.MM.yyyy ') + CONVERT(VARCHAR(12),GETDATE(),114) AS DateTime
SELECT CONVERT(NVARCHAR, GETDATE(), 4) + ' ' + CONVERT(NVARCHAR, GETDATE(), 114) AS DateTime
SELECT REPLACE(CONVERT(NVARCHAR, getdate(), 104), ' ', '.') + ' ' + REPLACE(CONVERT(NVARCHAR, getdate(), 14), ' ', '.') as DateTime

--Problem 15.	Write a SQL statement to create a table Users.
--Users should have username, password, full name and last login time.
-- Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
-- Define the primary key column as identity to facilitate inserting records.
-- Define unique constraint to avoid repeating usernames.
-- Define a check constraint to ensure the password is at least 5 characters long.
DROP TABLE Users;
CREATE TABLE Users(
	UserId INT IDENTITY(1,1) NOT NULL, 
	Username NVARCHAR(50) NOT NULL,
	FullName NVARCHAR(100) NULL,
	[Password] NVARCHAR (100) NOT NULL,
	LastLoginTime DATETIME NOT NULL DEFAULT GETDATE()
CONSTRAINT PK_Users PRIMARY KEY(UserId),
CONSTRAINT UQ_Users_Username UNIQUE(Username),
CONSTRAINT CHK_Users_Password_Length CHECK (LEN([Password]) >= 5)
)
GO
--Problem 16.	Write a SQL statement to create a view that displays the users from the Users table  that have been in the system today.
DROP VIEW Users_View;
GO
CREATE VIEW Users_View AS 
	SELECT 	* FROM Users WHERE LastLoginTime > DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), -1)
GO
--Problem 17.	Write a SQL statement to create a table Groups. 
--Groups should have unique name (use unique constraint). Define primary key and identity column.

CREATE TABLE Groups(
	GroupID int IDENTITY,
	Name nvarchar(20) NOT NULL,
CONSTRAINT PK_Gropus PRIMARY KEY(GroupID),
CONSTRAINT UK_Groups_Name UNIQUE(Name)
)

--Problem 18.	Write a SQL statement to add a column GroupID to the table Users.
ALTER TABLE Users ADD GroupID int
ALTER TABLE Users ADD CONSTRAINT FK_Users_Groups FOREIGN KEY(GroupID) REFERENCES Groups(GroupID)
 
--You should submit a SQL file as a part of your homework.
--Problem 19.Write SQL statements to insert several records in the Users and Groups tables.
INSERT INTO Groups (Name) 
	VALUES ('admins'),	('users'),('guests'),('test');

--Problem 20.	Write SQL statements to update some of the records in the Users and Groups tables.
INSERT INTO Users (Username, [Password], FullName, LastLoginTime, GroupID)
	VALUES ('User1', '123456', 'User name 1', GETDATE(), NULL),
	('User2', '123456', 'User name 2', CONVERT(DATETIME, '20150602', 112), 1),
	('User3', '123456', 'User name 3', CONVERT(DATETIME, '20150702', 112), 1),
	('User4', '123456', 'User name 4', CONVERT(DATETIME, '20150709', 112), NULL),
	('User5', '123456', 'User name 5', CONVERT(DATETIME, '20150109', 112), 2)

--Problem 20.	Write SQL statements to update some of the records in the Users and Groups tables 
UPDATE Users SET	Username = 'SetUsername',FullName = 'Set full user name' WHERE Username = 'User1'
SELECT * FROM Users
UPDATE Groups SET Name = 'Users' WHERE Name = 'users'
SELECT * FROM Groups

 --Problem 21.	Write SQL statements to delete some of the records from the Users and Groups tables.
 DELETE FROM Users WHERE Username = 'User5'
 DELETE FROM Groups WHERE Name = 'test'

-- Problem 22.	Write SQL statements to insert in the Users table the names of all employees from  the Employees table.
-- Combine the first and last names as a full name. 
--For username use the first letter of the first name + the last name (in lowercase).
-- Use the same for the password, and NULL for last login time.
ALTER TABLE Users NOCHECK CONSTRAINT "CHK_Users_Password_Length";
 ALTER TABLE Users ALTER COLUMN LastLoginTime DATETIME NULL;
TRUNCATE TABLE dbo.Users;

---- 1 query
INSERT INTO Users (Username, [Password], FullName,LastLoginTime, GroupID)
	SELECT
		DISTINCT LOWER(LEFT(e.FirstName, 1)) + LOWER(LEFT(e.LastName,1)),
		LOWER(LEFT(e.FirstName, 1)) + LOWER(LEFT(e.LastName,1)),
		(
		   SELECT TOP 1  s.FirstName +' '+  s.LastName 
		   FROM SoftUni.dbo.Employees s
			WHERE (LOWER(LEFT(s.FirstName, 1)) + LOWER(LEFT(s.LastName,1)))=LOWER(LEFT(e.FirstName, 1)) + LOWER(LEFT(e.LastName,1))
		),
		NULL, --GETDATE(),
		NULL
	FROM SoftUni.dbo.Employees e 
SELECT * FROM Users;

----2 steps
INSERT INTO Users (Username, [Password], LastLoginTime, GroupID)
	SELECT
		DISTINCT LOWER(LEFT(e.FirstName, 1)) + LOWER(LEFT(e.LastName,1)),
		LOWER(LEFT(e.FirstName, 1)) + LOWER(LEFT(e.LastName,1)),
		NULL, --GETDATE(),
		NULL
	FROM SoftUni.dbo.Employees e 
SELECT * FROM Users;
UPDATE Users 
 SET FullName =(
   SELECT TOP 1  e.FirstName +' '+  e.LastName 
   FROM SoftUni.dbo.Employees e
    WHERE (LOWER(LEFT(e.FirstName, 1)) + LOWER(LEFT(e.LastName,1)))=Users.Username
	)
SELECT * FROM Users;	 

ALTER TABLE Users CHECK CONSTRAINT "CHK_Users_Password_Length";
 
--Problem 23.	Write a SQL statement that changes the password to NULL for all users that have not been in the system since 10.03.2010.
ALTER TABLE Users ALTER COLUMN Password nvarchar(50)
UPDATE Users SET Password = NULL WHERE LastLoginTime <= CAST('2013-10-03' AS smalldatetime);
UPDATE Users SET Password = NULL WHERE LastLoginTime <= CONVERT(DATETIME, '20100310', 112);
UPDATE Users SET Password = NULL WHERE LastLoginTime >= DATEFROMPARTS(2010, 03, 10);
UPDATE Users SET Password = NULL WHERE LastLoginTime <= '2010-03-10'
UPDATE Users SET Password = NULL WHERE LastLoginTime IS NULL; 

-- Problem 24 : Write a SQL statement that deletes all users without passwords (NULL password)
 DELETE FROM Users WHERE Password IS NULL

 --Problem 25.	Write a SQL query to display the average employee salary by department and job title.
SELECT d.Name, e.JobTitle, AVG(Salary) AS [Average Salary]
FROM Employees e JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, e.JobTitle

--Problem 26.	Write a SQL query to display the minimal employee salary by department and job title 
--along with the name of some of the employees that take it.
SELECT d.Name,e.JobTitle,e.FirstName,e.LastName , e.Salary
FROM Employees e JOIN Departments d ON E.DepartmentID=d.DepartmentID
WHERE
e.Salary = (
	SELECT min(s.Salary) FROM Employees s 
	WHERE s.DepartmentID=e.DepartmentID AND s.JobTitle=e.JobTitle
	GROUP BY s.DepartmentID,s.JobTitle
	)
ORDER BY d.Name

---Problem 27.	Write a SQL query to display the town where maximal number of employees work.

 SELECT TOP 1 t.Name,Count(a.TownID) as Cnt 
 FROM Addresses a  JOIN Towns t ON a.TownID=t.TownID
 Group BY a.TownID,t.Name
 ORDER BY Cnt DESC 

-- Problem 28.	Write a SQL query to display the number of managers from each town.

SELECT 	t.Name AS Town, COUNT(DISTINCT e.ManagerID) AS Number  
FROM Employees e JOIN Employees m 	ON e.ManagerID = m.EmployeeID
JOIN Addresses a 	ON m.AddressID = a.AddressID
JOIN Towns T ON a.TownID = t.TownID
GROUP BY t.Name

SELECT 	Managers.TownName AS Town,	COUNT(Managers.managerId) AS Number
FROM (
  SELECT DISTINCT e.EmployeeID AS managerId,t.Name AS TownName
  FROM Employees e JOIN Employees m ON e.EmployeeID = m.ManagerID
  JOIN Addresses a 	ON a.AddressID = e.AddressID
  JOIN Towns t 	ON t.TownID = a.TownID)   AS Managers

GROUP BY Managers.TownName

--Problem 29.	Write a SQL to create table WorkHours to store work reports for each employee.
--Each employee should have id, date, task, hours and comments. Don't forget to define identity, primary key and appropriate foreign key.
CREATE TABLE WorkHours
(
        WorkHoursID int PRIMARY KEY IDENTITY NOT NULL,
		EmployeeId int FOREIGN KEY REFERENCES Employees(EmployeeId)  NOT NULL,
        WorkDate datetime NULL,
        Task nvarchar(150) NOT NULL,
        WorkHours int NOT NULL,
        Comments ntext NULL
)
GO
DROP TABLE WorkHours
GO
CREATE TABLE WorkHours (
  WorkHoursID int IDENTITY(1, 1),
  EmployeeID int NOT NULL,
  WorkDate datetime NOT NULL DEFAULT(GETDATE()),
  Task text NOT NULL,
  WorkHours int NOT NULL,
  CONSTRAINT PK_WorkHours PRIMARY KEY(WorkHoursID),
  CONSTRAINT FK_WorkHours_Employees FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID)
)
GO
--Problem 30.	Issue few SQL statements to insert, update and delete of some data in the table.
INSERT INTO WorkHours (EmployeeID, Task, WorkHours ) VALUES(10, 'Task 1', 4 );
INSERT INTO WorkHours (EmployeeID, Task, WorkHours ) VALUES(11, 'Task 2', 5 );
INSERT INTO WorkHours (EmployeeID, Task, WorkHours ) VALUES(10, 'Task 3',6 );

UPDATE WorkHours SET WorkHours = 10 WHERE EmployeeID = 10
DELETE FROM WorkHours WHERE WorkHoursID = 1

--Problem 31.	Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers.
DROP TABLE WorkHoursLogs;
GO
CREATE TABLE WorkHoursLogs(
	WorkHoursLogsID int NOT NULL PRIMARY KEY IDENTITY,
	WorkHoursID int NOT NULL, 	
	ChangeOn datetime NOT NULL,
	OldHours int,
	NewHours int,
	CommandType nvarchar(20)
)
GO

CREATE TRIGGER tr_WorkHoursUpdate ON WorkHours FOR UPDATE
AS
	INSERT INTO WorkHoursLogs(WorkHoursID,  OldHours,NewHours, CommandType,ChangeOn)
	SELECT i.WorkHoursID,  d.WorkHours, i.WorkHours, 'UPDATE',GETDATE()
	FROM DELETED d, INSERTED i
GO

CREATE TRIGGER tr_WorkHoursDelete ON WorkHours FOR DELETE
AS
	INSERT INTO WorkHoursLogs(WorkHoursID,  OldHours,NewHours, CommandType,ChangeOn)
	SELECT d.WorkHoursID, d.WorkHours,NULL, 'DELETE',GETDATE()
	FROM DELETED d
GO

CREATE TRIGGER tr_WorkHoursInsert ON WorkHours FOR INSERT
AS
	INSERT INTO WorkHoursLogs(WorkHoursID,  OldHours,NewHours, CommandType,ChangeOn)
	SELECT i.WorkHoursID, NULL,i.WorkHours ,'INSERT',GETDATE()
	FROM INSERTED i
GO

INSERT INTO WorkHours (EmployeeID, Task, WorkHours ) VALUES(10, 'Task 1', 4 );
UPDATE WorkHours SET WorkHours = 10 WHERE EmployeeID = 10
 
 SELECT  *  FROM WorkHoursLogs

-- Problem 32.Start a database transaction,
-- delete all employees from the 'Sales' department along with all dependent records from the pother tables. 
--At the end rollback the transaction.
BEGIN TRAN
ALTER TABLE Departments DROP CONSTRAINT FK_Departments_Employees
GO
DELETE  Employees WHERE DepartmentID = (SELECT DepartmentID FROM Departments  WHERE Name = 'Sales')
SELECT * FROM Employees e JOIN Departments d ON e.DepartmentID = d.DepartmentID WHERE d.Name = 'Sales'
ROLLBACK TRAN

--Problem 33.	Start a database transaction and drop the table EmployeesProjects.
--Then how you could restore back the lost table data?
BEGIN TRAN
DROP TABLE EmployeesProjects
ROLLBACK TRAN

--Problem 34.	
BEGIN TRAN
DECLARE @tempEmplProjTable TABLE ( EmployeeID INT NOT NULL, ProjectID INT NOT NULL)

INSERT INTO @tempEmplProjTable  SELECT EmployeeID, ProjectID FROM EmployeesProjects
DROP TABLE EmployeesProjects

CREATE TABLE EmployeesProjects (EmployeeID INT NOT NULL,ProjectID INT NOT NULL)
INSERT INTO EmployeesProjects SELECT * FROM @tempEmplProjTable 
GO

SELECT * FROM EmployeesProjects
ROLLBACK TRAN

--Problem 34.
SELECT * INTO ##TempTableProjects FROM EmployeesProjects