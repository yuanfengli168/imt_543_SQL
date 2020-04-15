/*
which students enrolled in a class from the information school during winter quarter 1998?
*/
-- SELECT *

SELECT * --> names of all columns (madatoory for ant 'SELECT' STATEMENT)
FROM tblSTUDENT --> list of tables (mandatory...unless calling a function, doing math or calling a string
	JOIN second_table_name_goes_here ON pk/fk connection goes here
	JOIN 3rd_table_name_goes_here ON pk/fk connection goes here
	JOIN 4th_table_name_goes_here ON pk/fk connection goes here
WHERE --> FILTER LOGIC (optional)
ORDER BY --> sorting of the data in the result --> what 'order' do we see the data? (optional)



--- this is the completed way ------ did not use alias to reduce redundancy -----
SELECT StudentFname, StudentLname, StudentPermCity, StudentPermState
FROM tblSTUDENT
	JOIN tblCLASS_LIST ON tblSTUDENT.StudentID = tblCLASS_LIST.StudentID
	JOIN tblCLASS ON tblCLASS_LIST.ClassID = tblCLASS.ClassID
	JOIN tblQUARTER ON tblCLASS.QuarterID = tblQUARTER.QuarterID
WHERE 
ORDER BY

--- this one is more succinct --------


/*
which students enrolled in a class from the information school during winter quarter 1998?
*/
SELECT S.StudentID, S.StudentFname, S.StudentLname, S.StudentPermCity, S.StudentPermState, C.CollegeName, Q.QuarterName, CS.[YEAR], CR.CourseName
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
ORDER BY StudentLname ASC


---- USING DISTINCT ----- this is way before the schedule, buy u know it tells u the distinct course name ---------------------
SELECT DISTINCT CourseName
FROM
(SELECT StudentFname, StudentLname, StudentPermCity, StudentPermState, C.CollegeName, Q.QuarterName, CS.[YEAR], CR.CourseName
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
	JOIN tblQUARTER Q ON CS.QuarterID = Q.QuarterID
	JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
	JOIN tblCOLLEGE C ON D.CollegeID = C.CollegeID
WHERE C.CollegeName = 'Information School'
AND Q.QuarterName = 'Winter'
AND CS.[YEAR] =  '1998') Jeff


