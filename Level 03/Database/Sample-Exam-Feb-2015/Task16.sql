--Problem 16.	Ads by Country
--1.	Create a table Countries(Id, Name).
-- Use auto-increment for the primary key.
-- Add a new column CountryId in the Towns table to link each town to some country (non-mandatory link).
-- Create a foreign key between the Countries and Towns tables.
USE Ads
GO

BEGIN TRAN

-- Task 1
CREATE TABLE Countries(Id INT IDENTITY PRIMARY KEY,Name NVARCHAR(50))
GO
ALTER TABLE Towns ADD CountryId INT FOREIGN KEY REFERENCES Countries(Id)
GO

--Task 2
INSERT INTO Countries(Name) VALUES ('Bulgaria'), ('Germany'), ('France')
UPDATE Towns SET CountryId = (SELECT Id FROM Countries WHERE Name='Bulgaria')
INSERT INTO Towns VALUES
('Munich', (SELECT Id FROM Countries WHERE Name='Germany')),
('Frankfurt', (SELECT Id FROM Countries WHERE Name='Germany')),
('Berlin', (SELECT Id FROM Countries WHERE Name='Germany')),
('Hamburg', (SELECT Id FROM Countries WHERE Name='Germany')),
('Paris', (SELECT Id FROM Countries WHERE Name='France')),
('Lyon', (SELECT Id FROM Countries WHERE Name='France')),
('Nantes', (SELECT Id FROM Countries WHERE Name='France'))

--3.Write and execute a SQL command that changes the town to "Paris" 
--for all ads created at Friday.
UPDATE Ads
SET TownId = (SELECT Id FROM Towns WHERE Name = 'Paris')
WHERE DATENAME(DW, Date) = 'Friday'

--4.Write and execute a SQL command that changes the town to "Hamburg" for all ads created at Thursday
UPDATE Ads
SET TownId = (SELECT Id FROM Towns WHERE Name = 'Hamburg')
WHERE DATENAME(DW, Date) = 'Thursday'

-- Task 5.	Delete all ads created by user in role "Partner".
DELETE FROM Ads
 WHERE OwnerId IN 
	(SELECT u.Id 
	FROM AspNetUsers AS u
	JOIN AspNetUserRoles AS ur ON u.Id = ur.UserId
	JOIN AspNetRoles AS r ON ur.RoleId = r.Id
	WHERE r.Name = 'Partner')
GO
 
 -- Task 6.	Add a new add holding the following information: 
 --Title="Free Book", Text="Free C# Book", Date={current date and time}, 
 --Owner="nakov", Status="Waiting Approval
 INSERT INTO Ads ( Title,Text,Date,OwnerId,StatusId)
 VALUES ('Free Book','Free C# Book',GETDATE(),
		(SELECT Id FROM AspNetUsers WHERE UserName='nakov'),
		(SELECT Id FROM AdStatuses WHERE  Status='Waiting Approval')
		)

--7.Find the count of ads for each town.
-- Display the ads count, the town name and the country name.
-- Include also the ads without a town and country.
-- Sort the results by town, then by country. Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.
-- Town	Country	AdsCount

SELECT  t.Name as [Town], c.Name as Country,COUNT(a.Id) as [AdsCount]    
FROM Ads a
FULL OUTER JOIN Towns t on a.TownId=t.Id
LEFT JOIN Countries c on t.CountryId=c.Id
GROUP BY a.TownId,t.Name,c.Id,c.Name
ORDER BY t.Name,c.Name

ROLLBACK
GO