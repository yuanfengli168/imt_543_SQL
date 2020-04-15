/*

Teacher: Greg Hay
TA	   : Vishwa Pardeshi
student: Yuanfeng Li

This is the first Lab practice due on the third week of sp2020 quarter,
I learned and practiced a lot of basic Queries
---------------------------------------------------------------
FROM		specifies the table or tables to be used
WHERE		files the rows subject to some condition
GROUP BY	forms groups of rows with the same column value
HAVING		filters the groups subject to some condition
SELECT		specifies wich columns are to appear in the output
ORDER BY	specifies the order of the output
---------------------------------------------------------------
SET MEMBERSHIP SEARCH CONDITION:
--------------------------------
Pattern match search condition:
LIKE/NOT LIKE  
%
_
---------------------------------------------------------------
SET	membership search condition:
IN/NOT IN

DATEDIFF(YEAR, DATEOFBIRTH, GetDate())
DATEDIFF(DAY, DATEOFBIRTH, GetDate())

*/

-- following are the basic quesions and my methods.
-- Write the SQL Statement to satisfy the following questions from the database PEEPS and the table tblCUSTOMER


-- 1) Write the SQL code to determine which customers are from the zip code 80471
SELECT * 
FROM tblCUSTOMER
WHERE CustomerZIP = '80471'

-- 2) Write the SQL code to determine which customers have 'Blvd' in their address.
SELECT *
FROM tblCUSTOMER
WHERE CustomerAddress = ''


-- 3) Write the SQL code to determine which customers have last names that match 
-- the pattern ‘F**R’ (read ‘F in position one and R in position four’) and reside 
-- in either Florida or Texas.
SELECT *
FROM tblCUSTOMER
WHERE CustomerLname LIKE 'F__R%'
AND CustomerState IN ('California, CA', 'Texas, TA')

-- 4) Write the SQL code to determine which customers have a first name beginning 
-- with ‘Ra’ and live in California.
SELECT * 
FROM tblCUSTOMER
WHERE CustomerFname LIKE 'Ra%'
AND CustomerState = 'California, CA'


-- 5) Write the SQL code to determine which customers have ‘Leaf’ in their address 
-- and have the two letters ‘ba’ together in any part of the county they live in.
SELECT *
FROM tblCUSTOMER 
WHERE CustomerAddress LIKE '%Leaf%' 
AND CustomerCounty LIKE '%ba%'


-- 6) Write the SQL code to determine which states have at least 100,000 customers.
SELECT CustomerState, COUNT(DISTINCT CustomerID) AS CustomerNumbers
FROM tblCUSTOMER
GROUP BY CustomerState
HAVING COUNT(DISTINCT CustomerID) >= 100000
-- THE BIGGEST NUMBER IS 11693, SO there is no states that has more than 100,000 customers.

-- 7) Write the SQL code to determine which customers are at least 65 years - old and 
-- do NOT live in Wyoming, Iowa, Colorado or Nebraska.
SELECT *
FROM tblCUSTOMER
WHERE GetDate() - DateOfBirth >= 65 * 365.25
AND CustomerState NOT IN ('Wyoming, WY', 'Iowa, IA', 'Colorado, CO', 'Nebraska, NE' )
ORDER BY DateOfBirth DESC

-- 7) method 2
SELECT *
FROM tblCUSTOMER
WHERE DATEDIFF(DAY, DateOfBirth, GetDate()) / 365.25 >= 65
AND CustomerState NOT IN ('Wyoming, WY', 'Iowa, IA', 'Colorado, CO', 'Nebraska, NE')
ORDER BY DateOfBirth DESC


-- 8) Write the SQL code to determine which customers are younger than 50, have a phone 
-- number in area code '206', '360' or '425' and also have a last name beginning with 'J'.
SELECT * 
FROM tblCUSTOMER
WHERE GetDate() - DateOfBirth < 50 * 365.25
AND AreaCode IN ('206', '360', '425') AND CustomerLname LIKE 'J%'


-- 9) Write the SQL code to determine who the oldest customer is from Florida.
SELECT TOP 1 *
FROM tblCUSTOMER
WHERE CustomerState = 'California, CA'
ORDER BY DateOfBirth 


-- 10) Write the SQL code to determine the average age of all customers from Oregon. 
-- (this one is a bit tricky!) 
SELECT SUM(DATEDIFF(year, DateOfBirth, GetDate())) / COUNT(*) AS AverageAge
FROM tblCUSTOMER
WHERE CustomerState = 'Oregon, OR'

-- 10) method 2, if you would like me to have more precise data, then we could use 
-- the following query.
SELECT AVG(DATEDIFF(DAY, DateOfBirth, GetDate()) / 365.25)  As AverageAge
FROM tblCUSTOMER
WHERE CustomerState = 'Oregon, OR'