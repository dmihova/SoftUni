-- Problem 1.All Ad Titles
-- Display all ad titles in ascending order. Submit for evaluation the result grid with headers
 SELECT  Title  FROM  Ads ORDER BY Title ASC

-- Problem 2.Ads in Date Range
--Find all ads created between 26-December-2014 (00:00:00) and 1-January-2015 (23:59:59) 
--sorted by date. Submit for evaluation the result grid with headers.
 SELECT  Title,[Date]    FROM  Ads 
 WHERE [Date] BETWEEN '26-Dec-2014' AND '02-Jan-2015'
 ORDER BY [Date] ASC

 SELECT  Title,[Date]  FROM  Ads 
 WHERE [Date] >='26-Dec-2014' AND [Date] <'02-Jan-2015'
 ORDER BY [Date] ASC

  SELECT  Title,[Date]  FROM  Ads 
 ORDER BY [Date] ASC

-- Problem 3.	* Ads with "Yes/No" Images
-- Display all ad titles and dates along with a column named "Has Image" holding "yes" or "no" 
--for all ads sorted by their Id. Submit for evaluation the result grid with headers.

 SELECT  Title,[DATE],
 (
	CASE
		 WHEN ImageDataURL IS NOT NULL THEN 'yes' ELSE 'no'
	END) as [Has Image]
	  FROM  Ads 
 ORDER BY Id ASC

-- Problem 4.	Ads without Town, Category or Image
--Find all ads that have no town or no category or no image sorted by Id.
--Show all their data. Submit for evaluation the result grid with headers

 SELECT  *  FROM  Ads 
 WHERE  TownId Is Null OR CategoryId Is Null OR ImageDataURL Is Null
 ORDER BY Id ASC


-- Problem 5.	Ads with Their Town
--Find all ads along with their towns sorted by Id.
-- Display the ad title and town (even when there is no town).
-- Name the columns exactly like in the table below.
-- Submit for evaluation the result grid with headers.
 SELECT  a.Title as Title,t.name as Town  FROM  Ads a left join Towns t on a.TownId=t.Id
 ORDER BY a.Id ASC

-- Problem 6.Ads with Their Category, Town and Status
--Find all ads along with their categories, towns and statuses sorted by Id.
-- Display the ad title, category name, town name and status.
-- Include all ads without town or category or status.
-- Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.
 
 SELECT  a.Title as Title, c.Name as CategoryName, t.name as TownName,s.Status as [Status]  
 FROM  Ads a LEFT JOIN Towns t on a.TownId=t.Id
 LEFT JOIN Categories c ON a.CategoryId=c.Id
 LEFT JOIN AdStatuses s ON a.StatusId=s.Id
 ORDER BY a.Id ASC


--Problem 7.Filtered Ads with Category, Town and Status
--Find all Published ads from Sofia, Blagoevgrad or Stara Zagora,
-- along with their category, town and status sorted by title.
-- Display the ad title, category name, town name and status.
-- Name the columns exactly like in the table below. Submit for evaluation the result grid with headers

SELECT  a.Title as [Title], c.Name as [CategoryName], t.name as [TownName],s.Status as [Status]  
 FROM  Ads a JOIN Towns t on a.TownId=t.Id
 LEFT JOIN Categories c ON a.CategoryId=c.Id
 LEFT JOIN AdStatuses s ON a.StatusId=s.Id
 WHERE t.Name in ('Sofia', 'Blagoevgrad' ,'Stara Zagora') AND
		s.Status='Published'
 ORDER BY a.title ASC


--Problem 8.	Earliest and Latest Ads
--Find the dates of the earliest and the latest ads.
--Name the columns exactly like in the table below.Submit for evaluation the result grid with headers.
 SELECT  min(a.DATE) as MinDate ,max(a.DATE) as MaxDate  
 FROM  Ads a JOIN AdStatuses s ON a.StatusId=s.Id
 
-- Problem 9.	Latest 10 Ads
-- Find the latest 10 ads sorted by date in descending order. 
-- Display for each ad its title, date and status. Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.

 SELECT TOP 10 a.Title as [Title], a.Date as [Date],s.Status as [Status]  
 FROM  Ads a LEFT JOIN AdStatuses s ON a.StatusId=s.Id
 ORDER BY a.Date DESC

-- Problem 10.	Not Published Ads from the First Month
-- Find all not published ads, created in the same month and year like the earliest ad. 
-- Display for each ad its id, title, date and status. Sort the results by Id. Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.
 
 SELECT a.Id  as [Id], a.Title as [Title],a.Date as [Date],s.Status as [Status]  
 FROM  Ads a LEFT JOIN AdStatuses s ON a.StatusId=s.Id
 WHERE s.Status<>'Published' AND 
	   MONTH(a.Date) = MONTH((SELECT MIN(Date) FROM Ads)) AND 
	   YEAR(a.Date) = YEAR((SELECT MIN(Date) FROM Ads))
 ORDER BY a.Id ASC
 GO


 DECLARE @minYear INT = YEAR((SELECT MIN(Date) FROM Ads))
 DECLARE @minMonth INT = MONTH((SELECT MIN(Date) FROM Ads))
SELECT a.Id  as [Id], a.Title as [Title],a.Date as [Date],s.Status as [Status]  
 FROM  Ads a LEFT JOIN AdStatuses s ON a.StatusId=s.Id
 WHERE s.Status<>'Published' AND 
	   YEAR(a.Date) = @minYear AND MONTH(a.Date) = @minMonth
 ORDER BY a.Id ASC

-- Problem 11.	Ads by Status
-- Display the count of ads in each status. Sort the results by status. Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.

SELECT s.Status as [Status], COUNT(a.StatusId) as [Count]
FROM Ads a RIGHT JOIN  AdStatuses s ON a.StatusId=s.Id
GROUP BY a.StatusId, s.[Status]
ORDER BY [Status]
 
-- Problem 12.	Ads by Town and Status
--Display the count of ads for each town and each status.
--Sort the results by town, then by status. Display only non-zero counts. Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.

SELECT  t.Name as [Town Name],s.Status as [Status], count(a.Id) as [Count]
FROM Towns t  
JOIN Ads a  on a.TownId =t.Id
JOIN AdStatuses s ON a.StatusId=s.Id
GROUP BY t.id,t.Name, s.[Status]
ORDER BY  [Town Name], [Status]

--Problem 13.	* Ads by Users
--Find the count of ads for each user.
--Display the username, ads count and "yes" or "no" depending on whether the user belongs to the role "Administrator". 
--Sort the results by username. Display all users, including the users who have no ads. Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.

SELECT u.UserName, COUNT(a.Id) as [AdsCount],
	( CASE 
		WHEN u.UserName in ( 	SELECT su.UserName
		FROM  AspNetUsers su 
		JOIN AspNetUserRoles aspr ON su.Id=aspr.UserId
		JOIN AspNetRoles r ON aspr.RoleId=r.Id
		WHERE r.Name= 'Administrator') THEN 'yes'
		ELSE 'no'
		END
	)
	as  [IsAdministrator]
FROM AspNetUsers u 
LEFT JOIN Ads a ON u.Id= a.OwnerId
GROUP BY u.UserName
ORDER BY u.UserName
 
------------------------------------
DECLARE @admins TABLE (	id NVARCHAR(128))

INSERT INTO @admins SELECT ur.UserId 
	FROM AspNetUserRoles AS ur 
	WHERE ur.RoleId = (SELECT r.Id FROM AspNetRoles AS r WHERE r.Name = 'Administrator')

SELECT u.UserName,
	COUNT(DISTINCT a.Id) AS [AdsCount],
	CASE WHEN u.Id IN (SELECT * FROM @admins) THEN 'yes' ELSE 'no'
	END AS [IsAdministrator]
FROM AspNetUsers AS u
LEFT JOIN AspNetUserRoles AS ur
	ON u.Id = ur.UserId
LEFT JOIN AspNetRoles AS r
	On ur.RoleId = r.Id
LEFT JOIN Ads AS a
	ON u.Id = a.OwnerId
GROUP BY u.Id, u.UserName
ORDER BY u.UserName ASC

GO

---  Problem 14.	Ads by Town
--Find the count of ads for each town.
-- Display the ads count and town name or "(no town)" for the ads without a town. 
-- Display only the towns, which hold 2 or 3 ads. Sort the results by town name. Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.
 
SELECT  COUNT(a.Id) as [AdsCount] , ISNULL(t.Name,'(no town)') as [Town]
FROM Ads a
LEFT JOIN Towns t on a.TownId=t.Id
GROUP BY a.TownId,t.Name
HAVING COUNT(a.Id) BETWEEN  2 AND 3
ORDER BY t.Name

--Problem 15.	Pairs of Dates within 12 Hours
--Consider the dates of the ads. 
--Find among them all pairs of different dates, such that the second date is no later 
--than 12 hours after the first date. 
--Sort the dates in increasing order by the first date, then by the second date. Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.

SELECT a1.Date as [FirstDate],a2.Date as [SecondDate]
FROM Ads a1, Ads a2
WHERE a1.Date<a2.Date AND a2.Date<= DATEADD(HOUR,12,a1.Date)
ORDER BY a1.Date,a2.Date
---DATEDIFF(HH, a1.Date, a2.Date) < 12

 
