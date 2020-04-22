-- This is also what I learned
-- when you open a NEW Query in anothere diagram for example in University
-- it is possible to use the following and press F5 when you select them so 
-- you could change database to Peeps.
USE PEEPS
GO

/*
This is the feedback from my submitted code for lab excersise 1, since I don't have
an idea score for this assignment, I need to redo this 

I got two wrong, because there are 10 question in total, and I got two points deducted.
I got 4.8/ 6.0

-- It is an revised version of the submitted one, you can probably find 
	both code in my github and youtube channel.
*/

--****************What I did wrong by small mistakes!!!******************************************
/* The very first question that I need to revise
-- Question No.9 
This is my submitted version */
-- 9) Write the SQL code to determine who the oldest customer is from Florida.
SELECT TOP 1 *
FROM tblCUSTOMER
WHERE CustomerState = 'California, CA'
ORDER BY DateOfBirth 

-- 'California, CA' should be 'Florida, FL'
SELECT TOP 1 *
FROM tblCUSTOMER
WHERE CustomerState = 'Florida, FL'
ORDER BY DateOfBirth

-- 'California, CA' should be 'Florida, FL'
-- this one is more considerate, which could help you find out people that are 
-- tied to be No.1
SELECT TOP 1 with ties *
FROM tblCUSTOMER
WHERE CustomerState = 'Florida, FL'
ORDER BY DateOfBirth

--****************What I did wrong by small mistakes!!!*******************************************
-- 3) Write the SQL code to determine which customers have last names that match 
-- the pattern ‘F**R’ (read ‘F in position one and R in position four’) and reside 
-- in either Florida or Texas.
SELECT *
FROM tblCUSTOMER
WHERE CustomerLname LIKE 'F__R%'
AND CustomerState IN ('California, CA', 'Texas, TA')

-- What it should be:
SELECT *
FROM tblCUSTOMER
WHERE CustomerLname LIKE 'F__r%'
AND CustomerState IN ('Florida, FL', 'Texas, TX')

-- The mistaked that I have made is 'Florida, FL', 'Texas, TX'


--################What I did not do wrong, but worth writing again and thinking ###################
-- Melissa asked Question no.6
-- 6) Write the SQL code to determine which states have at least 100,000 customers.
-- This is what I wrote 
SELECT CustomerState, COUNT(DISTINCT CustomerID) AS CustomerNumbers
FROM tblCUSTOMER
GROUP BY CustomerState
HAVING COUNT(DISTINCT CustomerID) >= 100000

-- Here is what our professor did, he check this first, and he only found 187168 rows of data, 
-- so he add more in it.
SELECT COUNT(*) FROM tblCUSTOMER

-- what he wrote after he added more rows/ he used:
-- EXEC uspPopulateBusCust_Contacts 500000 -- in another file
SELECT CustomerState, COUNT(*) AS NumberOfPeeps
FROM tblCUSTOMER
GROUP BY CustomerState
HAVING COUNT(*) > 8000
ORDER BY NumberOfPeeps DESC

-- I think my answer is ok. 15:58


