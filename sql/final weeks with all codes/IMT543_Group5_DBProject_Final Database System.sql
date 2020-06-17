-- Database Project P3. Final Database System
-- IMT 543
-- Group 5: group member: Yanjie Niu
--						  Yuanfeng Li
/*
There are three parts in this .sql file, 
1) the total code we made to build up the database system.
2) Yanjie Niu's 2 stored Procedures, description of one business rule, sql code for business rule, 
   sql code for enforcing a computed column
3) Yuanfeng Li's 2 stored Procedures, description of one business rule, sql code for business rule, 
   sql code for enforcing a computed column
*/


/*
Part 1) The total code for building databse
The following are the codes that we did to build up the database system.
-- For each table in the database, there are at least five(5) rows for each look up table
-- The Specific objects to be reflected in the code include the database, tables, data types, 
-- primary and foreign keys.
*/

-- All of the codes below about our Final Database Project are tested successfully.
-- create the database IMT543_Proj_A5
CREATE DATABASE IMT543_Proj_A5
-- use the database in the sql server
USE IMT543_Proj_A5

-- Yanjie Niu's assigned tables are:
/*
Parkride gateway -- 
Iot_gateway -- 
Pr_usage_detail
Usage_detail
Parkride --
Zipcode --
Employee 
Pr_emp_maint
Maintenance
-Owner
-Note
-Note-type
-City
-Subarea
-County
*/

-- Table IoT_gateway
-- drop table IOT_GATEWAY
CREATE TABLE IOT_GATEWAY
(GatewayID INT IDENTITY (1, 1) PRIMARY KEY,
GatewayName varchar (30),
GatewayDescript varchar (500) 
)
INSERT INTO IOT_GATEWAY
VALUES ('12345','This gateway was installed in 2020 to monitor the parking availability of the whole parking lot.'),
 ('22346','This gateway was installed in 2020 to monitor the parking availability of the whole parking lot.'),
  ('32347','This gateway was installed in 2020 to monitor the parking availability of the whole parking lot.'),
   ('42359','This gateway was installed in 2020 to monitor the parking availability of the whole parking lot.'),
    ('60981','This gateway was installed in 2020 to monitor the parking availability of the whole parking lot.'),
	('66666', 'This gateway was installed in 2020 to monitor the parking availability of the whole parking lot.')
	('88888', 'This gateway was installed in 2020 to monitor the parking availability of the whole parking lot.')
GO
select * from IOT_GATEWAY

-- Table ZipCode
CREATE TABLE ZIPCODE
(ZipCodeID INT IDENTITY (1,1) PRIMARY KEY,
ZipCode varchar (5) not null,
CityID int  foreign key references CITY (CityID) not null)
insert into ZIPCODE
VALUES ('98001', '6'),
('98390', '1'),
('98155', '2'),
('98026', '3'),
('98370', '4'),
('98052', '5')
Go
select * from ZIPCODE

-- Table Parkride
-- drop table PARKRIDE
CREATE TABLE PARKRIDE
(ParkRideID INT IDENTITY (1, 1) PRIMARY KEY,
ParkRideName varchar (60) not NULL,
ParkRideAddress varchar (60) not NULL,
ZipCodeID INT FOREIGN KEY REFERENCES ZIPCODE (ZipCodeID) not Null,
OwnerID INT FOREIGN KEY REFERENCES OWNER (OwnerID) not NULL)


INSERT INTO PARKRIDE
VALUES ('Bonney Lake South (SR 410)', '9101 184th Ave E', '1', '1'),
('Buddha Jewel Monastery', '17418 8th Ave NE', '2', '2'),
('Calvary Chapel', '8330 212th St SW', '3', '3'),
('Gateway Fellowship', '18901 8th Ave NE', '4', '4'),
('Redwood Family Church', '11500 Redmond-Woodinville Rd NE', '5', '5'),
('Auburn Garage at Auburn Station', '23 A St SW', '6', '6'),
('Redmond P&R', '16201 NE 83rd St', '5', '5')
GO 

select * from PARKRIDE

-- Table parkride gateway
-- drop table PARKRIDE_GATEWAY
CREATE table PARKRIDE_GATEWAY
(ParkRideGatewayID INT identity (1,1) primary key,
ParkRideID int foreign key references PARKRIDE (ParkRideID) not null,
GatewayID int foreign key references IOT_GATEWAY (GatewayID) not null,
OccupiedSpaces int not null,
Time smalldatetime not null)
GO
select * from PARKRIDE_GATEWAY

-- Table Usage_Detail
CREATE table USAGE_DETAIL
(DetailID INT identity (1,1) primary key,
DetailName varchar (30) not null,
DetailDescr varchar (500))
INSERT INTO USAGE_DETAIL
VALUES ('Capacity', 'The maximum number of parking spaces that the parking lot could provide.'),
('Bicycle lockers', 'Whether the parking facility has bicycle lockers provided as amenities.'),
('Bicycle racks', 'Whether the parking facility has bicycle racks provided as amenities.'),
('King County Metro Service', 'Whether the parking facility is served by routes operated by King County Metro'),
('Carpool?', 'Allow carpools or not.')
go 
select * from USAGE_DETAIL

--Table Pr_usage_detail
-- drop table PR_USAGE_DETAIL
CREATE table PR_USAGE_DETAIL
(ParkRideDetailID INT identity (1,1) primary key,
ParkRideID int foreign key references PARKRIDE (ParkRideID) not null,
DetailID int foreign key references USAGE_DETAIL (DetailID) not null,
Value varchar (10) not null)
INSERT INTO PR_USAGE_DETAIL
VALUES ('1', '1', '356'),
('2', '1', '40'),
('3', '1', '20'),
('4', '1', '156'),
('5', '1', '100'),
('6', '1', '520'),
('7', '1', '360')
go 
select * from PR_USAGE_DETAIL

--ALTER TABLE PARKRIDE_GATEWAY
-- drop column utilizationRatePercent
ALTER TABLE PARKRIDE_GATEWAY
ADD utilizationRatePercent AS (dbo.fntrackutiliazation(ParkRideID))
--select * from PR_USAGE_DETAIL
select * from PARKRIDE_GATEWAY


/*
The following codes were built by Yuanfeng Li
Yuanfeng Li's assigned tables are: 
	Employee 
	Pr_emp_maint
	Maintenance
	-Owner
	-Note
	-Note-type
	-City
	-Subarea
	-County
*/
-- we create the owner table first
CREATE TABLE OWNER
(OwnerID INT IDENTITY (1, 1) PRIMARY KEY, 
OwnerName varchar(100) not null, 
OwnerType varchar(50) not null,
OwnerEmail varchar(80) null,
-- since we only store us phone numbers so we use char(10)
OwnerPhone char(10) null)
Go
SELECT * FROM OWNER
-- INSERT VALUES INTO OWNER
INSERT INTO OWNER
VALUES ('Pierce Transit', 'Public', NULL, '2535818000'),
('Private', 'Private', NULL, NULL),
('Community Transit', 'Public', 'riders@commtrans.org','8005621375'),
('Private', 'Private', NULL, NULL),
('King County Metro Transit', 'Public', null, '2065533000')
GO

-- we create NOTETYPE TABLE
CREATE TABLE NOTETYPE
(NoteTypeID INT IDENTITY (1, 1) PRIMARY KEY,
NoteTypeName varchar(50) not null)
Go
SELECT * FROM NOTETYPE
-- INSERT VALUES INTO NOTETYPE
INSERT INTO NOTETYPE 
VALUES ('Short'), 
('Medium'),
('Long'),
('Very Long'),
('Paper'),
('Empty Note')
GO
-- after group discussion, I will update the NOTETYPE TO the following information!
UPDATE NOTETYPE 
SET NoteTypeName = 'Safety Note'
WHERE NoteTypeID = 1

UPDATE NOTETYPE
SET NoteTypeName = 'Maintenance Note'
WHERE NoteTypeID = 2

UPDATE NOTETYPE
SET NoteTypeName = 'Convinience Note'
WHERE NoteTypeID = 3

UPDATE NOTETYPE
SET NoteTypeName = 'Emergent Note'
WHERE NoteTypeID = 4

UPDATE NOTETYPE
SET NoteTypeName = 'Other Note'
WHERE NoteTypeID = 5

-- create table NOTE
CREATE TABLE NOTE
(NoteID INT IDENTITY (1, 1) PRIMARY KEY,
ParkRideID INT FOREIGN KEY REFERENCES PARKRIDE (ParkRideID) not null, 
NoteTypeID INT FOREIGN KEY REFERENCES NOTETYPE (NoteTypeID) not null,
Date date null,
NoteContent varchar(300) null)
Go
-- INSERT VALUES INTO NOTE
INSERT INTO NOTE
VALUES (1, 6, NULL, NULL),
(2, 5, '2019-05-21', 'Formerly named Bethel Lutheran Church'),
(3, 5, '2019-03-03', 'Formerly Edmonds Lutheran Church (Lynwood Parish)'),
(4, 5, '2019-06-06', 'Formerly Christ Memorial Church'),
(5, 5, '2019-07-08', 'Added in 2019'),
(6, 6, NULL, NULL)
Go

-- CREATE COUNTY TABLE
CREATE TABLE COUNTY
(CountyID INT IDENTITY (1, 1) PRIMARY KEY, 
CountyName varchar(50) not null)
Go
select * from COUNTY
-- NOW WE INSERT DATA FROM DATA WE HAVE 
INSERT INTO COUNTY 
VALUES ('Pierce County'),
('King County'),
('Snohomish County'),
('Kitsap County')
Go

----------------------- subarea TABLE
CREATE TABLE SUBAREA
(SubareaID INT IDENTITY (1, 1) PRIMARY KEY, 
SubareaName varchar(50) not null,
CountyID INT FOREIGN KEY REFERENCES COUNTY (CountyID) not null)
Go
SELECT * FROM SUBAREA
-- INSERT VALUES
INSERT INTO SUBAREA
VALUES ('Pierce County', 1),
('North King County', 2),
('Snohomish County', 3),
('Kitsap County', 4), 
('East King County', 2)
GO

-------------------------- City TABLE
CREATE TABLE CITY
(CityID INT IDENTITY (1, 1) PRIMARY KEY, 
CityName varchar(50) not null,
SubareaID INT FOREIGN KEY REFERENCES SUBAREA (SubareaID) not null)
Go
SELECT * FROM CITY
-- INSERT VALUES INTO CITY TABLE
INSERT INTO CITY
VALUES ('Bonney Lake', 1),	
('Shoreline', 2),
('Edmonds', 3),
('Poulsbo', 4),
('Redmond', 5)
Go

-- CREATE EMPLOYEE TABLE
CREATE TABLE EMPLOYEE
(EmployeeID INT IDENTITY (1, 1) PRIMARY KEY, 
EmployeeFname varchar(60) not null,
EmployeeLname varchar(60) not null,
Gender char(1) not null,
EmployeePhone char(10) not null,
EmployeeEmail varchar(80) not null)
Go
-- Insert Date into Employee table
INSERT INTO EMPLOYEE
VALUES ('James', 'Brown', 'M', '2057785543', 'jamesbrown@gmail.com'),
('Robert', 'Miller', 'M', '2087775656', 'robertmiller@gmail.com'),
('David', 'Martin', 'M', '2069998884', 'davidmartin@hotmail.com'),
('Emory', 'Kelly', 'F', '2066667878', 'emoryk@hotmail.com'),
('Jerry', 'Cooper', 'M', '2078895848', 'jerycooper@gmail.com'),
('Jacky', 'Lee', 'M', '2087790889', 'JL@hotmail.com')
GO
-- I forgot to write this function, so I added it as follows
ALTER TABLE EMPLOYEE 
ADD BirthDate date null
-- and I update the data when there is a new column 
UPDATE EMPLOYEE
SET BirthDate = '1998-03-03'
WHERE EmployeeID = 1

UPDATE EMPLOYEE
SET BirthDate = '1982-05-15'
WHERE EmployeeID = 2

UPDATE EMPLOYEE
SET BirthDate = '1983-04-18'
WHERE EmployeeID = 3

UPDATE EMPLOYEE
SET BirthDate = '1975-11-23'
WHERE EmployeeID = 4

UPDATE EMPLOYEE
SET BirthDate = '2001-10-25'
WHERE EmployeeID = 5

UPDATE EMPLOYEE
SET BirthDate = '1991-07-10'
WHERE EmployeeID = 6

-- Create table MAINTENANCETYPE
CREATE TABLE MAINTENANCETYPE 
(MaintenanceTypeID INT IDENTITY (1, 1) PRIMARY KEY, 
MaintenanceTypeName varchar(50) not null,
MaintenanceDescription varchar(500) not null)
Go
--- INSERT VALUES IN IT
INSERT INTO MAINTENANCETYPE
VALUES ('Sweeping and cleaning', 'Regular cleaning removes debris and reveals areas where repairs are needed'),
('Striping', 'Marks painted on the lot need to be repainted every so often to make sure they remain clear and visible'),
('Crack filling', 'Potholes and cracks allow water or debris to penetrate the surface layer, causing further damage if they are not filled in'),
('Asphalt overlay', 'Stripping the top layer off the pavement and replacing it with a new layer of asphalt helps extend the life of the pavement while giving a “like new” appearance'),
('Repaving', 'Once a parking lot begins to crumble, repaving and reconstructing it is typically the only course. Ideally, this is only necessary once every few decades.')
GO

--- CREAT TABLE PR_EMP_MAINT
CREATE TABLE PR_EMP_MAINT
(EmpMaintenanceID INT IDENTITY (1, 1) PRIMARY KEY,
ParkRideID INT FOREIGN KEY REFERENCES PARKRIDE (ParkRideID) not null,
MaintenanceTypeID INT FOREIGN KEY REFERENCES MAINTENANCETYPE (MaintenanceTypeID) not null,
EmployeeID INT FOREIGN KEY REFERENCES EMPLOYEE (EmployeeID) not null,
EmpMaintDateTime DateTime not null)
Go
SELECT * FROM PR_EMP_MAINT
-- WE SEE THIS NEED TO ADD MORE INFO IN IT
INSERT INTO PR_EMP_MAINT
VALUES (1, 1, 1, '2019-05-21 06:00:00'),
(2, 1, 5, '2019-05-22 16:00:00'),
(3, 1, 6, '2019-05-23 08:00:00'),
(4, 1, 2, '2019-05-24 07:00:00'),
(5, 1, 3, '2019-05-25 17:00:00'),
(6, 1, 4, '2019-05-26 15:00:00')
GO




-- 2) part two:
--             Yanjie Niu's 2 stored Procedures, description of one business rule, sql code 
--             for business rule, sql code for enforcing a computed column

/*
1) Two (2) stored procedures to populate transaction-tables that include the following:

a) at least two (2) input parameters

b) at least two (2) variables 
*/
-- Stored Procedure One to populat the transaction table of PR_USAGE_DETAIL
-- drop procedure if exists PR_USAGE_DETAIL_PROCEDURE 
CREATE PROCEDURE PR_USAGE_DETAIL_PROCEDURE 
@ParkRideName varchar(60), 
@DetailName varchar(30), 
@Value varchar(10)
AS
DECLARE @ParkRideID INT
DECLARE @DetailID INT

SET @ParkRideID = (SELECT ParkRideID from PARKRIDE WHERE ParkRideName = @ParkRideName)
SET @DetailID = (SELECT DetailID from USAGE_DETAIL WHERE DetailName = @DetailName)

BEGIN TRAN T1
INSERT INTO PR_USAGE_DETAIL (ParkRideID, DetailID, Value)
VALUES (@ParkRideID, @DetailID, @Value)
COMMIT TRAN T1

EXEC PR_USAGE_DETAIL_PROCEDURE 'Bonney Lake South (SR 410)', 'Capacity', '356'
EXEC PR_USAGE_DETAIL_PROCEDURE 'Buddha Jewel Monastery', 'Capacity', '40'
EXEC PR_USAGE_DETAIL_PROCEDURE 'Calvary Chapel', 'Capacity', '20'
EXEC PR_USAGE_DETAIL_PROCEDURE 'Gateway Fellowship', 'Capacity', '156'
EXEC PR_USAGE_DETAIL_PROCEDURE 'Redwood Family Church', 'Capacity', '10'
EXEC PR_USAGE_DETAIL_PROCEDURE 'Auburn Garage at Auburn Station', 'Capacity', '520'

SELECT * FROM PR_USAGE_DETAIL

-- Stored Procedure Two to populate the transaction table of 
-- drop procedure if exists PARKRIDE_GATEWAY_PROCEDURE 
CREATE PROCEDURE PARKING_GATEWAY_PROCEDURE 
@ParkRideName varchar(60),
@GatewayName varchar(30), 
@OccupiedSpaces int,
@Time datetime

AS 
DECLARE @ParkRideID INT
DECLARE @GatewayID INT

SET @ParkRideID = (SELECT ParkRideID from PARKRIDE WHERE ParkRideName = @ParkRideName)
SET @GatewayID = (SELECT GatewayID from IOT_GATEWAY WHERE GatewayName = @GatewayName)

BEGIN TRAN T2
INSERT INTO PARKRIDE_GATEWAY (ParkRideID, GatewayID, OccupiedSpaces, Time)
VALUES (@ParkRideID, @GatewayID, @OccupiedSpaces, @Time)
COMMIT TRAN T2

EXEC PARKING_GATEWAY_PROCEDURE 'Bonney Lake South (SR 410)', '12345', '318', '2020-05-25 08:30:00'
EXEC PARKING_GATEWAY_PROCEDURE 'Buddha Jewel Monastery', '22346', '28', '2020-05-25 08:30:00'
EXEC PARKING_GATEWAY_PROCEDURE 'Calvary Chapel', '32347', '10', '2020-05-25 08:30:00'
EXEC PARKING_GATEWAY_PROCEDURE 'Gateway Fellowship', '42359', '116', '2020-05-25 08:30:00'
EXEC PARKING_GATEWAY_PROCEDURE 'Redwood Family Church', '60981', '50', '2020-05-25 08:30:00'
EXEC PARKING_GATEWAY_PROCEDURE 'Auburn Garage at Auburn Station', '66666', '234', '2020-05-25 08:30:00'
EXEC PARKING_GATEWAY_PROCEDURE 'Redmond P&R', '88888', '188', '2020-05-25 08:30:00'

SELECT * FROM PARKRIDE_GATEWAY
--select * from PARKRIDE
--select * from IOT_GATEWAY

/*2) A single-sentence description of a business rule on the project teams' database. */
-- My Business Rule on the project databse is 'No Park and Ride facility has the number of Capacity less than that of Occupancy'. 
-- This business rule is to check in case any sensors might not work properly and provide wrong data. 



/* 3) The SQL code to create the function to enforce the business rule defined in #2. */
-- drop function park_ride_gateway_check
GO
Create FUNCTION park_ride_gateway_check()
RETURNS INT
AS 
BEGIN 
DECLARE @Ret INT = 0
IF EXISTS (SELECT * FROM PARKRIDE pr
JOIN PARKRIDE_GATEWAY pg on pr.ParkRideID = pg.ParkRideID
JOIN PR_USAGE_DETAIL pud on pr.ParkRideID = pud.ParkRideID
JOIN USAGE_DETAIL ud on pud.DetailID = ud.DetailID
                    WHERE CAST(pud.Value AS int) < pg.OccupiedSpaces
                    AND ud.DetailName = 'Capacity')
BEGIN 
SET @Ret = 1
END 
RETURN @Ret 
END
GO

ALTER TABLE PARKRIDE_GATEWAY WITH NOCHECK 
ADD CONSTRAINT CK_park_ride_gateway
CHECK (dbo.park_ride_gateway_check() = 0)
GO


select * from PARKRIDE_GATEWAY
select * from PR_USAGE_DETAIL

/* 4) The SQL code to create a function to enforce a computed column */
/*
 The computed column I hope to enforce is to track the utilization rate (%) of each park and ride through calculating OccupiedSpace/Capacity.
*/
-- DROP FUNCTION fntrackutiliazation
CREATE FUNCTION fntrackutiliazation(@PrID INT) 
RETURNS NUMERIC(6,2) 
AS
BEGIN
    DECLARE @Ret NUMERIC(6,2) =
	(SELECT ((pg.OccupiedSpaces / CAST(pud.Value AS numeric(6, 2)))*100) as utilizationRatePercent
	from PARKRIDE_GATEWAY pg 
	JOIN PARKRIDE pr on pr.ParkRideID = pg.ParkRideID
JOIN PR_USAGE_DETAIL pud on pr.ParkRideID = pud.ParkRideID
JOIN USAGE_DETAIL ud on pud.DetailID = ud.DetailID
                    WHERE pg.ParkRideID = @PrID 
					and ud.DetailName = 'Capacity'
					)
    RETURN @Ret
END
GO





/*
Part3:
3) Yuanfeng Li's 2 stored Procedures, description of one business rule, sql code for business rule, 
   sql code for enforcing a computed column

*/

/*
1) Two (2) stored procedures (again, each student) to populate transaction-tables that include the following:

a) at least two (2) input parameters

b) at least two (2) variables 
*/

-- Creating Stored Procedure
/*
2nd Stored Procedure: 
	build a stored procefure to populate transactional table PR_EMP_MAINT. Pass-in parameters of 
	'Fnames', 'Lnames' 
	and dates and parkRide name and maintenanceType
parameters:
	@StatementType - Inserts, update
	@PR - ParkRide
	@MT - MAINTAINENCE TYPE
	@FN - firstnames
	@LN - lastnames
	@Date

*/
-- LETS WRITE A SIMPLE VERSION:
GO 
ALTER PROCEDURE spInsertIntoPR_EMP_MAINT(
	@PR varchar(60),
	@MT varchar(50),
	@FN varchar(60),
	@LN varchar(60),
	@Date date)
AS 
BEGIN 
	DECLARE @PRID INT = (SELECT ParkRideID
							FROM PARKRIDE
							WHERE ParkRideName = @PR),
			@MTID INT = (SELECT MaintenanceTypeID
							FROM MAINTENANCETYPE
							WHERE MaintenanceTypeName = @MT),
			@EID INT = (SELECT EmployeeID
							FROM EMPLOYEE
							WHERE EmployeeFname = @FN
							AND EmployeeLname = @LN)
	INSERT INTO PR_EMP_MAINT
					(ParkRideID,
					MaintenanceTypeID,
					EmployeeID,
					EmpMaintDateTime
					)
	VALUES (@PRID,
			@MTID,
			@EID,
			@Date)
END
GO


SELECT * FROM PR_EMP_MAINT
-- the following are the tests to execute the stored procedure. since I build up the table first
-- so there are already data in PR_EMP_MAINT table, and the following is just one row of data 
-- to test the functionality of this stored procedure.
EXEC spInsertIntoPR_EMP_MAINT 
@PR = 'Redmond P&R', 
@MT = 'Striping', 
@FN = 'Jacky',
@LN = 'Lee', 
@Date = '2019-05-06 18:00:00'

-- 2nd Stored procedure:
-- we want to populate the date in NOTE table 
-- by passing two parameters: @PRN - ParkRideName, @NT - NoteTypeName, @Date date, @NC noteContent
-- 
GO 
ALTER PROCEDURE spInsertIntoNote(
	@PRN varchar(60),
	@NT varchar(50),
	@Date date,
	@NC varchar(300))
AS 
BEGIN
	DECLARE @PRID INT = (SELECT ParkRideID
							FROM PARKRIDE
							WHERE ParkRideName = @PRN),
			@NTID INT = (SELECT NoteTypeID
							FROM NOTETYPE
							WHERE NoteTypeName = @NT)
	INSERT INTO NOTE 
		(ParkRideID,
		 NoteTypeID,
		 Date,
		 NoteContent)
	VALUES (
		@PRID,
		@NTID,
		@Date,
		@NC)
END 
GO




SELECT * FROM NOTE
-- NOW WE USE EXEC TO INSERT SOME VALUES INTO NOTE 
EXEC spInsertIntoNote @PRN = 'Bonney Lake South (SR 410)', @NT = 'Empty Note', @Date = NULL, @NC = NULL
EXEC spInsertIntoNote @PRN = 'Buddha Jewel Monastery', @NT = 'Other Note', @Date = '2019-05-21', 
@NC = 'Formerly named Bethel Lutheran Church'
EXEC spInsertIntoNote @PRN = 'Calvary Chapel', @NT = 'Other Note', @Date = '2019-03-03', 
@NC = 'Formerly Edmonds Lutheran Church (Lynwood Parish)'
EXEC spInsertIntoNote @PRN = 'Gateway Fellowship', @NT = 'Other Note', @Date = '2019-06-06', 
@NC = 'Formerly Christ Memorial Church'
EXEC spInsertIntoNote @PRN = 'Redwood Family Church', @NT = 'Other Note', @Date = '2019-07-08', @NC = 'Added in 2019'
EXEC spInsertIntoNote @PRN = 'Auburn Garage at Auburn Station', @NT = 'Empty Note', @Date = NULL, @NC = NULL
EXEC spInsertIntoNote @PRN = 'Redmond P&R', @NT = 'Empty Note', @Date = NULL, @NC = NULL



/*
2.2) A single-sentence description of a business rule on the project teams' database.
My Answer: 
	-- there should be no employee under 18 to be an employee and do the maintenance for Park and Ride
*/



/*
2.3) The SQL code to create the function to enforce the business rule defined in #2.
*/
Go 
CREATE FUNCTION fn_noEmployeeUnder18()
RETURNS INTEGER
AS 
BEGIN
	DECLARE @Ret INTEGER = 0
	IF EXISTS(SELECT *
				FROM EMPLOYEE
				WHERE BirthDate > DATEADD(YEAR, -18, GETDATE()))
	BEGIN
		SET @Ret = 1
	END 
RETURN @Ret
END
GO
-- alter table so that it will enforce the business rule defined in #2
ALTER TABLE EMPLOYEE WITH NOCHECK
ADD CONSTRAINT ckNoEmployeeYoungerThan18
CHECK (dbo.fn_noEmployeeUnder18() = 0)
-- we had run two functions above and now we just wanted to test if it work or not
INSERT INTO EMPLOYEE
VALUES ('Jay', 'Brown', 'M', '2057785547', 'jbrown@gmail.com', '1968-02-04')
GO
-- THE FIRST ONE WORKED
SELECT * FROM EMPLOYEE
-- insert into a value so that we can test the validity of the codes
INSERT INTO EMPLOYEE
VALUES ('Jack', 'Brown', 'M', '2057785545', 'jackbrown@gmail.com', '2003-01-01')
GO
-- Msg 547, Level 16, State 0, Line 51 // THIS IS WHAT WE GET FOR THE SECOND, SO OUR BUSINESS RULE WORKED!!!
-- The INSERT statement conflicted with the CHECK constraint "ckNoEmployeeYoungerThan18". The conflict occurred in database "IMT543_Proj_A5", table "dbo.EMPLOYEE".
-- The statement has been terminated.


/*
2.4) The SQL code to create a funtion to enforce a computed column
*/
-- I WOULD LIKE TO CALCULATE TOTAL MAINTENANCE ONE EMPLOOYEE HAD DONE SO FOR ONE PARKRIDE SO FAR
-- FOR EXAMPLE, EMPLOYEEID = 1 HAS DONE ONE FOR PR 1 SO FAR
SELECT * FROM PR_EMP_MAINT
-- parameters: @ENF -- Employee FIRST Name, @PR -- Park Ride name 
GO
ALTER FUNCTION fnTotalMaintenanceForEmployeeAtParkRide(@ENF varchar(60),@ENL varchar(60), @PR varchar(60))
RETURNS INT
AS 
BEGIN
	DECLARE @Ret INT = (SELECT COUNT(*) AS TotalTimes
							FROM PR_EMP_MAINT PREM
								JOIN EMPLOYEE E ON PREM.EmployeeID = E.EmployeeID
								JOIN PARKRIDE P ON PREM.ParkRideID = p.ParkRideID
							WHERE E.EmployeeFname = @ENF 
							AND E.EmployeeLname = @ENL
							AND P.ParkRideName = @PR
							GROUP BY P.ParkRideName)
RETURN @Ret
END
GO
-- the following line is a test, and as you run it, you will see that it worked smoothly
SELECT dbo.fnTotalMaintenanceForEmployeeAtParkRide('James','Brown', 'Bonney Lake South (SR 410)') counts
-- we could enforce this a simpler computed column similar to the previous one and adding this column to EMPLOYEETABLE
-- we can a
GO
ALTER FUNCTION fnTotalMaintenanceForEmployee(@ENF varchar(60), @ENL varchar(60))
RETURNS INT
AS 
BEGIN
	DECLARE @Ret INT = (SELECT COUNT(*) AS TotalTimes
							FROM PR_EMP_MAINT PREM
								JOIN EMPLOYEE E ON PREM.EmployeeID = E.EmployeeID
								JOIN PARKRIDE P ON PREM.ParkRideID = p.ParkRideID
							WHERE E.EmployeeFname = @ENF
							AND E.EmployeeLname = @ENL)
RETURN @Ret
END
GO
SELECT * FROM EMPLOYEE
SELECT * FROM PR_EMP_MAINT
-- AS YOU CAN SEE IN THE FOLLOWING, IS HOW WE COULD ENFORCE IT IN A TABLE
ALTER TABLE EMPLOYEE
ADD totalMaintenance AS (dbo.fnTotalMaintenanceForEmployee(EmployeeFname, EmployeeLname))




-- 4)
-- The following are tests code after all:
-- FEEL FREE TO USE THEM : )
SELECT * FROM EMPLOYEE
SELECT * FROM PR_EMP_MAINT
SELECT * FROM MAINTENANCETYPE
SELECT * FROM NOTE
SELECT * FROM NOTETYPE
SELECT * FROM OWNER
SELECT * FROM PARKRIDE
SELECT * FROM IOT_GATEWAY
SELECT * FROM PARKRIDE_GATEWAY
SELECT * FROM USAGE_DETAIL
SELECT * FROM PR_USAGE_DETAIL
SELECT * FROM ZIPCODE
SELECT * FROM CITY 
SELECT * FROM SUBAREA
SELECT * FROM COUNTY