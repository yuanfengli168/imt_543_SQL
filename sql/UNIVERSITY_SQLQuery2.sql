SELECT 'today is Saturday' --> String call just print somehting
SELECT 7 * 9 + (9 * 30)
SELECT GetDate()


-- writing a very basic query --> which students were born in 1970
-- all data we need is in one single table (student...no JOIN required)

SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE StudentBirth >= 'January 1, 1970' AND StudentBirth <= 'December 31, 1970'

-- writing a very basic query --> which students were born in 1970
-- all data we need is in one single table (student...no JOIN required)

SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE StudentBirth >= '1/1/1970' AND StudentBirth <= '12/31/1970'



-- writing a very basic query --> which students were born in 1970
-- all data we need is in one single table (student...no JOIN required)

SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE StudentBirth BETWEEN '1/1/1970' AND '12/31/1970'




-------------------------------------order by, YEAR, MONTH functions DESC/ASC-----------------------------------------------
-- order by defaulted by asc
SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE YEAR(StudentBirth) = '1970'
ORDER BY StudentBirth, StudentLname
