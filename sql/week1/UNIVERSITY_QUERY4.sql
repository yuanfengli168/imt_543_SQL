-- FIND me the student with the 'oldest' data of birth (may be alive!!)

-- what do you mean by oldest? -- the date of birth? or something else? 

-- do you want the oldest living person?
SELECT MAX(StudentBirth) -- 1999-03-01
FROM tblSTUDENT

-- do you want the oldest living person? --> the oldest person's birthdate
SELECT MIN(StudentBirth) -- 1874-07-05
FROM tblSTUDENT


-- who is still living?
SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE DateOfDeath > (SELECT GetDate())


-- do you want the oldest living person? -- found the oldest person with 'oldest' birthdate!! are they still alive? 
-- Nope -- > DateOfDeath needs to be > today --> (SELECT GetDate())
SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE StudentBirth = (SELECT MIN(StudentBirth) FROM tblSTUDENT)   --- Dwayne	Lamus	1874-07-05




-- plz MAX() is a date not an age!!!!
-- do you want the oldest living person?
SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE StudentBirth = (SELECT MIN(StudentBirth) FROM tblSTUDENT)   --- Dwayne	Lamus	1874-07-05
AND DateOfDeath > (SELECT GetDate()) --> returns nothing
-- this will get stuck, since we want to find out who is still alive, 


-- we abandon the MIN()
SELECT TOP 1 StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE DateOfDeath > (SELECT GetDate()) --> returns nothing
ORDER BY StudentBirth

-- who is the top 10
SELECT TOP 10 StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE DateOfDeath > (SELECT GetDate()) --> returns nothing --> the student are still alive at the time we are writing the quereys 
ORDER BY StudentBirth


-- how can we get the date of 
SELECT TOP 100 StudentFname, StudentLname, StudentBirth, DateOfDeath, DateDiff(Day, StudentBirth, GetDate()) / 365.25 AS Age
FROM tblSTUDENT
WHERE DateOfDeath > (SELECT GetDate())       --> returns nothing
ORDER BY StudentBirth


-- how can we get the date of 
SELECT TOP 100 StudentFname, StudentLname, StudentBirth, DateOfDeath, DateDiff(Year, StudentBirth, DateOfDeath) AS Age
FROM tblSTUDENT
WHERE DateOfDeath > (SELECT GetDate())       --> returns nothing
ORDER BY StudentBirth

-- run it , it diff from above
SELECT TOP 100 StudentFname, StudentLname, StudentBirth, DateOfDeath, DateDiff(Year, StudentBirth, DateOfDeath) AS Age
FROM tblSTUDENT



/*
AGGRAGATE FUNCTIONS
MIN()
MAX()
AVG()
SUM()
COUNT()

*/


----- Awhat is the average grade for the student who took an INFORmation school class winter 1998?
SELECT AVG(Grade)
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
	JOIN tblQUARTER Q ON CS.QuarterID = Q.QuarterID
	JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
	JOIN tblCOLLEGE C ON D.CollegeID = C.CollegeID
WHERE C.CollegeName = 'Information School'
AND Q.QuarterName = 'Winter'
AND CS.[YEAR] =  '1998'
-----3.375863

----- Awhat is the average grade for the student who took an enginnering class winter 1998?
SELECT AVG(CL.Grade)  -- because it is unique, we dont neccessary put it lide CL.Grade, but u can use Grade
FROM tblSTUDENT S 
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
	JOIN tblQUARTER Q ON CS.QuarterID = Q.QuarterID
	JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
	JOIN tblCOLLEGE C ON D.CollegeID = C.CollegeID
WHERE C.CollegeName = 'Engineering'
AND Q.QuarterName = 'Winter'
AND CS.[YEAR] =  '1998'
-- 3.376803


--- ----- Awhat was the average grade for each college in winter 1998? 
-- "What are the total number of credits with a grade above 3.4 for each student?"
---> without Group BY I must execute the query once for each collgeName!!

SELECT TOP 3 C.CollegeID, CollegeName, AVG(CL.Grade) AS AverageCollegeGrade1998Winter
--- Msg 8120, Level 16, State 1, Line 114
--- Column 'tblCOLLEGE.CollegeName' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
FROM tblSTUDENT S 
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
	JOIN tblQUARTER Q ON CS.QuarterID = Q.QuarterID
	JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
	JOIN tblCOLLEGE C ON D.CollegeID = C.CollegeID
WHERE Q.QuarterName = 'Winter'
AND CS.[YEAR] =  '1998'
GROUP BY C.CollegeID, CollegeName
ORDER BY AverageCollegeGrade1998Winter DESC


--- DIFFERENT FEW ELEMENTS
SELECT C.CollegeID, CollegeName, AVG(CL.Grade) AS AverageCollegeGrade1998Winter
--- Msg 8120, Level 16, State 1, Line 114
--- Column 'tblCOLLEGE.CollegeName' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
FROM tblSTUDENT S 
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
	JOIN tblQUARTER Q ON CS.QuarterID = Q.QuarterID
	JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
	JOIN tblCOLLEGE C ON D.CollegeID = C.CollegeID
WHERE Q.QuarterName = 'Spring'
AND CS.[YEAR] =  '1989'
GROUP BY C.CollegeID, CollegeName 
-- want > 3.37
HAVING AVG(CL.Grade) >= 3.38
ORDER BY AverageCollegeGrade1998Winter DESC


--------------------------------------new question!! ------
--- what r the total number of cre with a grade above 3.4 for each student born after march 9, 1963?"
SELECT TOP 50 WITH ties StudentFname, StudentLname, S.StudentBirth ,SUM(Credits) AS TotalCreds_BornAfter1963
FROM tblSTUDENT S	
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
	JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
WHERE S.StudentBirth > 'March 9, 1963'
AND CL.Grade > 3.4  --- 267970 | 276226
GROUP BY S.StudentID, StudentFname, StudentLname, S.StudentBirth
HAVING SUM(Credits) > 250
ORDER BY TotalCreds_BornAfter1963 DESC
