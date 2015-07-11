use TransactSQLHW
GO
--Problem 1.	Create a database with two tables
--Persons (id (PK), first name, last name, SSN) and Accounts (id (PK), person id (FK), balance). Insert few records for testing. 
--Write a stored procedure that selects the full names of all persons.
 
CREATE TABLE Persons(
	Id int NOT NULL IDENTITY,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	SSN nvarchar(10) NOT NULL,
	CONSTRAINT PK_Persons PRIMARY KEY(Id)
	)
GO

CREATE TABLE Accounts(
	Id int NOT NULL IDENTITY,
	PersonId int NOT NULL,
	Balance money NOT NULL,
	CONSTRAINT PK_Accounts PRIMARY KEY(Id),
	CONSTRAINT FK_Accounts_Persons FOREIGN KEY(PersonId)REFERENCES Persons(Id)
	)
GO

INSERT INTO Persons(FirstName, LastName, SSN)
VALUES('Pepi', 'Peshev', '35535252'),
	  ('Didi', 'Dobreva', '235325325'),
	  ('Dani', 'Dimova','5255252')
INSERT INTO Accounts(PersonId, balance)
VALUES(1, 100.0), (2, 300.0),(3,400.00)
GO

--Stored procedure
CREATE PROC usp_GetPersonsFullName
AS
  SELECT FirstName + ' ' + LastName as FullName FROM Persons
GO


EXEC usp_GetPersonsFullName 
GO


--Problem 2.Create a stored procedure that accepts a number as a parameter and returns all persons 
--who have more money in their accounts than the supplied number.
use TransactSQLHW
GO
CREATE PROCEDURE usp_PersonWithAccountBalanceAboveInput(@amount money = 0.0)
AS
SELECT p.FirstName,p.LastName,p.SSN,a.Balance
FROM Persons p JOIN Accounts a ON p.Id = a.PersonId
WHERE a.Balance >= @amount
GO

EXEC usp_PersonWithAccountBalanceAboveInput 100
GO


--Problem 3.	Create a function with parameters
--Your task is to create a function that accepts as parameters – sum, yearly interest rate and number of months.
--It should calculate and return the new sum. Write a SELECT to test whether the function works as expected.
use TransactSQLHW
GO
CREATE FUNCTION ufn_CalculateSimpleInterest (@sum money, @yearlyInterestRate float, @monthsNumber int) RETURNS money
AS
BEGIN
	RETURN @sum + (@sum * ( (@yearlyInterestRate / 100)  * @monthsNumber))
END
GO

SELECT dbo.ufn_CalculateSimpleInterest (10000, 2.00, 12)
DECLARE @funtionOutput money
SELECT 	@funtionOutput =  dbo.ufn_CalculateSimpleInterest(1000.00,2.00,12)
PRINT @funtionOutput
GO

SELECT p.FirstName  + ' ' + p.LastName AS  FullName,  dbo.ufn_CalculateSimpleInterest(a.Balance, 2.2, 12) AS TotalSum
FROM Persons p JOIN Accounts a ON a.PersonId = p.Id
ORDER BY TotalSum DESC;
GO

--Problem 4.	Create a stored procedure that uses the function from the previous example.
--to give an interest to a person's account for one month. It should take the AccountId and the interest rate as parameters.
use TransactSQLHW
GO

CREATE PROC usp_AllocateMonthlyInterestToPersonAccount (@accountId int, @interestRate float)
AS
	UPDATE Accounts
	SET Balance = dbo.ufn_CalculateSimpleInterest(Balance, @interestRate, 1)
	WHERE Id = @accountId
GO

SELECT * FROM Accounts
EXEC dbo.usp_AllocateMonthlyInterestToPersonAccount  1, 2.50 
SELECT * FROM Accounts

--Problem 5.Add two more stored procedures WithdrawMoney (AccountId, money) and DepositMoney (AccountId, money) 
--that operate in transactions.
USE TransactSQLHW
GO
--DROP PROC usp_WithdrawMoney

CREATE PROC usp_WithdrawMoney (@accountId int, @money money)
AS 
	DECLARE @oldSum money = (SELECT Balance FROM Accounts WHERE Id = @accountId )
	 IF (@money < 0) 
	 BEGIN
			 RAISERROR ('Negative amount not allowed.',  1, 1)
			 RETURN
	END
     IF  (@money > @oldSum) 
	 BEGIN
			  RAISERROR ('Balanace not sufficient.',  1, 1)
			  	 RETURN
	 END
	 UPDATE Accounts SET Balance = (Balance - @money) WHERE Id = @accountId
GO
 

CREATE PROC usp_DepositMoney (@accountId int, @money money)
AS
	UPDATE Accounts SET Balance = (Balance + @money) WHERE Id = @accountId
GO

SELECT * FROM Accounts
EXEC usp_DepositMoney 1, 150
EXEC usp_WithdrawMoney 2,  2.50
SELECT * FROM Accounts

--Problem 6.	Create table Logs.
--Create another table – Logs (LogID, AccountID, OldSum, NewSum). 
--Add a trigger to the Accounts table that enters a new entry into the Logs table every time the sum on an account changes.
USE TransactSQLHW
GO

CREATE TABLE Logs(
	Id int NOT NULL IDENTITY,
	AccountID int NOT NULL,
	OldSum money NOT NULL,
	NewSum money NOT NULL,
	CONSTRAINT PK_Logs PRIMARY KEY(Id),
	CONSTRAINT FK_Logs_Accounts FOREIGN KEY(AccountID) REFERENCES Accounts(Id)
)
GO

CREATE TRIGGER tr_AccountBalanceUpdate ON Accounts FOR UPDATE
AS
	INSERT INTO Logs(AccountID, OldSum, NewSum)
	SELECT i.Id, d.balance, i.balance  FROM DELETED d, INSERTED i
GO


--Problem 7.	Define function in the SoftUni database that returns all Employee's names
-- (first or middle or last name) and all town's names that are comprised of given set of letters. 
--Example: 'oistmiahf' will return 'Sofia', 'Smith', but not 'Rob' and 'Guy'.
USE SoftUni
GO

IF OBJECT_ID('ufn_HasCharSet') IS NOT NULL DROP FUNCTION ufn_HasCharSet
GO

CREATE FUNCTION dbo.ufn_HasCharSet( @String NVARCHAR(MAX),	@Match NVARCHAR(255))
RETURNS INT
AS
BEGIN
	DECLARE @Index INT = 1
	DECLARE @CurrentChar NVARCHAR(1)
	DECLARE @CheckStringLength INT = LEN(@String)
	WHILE @Index <= @CheckStringLength
		BEGIN
		SET	@CurrentChar = SUBSTRING(@String, @Index, 1)
			IF(CHARINDEX(@CurrentChar, @Match) <= 0) RETURN 0
			SET @Index += 1
		END
    RETURN 1
END
GO

IF OBJECT_ID('ufn_GetNamesAndTowns') IS NOT NULL DROP FUNCTION ufn_GetNamesAndTowns
GO

CREATE FUNCTION dbo.ufn_GetNamesAndTowns(@Charset NVARCHAR(MAX))
RETURNS @NamesAndTownsFromCharset TABLE  ([Names or Towns] NVARCHAR(100))
AS
BEGIN
	DECLARE @NameOrTown NVARCHAR(100)
	DECLARE cursor_AllCharNames CURSOR FOR
		SELECT FirstName AS [Names or Towns] FROM Employees UNION
		SELECT MiddleName AS [Names or Towns] FROM Employees UNION
		SELECT LastName AS [Names or Towns] FROM Employees UNION
		SELECT Name AS [Names or Towns] FROM Towns

	OPEN cursor_AllCharNames
	FETCH NEXT FROM cursor_AllCharNames INTO @NameOrTown

	WHILE @@fetch_status = 0 BEGIN
		IF(dbo.ufn_HasCharSet(@NameOrTown, @Charset) = 1)
			BEGIN
				INSERT INTO @NamesAndTownsFromCharset([Names or Towns]) VALUES(@NameOrTown)
			END
		FETCH NEXT FROM cursor_AllCharNames INTO @NameOrTown
	END

	CLOSE cursor_AllCharNames
	DEALLOCATE cursor_AllCharNames

    RETURN 
END
GO

 
SELECT * FROM dbo.ufn_GetNamesAndTowns('oistmiahf')

--Problem 8.	Using database cursor write a T-SQL script that scans all employees and their addresses and 
--prints all pairs of employees that live in the same town
/* Example:
Wood: John Wood Redmond John
Hill: John Wood Redmond Annette
Feng: John Wood Redmond Hanying
Sousa: John Wood Redmond Anibal
Glimp: John Wood Redmond Diane
Pournasseh: John Wood Redmond Houman
Kane: John Wood Redmond Lori … */

USE SoftUni;
GO

DECLARE @mainName nvarchar(100),
 		@townName nvarchar(50),
		@subName nvarchar(100)

DECLARE mainEmployeeAddressesCursor CURSOR READ_ONLY FOR
	SELECT (e.FirstName +' '+ e.LastName) as FullName, t.Name
	FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
	JOIN Towns t ON a.TownID = t.TownID

OPEN mainEmployeeAddressesCursor
FETCH NEXT FROM mainEmployeeAddressesCursor INTO @mainName, @townName

WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE subEmployeeAddressesCursor CURSOR READ_ONLY FOR
		SELECT (e.FirstName +' '+ e.LastName) as FullName
		FROM Employees e 
		JOIN Addresses a ON e.AddressID = a.AddressID
		JOIN Towns t ON a.TownID = t.TownID
		WHERE t.Name = @townName

		OPEN subEmployeeAddressesCursor
		FETCH NEXT FROM subEmployeeAddressesCursor INTO @subName

		WHILE @@FETCH_STATUS = 0
			BEGIN
				PRINT   @townName + ': ' + @mainName+' ' + @subName
				FETCH NEXT FROM subEmployeeAddressesCursor INTO @subName
			END

		CLOSE subEmployeeAddressesCursor
		DEALLOCATE subEmployeeAddressesCursor

		FETCH NEXT FROM mainEmployeeAddressesCursor INTO @mainName, @townName
	END

CLOSE mainEmployeeAddressesCursor
DEALLOCATE mainEmployeeAddressesCursor


--Problem 9.	Define a .NET aggregate function StrConcat that takes as input a sequence of strings 
--and return a single string that consists of the input strings separated by ','. 
--For example the following SQL statement should return a single string:
--SELECT StrConcat (FirstName + ' ' + LastName) FROM Employees
----- 
--NOT DONE
-----

--Problem 10 .Write a T-SQL script that shows for each town a list of all employees that live in it.
-- Sample output: 
--Sofia -> Svetlin Nakov, Martin Kulov, Vladimir Georgiev
--Ottawa -> Jose Saraiva, 

USE SoftUni
GO

DECLARE  TownsCursor CURSOR READ_ONLY FOR  SELECT DISTINCT  Name as TownName,TownID FROM  Towns t
OPEN TownsCursor 
DECLARE  @townName nvarchar(50),@townId as int;
DECLARE  @fullName nvarchar(100),@allEmplInSameTown nvarchar(max);

FETCH NEXT FROM TownsCursor INTO @TownName ,@townId
WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @allEmplInSameTown =@TownName+ '->'
		DECLARE employeeCursor CURSOR READ_ONLY FOR
		SELECT (e.FirstName +' '+ e.LastName) as FullName
			FROM Employees e  JOIN Addresses a ON e.AddressID = a.AddressID
			WHERE a.TownID = @townId
		OPEN employeeCursor
		FETCH NEXT FROM employeeCursor INTO @fullName
		WHILE @@FETCH_STATUS = 0
			BEGIN
			SET @allEmplInSameTown += @fullName + ', '
			FETCH NEXT FROM employeeCursor INTO @fullName
			END
		CLOSE employeeCursor 
		DEALLOCATE employeeCursor 
		 PRINT @allEmplInSameTown
	FETCH NEXT FROM TownsCursor INTO @TownName ,@townId 
	END

CLOSE TownsCursor 
DEALLOCATE TownsCursor 
GO
