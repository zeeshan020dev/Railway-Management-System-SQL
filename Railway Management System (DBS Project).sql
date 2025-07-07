CREATE DATABASE RAILWAY
USE RAILWAY
------------------RAILWAY MANAGEMENT SYSTEM-----------------
CREATE TABLE Passenger (
    PassengerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Address VARCHAR(50),
    AccountNo VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);
-------backup-------
CREATE TABLE BI_Passenger (
    PassengerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Address VARCHAR(50),
    AccountNo VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);
CREATE TABLE BU_Passenger (
    PassengerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Address VARCHAR(50),
    AccountNo VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);
------------------------------------------
--CREATE TRIGGER T_P_I
--ON Passenger
--AFTER INSERT
--AS
--BEGIN
	
--	INSERT INTO BI_Passenger (PassengerID, Name, Age, Address, AccountNo, Phone, Email)
--	SELECT PassengerID, Name, Age, Address, AccountNo, Phone, Email
--	FROM INSERTED
--END;
-----trigger--------

CREATE TRIGGER T_P_I
ON Passenger
AFTER INSERT
AS
BEGIN
	
	INSERT INTO BI_Passenger (PassengerID, Name, Age, Address, AccountNo, Phone, Email)
	SELECT TOP 1 PassengerID, Name, Age, Address, AccountNo, Phone, Email
	FROM INSERTED
	ORDER BY PassengerID DESC; -- or ASC based on what "last" means to you
END;

--------------------
CREATE TRIGGER T_P_U
ON Passenger
AFTER UPDATE
AS
BEGIN
	INSERT INTO BU_Passenger (PassengerID, Name, Age, Address, AccountNo, Phone, Email)
	SELECT I.PassengerID, I.Name, I.Age, I.Address, I.AccountNo, I.Phone, I.Email
	FROM INSERTED I
	JOIN BI_Passenger BI ON I.PassengerID=BI.PassengerID
	WHERE I.PassengerID=BI.PassengerID AND BI.Name <> I.Name OR BI.Age <> I.Age OR I.Address <> BI.Address OR BI.AccountNo <> I.AccountNo OR BI.Phone <> I.Phone OR BI.Email <> I.Email 
END;
-------------------------TABLE 2----------------------------------------
--FIXED TABLE
CREATE TABLE TicketPricing (
	ClassName VARCHAR(50) PRIMARY KEY,
    PricePerTicket DECIMAL(10, 2)
);
select * from TicketPricing
-- Values insertion
INSERT INTO TicketPricing VALUES
('Economy',1),
('First Class',2),
('Business',3),
('VIP',4);
-----------------------TABLE 3---------------------------------
--FIXED TABLE
CREATE TABLE Train (
    TrainID INT PRIMARY KEY,
    Capacity INT,
    TrainName VARCHAR(100)
);
----Value insertion-----
INSERT INTO Train (TrainID, Capacity, TrainName)
VALUES(1, 500, 'Green Line Express'),
(2, 450, 'Tezgam Express'),
(3, 400, 'Khyber Mail'),
(4, 550, 'Awam Express'),
(5, 300, 'Jinnah Express'),
(6, 600, 'Karakoram Express'),
(7, 500, 'Millat Express'),
(8, 450, 'Rehman Baba Express'),
(9, 350, 'Pakistan Express'),
(10, 400, 'Shalimar Express'),
(11, 520, 'Bahauddin Zakaria Express'),
(12, 410, 'Allama Iqbal Express'),
(13, 470, 'Hazara Express'),
(14, 380, 'Quetta Express'),
(15, 390, 'Sukkur Express'),
(16,500, 'Green Line Express'),
(17, 450, 'Tezgam Express'),
(18, 400, 'Khyber Mail'),
(19, 550, 'Awam Express'),
(20, 300, 'Jinnah Express'),
(21, 600, 'Karakoram Express'),
(22, 500, 'Millat Express'),
(23, 450, 'Rehman Baba Express'),
(24, 350, 'Pakistan Express'),
(25, 400, 'Shalimar Express'),
(26, 520, 'Bahauddin Zakaria Express'),
(27, 410, 'Allama Iqbal Express'),
(28, 470, 'Hazara Express'),
(29, 380, 'Quetta Express'),
(30, 390, 'Sukkur Express');
-----------------------TABLE 4----------------------------------
--FIXED TABLE
--DROP TABLE T_Route
CREATE TABLE T_Route (
    RouteID INT PRIMARY KEY,
	ScheduleID INT,
	TrainID INT,
    DepartureStation VARCHAR(50),
    ArrivalStation VARCHAR(50),
	Price int,
	FOREIGN KEY (TrainID) REFERENCES Train(TrainID),
    FOREIGN KEY (ScheduleID) REFERENCES TripSchedule(ScheduleID)
);
------Values Insertion-----
INSERT INTO T_Route (RouteID,ScheduleID,TrainID, DepartureStation, ArrivalStation, Price) VALUES
(1,1,1, 'Karachi', 'Islamabad', 2200),
(2,2,2, 'Karachi', 'Quetta', 2000),
(3,3,3, 'Karachi', 'Multan', 1800),
(4,4,4, 'Karachi', 'Lahore', 2500),
(5,5,5, 'Karachi', 'Faisalabad', 2300),
(6,6,6, 'Islamabad', 'Karachi', 2200),
(7,7,7, 'Islamabad', 'Quetta', 2100),
(8,8,8, 'Islamabad', 'Multan', 1900),
(9,9,9, 'Islamabad', 'Lahore', 1500),
(10,10,10, 'Islamabad', 'Faisalabad', 1600),
(11,11,11, 'Quetta', 'Karachi', 2000),
(12,12, 12,'Quetta', 'Islamabad', 2100),
(13,13, 13,'Quetta', 'Multan', 1700),
(14,14, 14,'Quetta', 'Lahore', 2000),
(15,15, 15,'Quetta', 'Faisalabad', 1900),
(16,16, 16,'Multan', 'Karachi', 1800),
(17,17, 17,'Multan', 'Islamabad', 1900),
(18,18, 18,'Multan', 'Quetta', 1700),
(19,19, 19,'Multan', 'Lahore', 1200),
(20,20, 20,'Multan', 'Faisalabad', 1300),
(21,21, 21,'Lahore', 'Karachi', 2500),
(22,22, 22,'Lahore', 'Islamabad', 1500),
(23,23, 23,'Lahore', 'Quetta', 2000),
(24,24, 24,'Lahore', 'Multan', 1200),
(25,25, 25,'Lahore', 'Faisalabad', 1000),
(26,26, 26,'Faisalabad', 'Karachi', 2300),
(27,27, 27,'Faisalabad', 'Islamabad', 1600),
(28,28, 28,'Faisalabad', 'Quetta', 1900),
(29,29, 29,'Faisalabad', 'Multan', 1300),
(30,30, 30,'Faisalabad', 'Lahore', 1000);

--TRUNCATE TABLE T_ROUTE
-------backup-------
--DROP TABLE BI_Route
CREATE TABLE BI_Route (
    RouteID INT PRIMARY KEY,
    ScheduleID INT,
	TrainID INT,
	DepartureStation VARCHAR(50),
    ArrivalStation VARCHAR(50),
	Price int
);
--DROP TABLE BU_Route
CREATE TABLE BU_Route (
    RouteID INT PRIMARY KEY,
    ScheduleID INT,
	TrainID INT,
	DepartureStation VARCHAR(50),
    ArrivalStation VARCHAR(50),
	Price int
);
-----trigger--------
CREATE TRIGGER T_R_I
ON T_Route
AFTER INSERT
AS
BEGIN
	INSERT INTO BI_Route(RouteID,ScheduleID,TrainID,DepartureStation,ArrivalStation,Price)
	SELECT RouteID,ScheduleID,TrainID,DepartureStation,ArrivalStation,Price
	FROM INSERTED
END;
--------------------
CREATE TRIGGER T_R_U
ON T_Route
AFTER UPDATE
AS
BEGIN
	INSERT INTO BU_Route(RouteID,ScheduleID,TrainID,DepartureStation,ArrivalStation,Price)
	SELECT I.RouteID,I.ScheduleID,I.TrainID,I.DepartureStation,I.ArrivalStation,I.Price
	FROM INSERTED I
	JOIN BI_Route BI ON I.RouteID=BI.RouteID
	WHERE I.RouteID=BI.RouteID AND BI.ScheduleID <> I.ScheduleID OR BI.TrainID <> I.TrainID OR BI.DepartureStation <> I.DepartureStation OR I.ArrivalStation <> BI.ArrivalStation OR I.Price <> BI.Price
END;
------------------------TABLE 5-------------------------------------
--drop TABLE TripSchedule
CREATE TABLE TripSchedule (
    ScheduleID INT PRIMARY KEY,
    DepartureTime TIME,
    ArrivalTime TIME
);

INSERT INTO TripSchedule (ScheduleID, DepartureTime, ArrivalTime) VALUES
(1, '08:00:00', '20:00:00'),
(2, '09:00:00', '19:00:00'),
(3, '10:00:00', '18:00:00'),
(4, '07:30:00', '19:30:00'),
(5, '11:00:00', '21:00:00'),
(6, '08:00:00', '20:00:00'),
(7, '09:00:00', '19:00:00'),
(8, '10:00:00', '18:00:00'),
(9, '11:00:00', '14:00:00'),
(10, '12:00:00', '16:00:00'),
(11, '06:00:00', '16:00:00'),
(12, '07:00:00', '17:00:00'),
(13, '08:00:00', '16:00:00'),
(14, '09:00:00', '19:00:00'),
(15, '10:00:00', '18:00:00'),
(16, '06:00:00', '16:00:00'),
(17, '07:00:00', '17:00:00'),
(18, '08:00:00', '16:00:00'),
(19, '09:00:00', '13:00:00'),
(20, '10:00:00', '14:00:00'),
(21, '08:00:00', '20:00:00'),
(22, '09:00:00', '13:00:00'),
(23, '10:00:00', '20:00:00'),
(24, '11:00:00', '15:00:00'),
(25, '12:00:00', '14:00:00'),
(26, '08:00:00', '20:00:00'),
(27, '09:00:00', '13:00:00'),
(28, '10:00:00', '20:00:00'),
(29, '11:00:00', '13:00:00'),
(30, '12:00:00', '14:00:00');

-------backup-------
CREATE TABLE BI_TripSchedule (
    ScheduleID INT PRIMARY KEY,
    DepartureTime DATETIME,
    ArrivalTime DATETIME
);
CREATE TABLE BU_TripSchedule (
    ScheduleID INT PRIMARY KEY,
    DepartureTime DATETIME,
    ArrivalTime DATETIME
);
-----trigger--------
CREATE TRIGGER T_TS_I
ON TripSchedule
AFTER INSERT
AS
BEGIN
	INSERT INTO BI_TripSchedule(ScheduleID,DepartureTime,ArrivalTime)
	SELECT ScheduleID,DepartureTime,ArrivalTime
	FROM INSERTED
END;
--------------------
CREATE TRIGGER T_TS_U
ON TripSchedule
AFTER UPDATE
AS
BEGIN
	INSERT INTO BU_TripSchedule(ScheduleID,DepartureTime,ArrivalTime)
	SELECT I.ScheduleID,I.DepartureTime,I.ArrivalTime
	FROM INSERTED I
	JOIN BI_TripSchedule BI ON I.ScheduleID=BI.ScheduleID
	WHERE I.ScheduleID=BI.ScheduleID AND I.DepartureTime <> BI.DepartureTime OR I.ArrivalTime <> BI.ArrivalTime
END;
-----------------------------TABLE 6------------------------------------------
--fixed
-- Station Table
CREATE TABLE Station (
    StationID INT PRIMARY KEY,
    StationName VARCHAR(50),
    City VARCHAR(50)
);
------Values Insertion------
INSERT INTO Station (StationID, StationName, City) VALUES
(1, 'Karachi Cantt', 'Karachi'),
(2, 'Islamabad Margalla', 'Islamabad'),
(3, 'Quetta Railway Station', 'Quetta'),
(4, 'Multan Cantt', 'Multan'),
(5, 'Lahore Junction', 'Lahore'),
(6, 'Faisalabad Railway Station', 'Faisalabad');

-----------------------------TABLE 7------------------------------------
-- Staff Table with full details
--drop table Staff
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
	S_ID INT,
    Name VARCHAR(50),
    Phone VARCHAR(15),
	Address VARCHAR(50),
	Location_of_Working VARCHAR(50),
	FOREIGN KEY (S_ID) REFERENCES SalaryInfo(S_ID)
);
----------------------------TABLE 8---------------------------------
CREATE TABLE SalaryInfo
(
	S_ID INT PRIMARY KEY,
	S_Rank VARCHAR(25),
    Salary DECIMAL(10, 2)
);
INSERT INTO SalaryInfo (S_ID, S_Rank, Salary)
VALUES 
(1, 'Manager', 120000.00),
(2, 'Assistant Manager', 95000.00),
(3, 'Senior Developer', 85000.00),
(4, 'Junior Developer', 55000.00),
(5, 'Intern', 25000.00),
(6, 'Data Analyst', 70000.00),
(7, 'Marketing Lead', 80000.00),
(8, 'HR Executive', 60000.00),
(9, 'Operations Head', 110000.00),
(10, 'Support Staff', 30000.00);

----Values Insertion Staff Table----
INSERT INTO Staff (StaffID, S_ID, Name, Phone, Address, Location_of_Working) VALUES
(1, 1, 'Ali Raza', '0301', 'Model Town, Lahore', 'Lahore'),
(2, 2, 'Ayesha Khan', '0333', 'F-10, Islamabad', 'Islamabad'),
(3, 3, 'Usman Ahmed', '0300', 'Gulshan-e-Iqbal, Karachi', 'Karachi'),
(4, 4, 'Fatima Noor', '0345', 'Satellite Town, Quetta', 'Quetta'),
(5, 5, 'Bilal Tariq', '0321', 'Cantt, Multan', 'Multan'),
(6, 6, 'Sana Malik', '0312', 'Peoples Colony, Faisalabad', 'Faisalabad'),
(7, 7, 'Hamza Sheikh', '0302', 'Shahdara, Lahore', 'Lahore'),
(8, 8, 'Maria Javed', '0331', 'DHA Phase 5, Karachi', 'Karachi'),
(9, 9, 'Imran Shah', '0340', 'G-8, Islamabad', 'Islamabad'),
(10, 10, 'Mehwish Bukhari', '0303', 'Samanabad, Lahore', 'Lahore'),
(11, 1, 'Zain Ali', '0341', 'Jinnah Road, Quetta', 'Quetta'),
(12, 2, 'Hira Yousaf', '0310', 'Shalimar Town, Faisalabad', 'Faisalabad'),
(13, 3, 'Abdul Hadi', '0304', 'Garden Town, Lahore', 'Lahore'),
(14, 4, 'Nimra Saleem', '0320', 'Gulistan-e-Johar, Karachi', 'Karachi'),
(15, 5, 'Yasir Jamal', '0342', 'Kohati Gate, Peshawar', 'Lahore'),
(16, 6, 'Rabia Anwar', '0305', 'Allama Iqbal Town, Lahore', 'Lahore'),
(17, 7, 'Waleed Anwar', '0311', 'Saddar, Karachi', 'Karachi'),
(18, 8, 'Aqsa Imran', '0334', 'Bahria Town, Islamabad', 'Islamabad'),
(19, 9, 'Farhan Zafar', '0306', 'Civic Centre, Faisalabad', 'Faisalabad'),
(20, 10, 'Sadia Saeed', '0322', 'Johar Town, Lahore', 'Lahore'),
(21, 1, 'Noman Riaz', '0343', 'Askari 11, Lahore', 'Lahore'),
(22, 2, 'Kiran Shahid', '0307', 'Nazimabad, Karachi', 'Karachi'),
(23, 3, 'Talha Mehmood', '0335', 'Airport Road, Quetta', 'Quetta'),
(24, 4, 'Hafsa Naveed', '0308', 'Saddar, Multan', 'Multan'),
(25, 5, 'Abdullah Khan', '0323', 'Chowk Yadgar, Peshawar', 'Faisalabad'),
(26, 6, 'Areeba Sheikh', '0344', 'I-8, Islamabad', 'Islamabad'),
(27, 7, 'Rehan Qureshi', '0309', 'F.B. Area, Karachi', 'Karachi'),
(28, 8, 'Maha Tariq', '0313', 'M.A. Jinnah Road, Quetta', 'Quetta'),
(29, 9, 'Hashir Iqbal', '0336', 'Bosan Road, Multan', 'Multan'),
(30, 10, 'Nida Farooq', '0345', 'D Ground, Faisalabad', 'Faisalabad');


-------backup-------
CREATE TABLE BI_Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Phone VARCHAR(15),
    Salary DECIMAL(10, 2)
);
CREATE TABLE BU_Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Phone VARCHAR(15),
    Salary DECIMAL(10, 2)
);
-----trigger--------

CREATE TRIGGER T_S_I
ON Staff
AFTER INSERT
AS
BEGIN
	INSERT INTO BI_Staff(StaffID,Name,Age,Phone,Salary)
	SELECT  I.StaffID,I.Name,I.Age,I.Phone,I.Salary
	FROM INSERTED I
END;

--CREATE TRIGGER T_S_I
--ON Staff
--AFTER INSERT
--AS
--BEGIN
--	INSERT INTO BI_Staff(StaffID,Name,Age,Phone,Salary)
--	SELECT TOP 1 I.StaffID,I.Name,I.Age,I.Phone,I.Salary
--	FROM INSERTED I
--	ORDER BY StaffID DESC;
--END;
--------------------
CREATE TRIGGER T_S_U
ON Staff
AFTER UPDATE
AS
BEGIN
	INSERT INTO BU_Staff(StaffID,Name,Age,Phone,Salary)
	SELECT I.StaffID,I.Name,I.Age,I.Phone,I.Salary
	FROM INSERTED I
	JOIN BI_Staff BI ON I.StaffID=BI.StaffID
	WHERE I.StaffID=BI.StaffID AND BI.Name<> I.Name OR I.Age <> BI.Age OR I.Phone <> BI.Phone OR BI.Salary <> I.Salary	
END;
-------------------------------TABLE 9--------------------------------------
--DROP TABLE Ticket
CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY,
    PassengerID INT,
	RouteID INT,
    ClassName VARCHAR(50),
    ScheduleID INT,
    NumberOfTickets INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (ClassName) REFERENCES TicketPricing(ClassName),
    FOREIGN KEY (ScheduleID) REFERENCES TripSchedule(ScheduleID),
    FOREIGN KEY (RouteID) REFERENCES T_Route(RouteID)
);
SELECT * FROM Ticket 
-------backup-------
CREATE TABLE BI_Ticket (
    TicketID INT PRIMARY KEY,
    PassengerID INT,
	RouteID INT,
    ClassName VARCHAR(50),
    ScheduleID INT,
    NumberOfTickets INT,
    TotalPrice DECIMAL(10, 2)
);
CREATE TABLE BU_Ticket (
    TicketID INT PRIMARY KEY,
    PassengerID INT,
	RouteID INT,
    ClassName VARCHAR(50),
    ScheduleID INT,
    NumberOfTickets INT,
    TotalPrice DECIMAL(10, 2)
);
-----trigger--------
CREATE TRIGGER T_T_I
ON Ticket
AFTER INSERT
AS
BEGIN
	INSERT INTO BI_Ticket(TicketID,PassengerID,RouteID,ClassName,ScheduleID,NumberOfTickets,TotalPrice)
	SELECT TOP 1 I.TicketID,I.PassengerID,I.RouteID,I.ClassName ,I.ScheduleID,I.NumberOfTickets,I.TotalPrice
	FROM INSERTED I
	ORDER BY TicketID DESC;
END;
--------------------
CREATE TRIGGER T_T_U
ON Ticket
AFTER UPDATE
AS
BEGIN
	INSERT INTO BU_Ticket(TicketID,PassengerID,RouteID,ClassName,ScheduleID,NumberOfTickets,TotalPrice)
	SELECT I.TicketID,I.PassengerID,I.RouteID,I.ClassName,I.ScheduleID,I.NumberOfTickets,I.TotalPrice
	FROM INSERTED I
	JOIN BI_Ticket BI ON I.TicketID=BI.TicketID
	WHERE I.TicketID=BI.TicketID AND BI.PassengerID<> I.PassengerID OR BI.RouteID <> I.RouteID OR I.ClassName <> BI.ClassName OR I.ScheduleID <> BI.ScheduleID OR BI.NumberOfTickets<> I.NumberOfTickets OR BI.TotalPrice <> I.TotalPrice
END;
----------------------------TABLE FOR DATA ENTRY OF PASSENGER---------------------------------
CREATE TABLE ENTRY(
	PassengerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Address VARCHAR(50),
    AccountNo VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100),
	ClassName VARCHAR(50),
	DepartureStation VARCHAR(50),
    ArrivalStation VARCHAR(50),
	NumberOfTickets INT
);

-------------------------TRIGGERS---------------------------------
CREATE TRIGGER P
ON ENTRY
AFTER INSERT
AS
BEGIN
	
	INSERT INTO Passenger (PassengerID, Name, Age, Address, AccountNo, Phone, Email)
	SELECT TOP 1 PassengerID, Name, Age, Address, AccountNo, Phone, Email
	FROM INSERTED
	ORDER BY PassengerID DESC; -- or ASC based on what "last" means to you
END;

-------------------------TICKETS-------------------------------

CREATE TRIGGER TIC
ON ENTRY
AFTER INSERT
AS
BEGIN
    DECLARE @PassengerID INT, @ClassName VARCHAR(20), @DepartureStation VARCHAR(50),
            @ArrivalStation VARCHAR(50), @NumberOfTickets INT, 
            @RouteID INT, @TotalPrice DECIMAL(10, 2);

    -- Fetch values from the newly inserted row
    SELECT TOP 1
        @PassengerID = PassengerID,
        @ClassName = ClassName,
        @DepartureStation = DepartureStation,
        @ArrivalStation = ArrivalStation,
        @NumberOfTickets = NumberOfTickets
    FROM INSERTED
    ORDER BY PassengerID;

    -- Now get computed values using your functions
    SET @RouteID = dbo.GET_ROUTEID(@DepartureStation, @ArrivalStation);
    SET @TotalPrice = dbo.TOTAL_PRICE(@ClassName, @DepartureStation, @ArrivalStation, @NumberOfTickets);

    -- Finally insert into Ticket table
    INSERT INTO Ticket (TicketID, PassengerID, RouteID, ClassName, ScheduleID, NumberOfTickets, TotalPrice)
    VALUES (@PassengerID, @PassengerID, @RouteID, @ClassName, @RouteID, @NumberOfTickets, @TotalPrice);
END;

--------------------------FUNCTIONS-----------------------------

CREATE FUNCTION CLASS
(
	@C VARCHAR(50)
)
RETURNS INT
AS
BEGIN
	DECLARE @P INT;
	SELECT @P=PricePerTicket FROM TicketPricing
	WHERE ClassName=@C
	RETURN @P
END;

CREATE FUNCTION GET_ROUTEID
(
	@D VARCHAR(50),
	@A VARCHAR(50)
)
RETURNS INT
AS
BEGIN
	DECLARE @I INT;
	SELECT @I=RouteID FROM T_ROUTE
	WHERE DepartureStation = @D AND ArrivalStation = @A
	RETURN @I
END;

CREATE FUNCTION GET_PRICE
(
	@D VARCHAR(50),
	@A VARCHAR(50)
)
RETURNS INT
AS
BEGIN
	DECLARE @P INT;
	SELECT @P=Price FROM T_ROUTE
	WHERE DepartureStation = @D AND ArrivalStation = @A
	RETURN @P
END;

CREATE FUNCTION TOTAL_PRICE
(
	@CLASS VARCHAR(50),
	@DEPART VARCHAR(50),
	@APPART VARCHAR(50),
	@TicketCount INT
)
RETURNS INT
AS
BEGIN
	DECLARE @UnitPrice INT;
	DECLARE @CLASSPRICE INT;
    DECLARE @Total INT;

    -- Call the other function
    SET @UnitPrice = dbo.GET_PRICE(@DEPART ,@APPART);
    SET @CLASSPRICE = dbo.CLASS(@CLASS);
	SET @UnitPrice = @UnitPrice * @CLASSPRICE; --SINGLE TICKET PRICE
    -- Calculate total
    SET @Total = @UnitPrice * @TicketCount;
	RETURN @Total
END;
--------------------JOINS-----------------

--------------JOINS FOR PASSENGER-------------------

----------Complete Ticket Booking Info-----------

select T.TicketID,P.PassengerID,P.Name,TP.ClassName,TR.DepartureStation,TR.ArrivalStation,TS.DepartureTime,TS.ArrivalTime,
T.NumberOfTickets,T.TotalPrice
From Ticket T
INNER JOIN Passenger P ON T.PassengerID = P.PassengerID
INNER JOIN TicketPricing TP ON T.ClassName = TP.ClassName
INNER JOIN TripSchedule TS ON T.TicketID = TS.ScheduleID
INNER JOIN T_Route TR ON T.RouteID = TR.RouteID;

---Trip Schedule with Route info
SELECT TS.ScheduleID, R.DepartureStation, R.ArrivalStation, TS.DepartureTime, TS.ArrivalTime
FROM TripSchedule TS
INNER JOIN T_Route R ON TS.ScheduleID = R.RouteID;


--Passenger Personal Detail

SELECT P.PassengerID,P.Name,T.TicketID,P.Age,P.Address,P.AccountNo,P.Phone,P.Email
FROM Ticket T
JOIN Passenger P ON T.PassengerID=P.PassengerID

---ALL Entrirs

SELECT * FROM ENTRY

-----------------VIEWS---------------

CREATE VIEW StaffInfo AS
SELECT
	S.StaffID,S.Name,S.Phone,S.Location_of_Working,SI.S_Rank,SI.Salary
FROM 
    Staff S
INNER JOIN SalaryInfo SI ON S.S_ID = SI.S_ID;

------DISPLAY----
SELECT * FROM StaffInfo

-------------Procedure----------------

CREATE PROCEDURE DELETE_ENTRY
@ID INT 
AS
BEGIN
	DELETE FROM Ticket
	where TicketID = @ID;
	
	DELETE FROM Passenger
	where PassengerID = @ID

	DELETE FROM ENTRY
	where PassengerID = @ID
END;
-------------DELETE RECORD---------------

EXEC DELETE_ENTRY @ID= 2;--ENTER ID THAT NEEDS TO DELETE

-----------SHOW ALL DATA---------------

--DELETE FROM Ticket
--DELETE FROM BI_Ticket
--DELETE FROM Passenger
--DELETE FROM BI_Passenger
--DELETE FROM ENTRY

SELECT * FROM Ticket
SELECT * FROM BI_Ticket
SELECT * FROM Passenger
SELECT * FROM BI_Passenger
SELECT * FROM ENTRY

-------Values Insertion In ENTRY Table-------
insert into ENTRY values (1, 'Ali', 20, 'Bhobatian', 'Meezan1001', '03011019187', 'ali@gmail.com', 'Economy', 'Lahore', 'Karachi', 1);
insert into ENTRY values (2, 'Ayesha', 24, 'Faisal Town', 'Meezan1002', '03022019187', 'ayesha@gmail.com', 'Business', 'Karachi', 'Lahore', 2);
insert into ENTRY values (3, 'Usman', 29, 'Model Town', 'Meezan1003', '03033019187', 'usman@gmail.com', 'Economy', 'Islamabad', 'Karachi', 3);
insert into ENTRY values (4, 'Hira', 22, 'Gulshan', 'Meezan1004', '03044019187', 'hira@gmail.com', 'Business', 'Faisalabad', 'Karachi', 4);
insert into ENTRY values (5, 'Bilal', 31, 'Cavalry', 'Meezan1005', '03055019187', 'bilal@gmail.com', 'Economy', 'Lahore', 'Quetta', 5);
insert into ENTRY values (6, 'Rabia', 28, 'Iqbal Town', 'Meezan1006', '03066019187', 'rabia@gmail.com', 'Business', 'Karachi', 'Islamabad', 6);
insert into ENTRY values (7, 'Hamza', 35, 'Defence', 'Meezan1007', '03077019187', 'hamza@gmail.com', 'Economy', 'Quetta', 'Lahore', 7);
insert into ENTRY values (8, 'Sana', 26, 'DHA', 'Meezan1008', '03088019187', 'sana@gmail.com', 'Business', 'Karachi', 'Islamabad', 8);
insert into ENTRY values (9, 'Zeeshan', 27, 'Johar Town', 'Meezan1009', '03099019187', 'zeeshan@gmail.com', 'Economy', 'Quetta', 'Karachi', 9);
insert into ENTRY values (10, 'Mujtaba', 40, 'Shalimar', 'Meezan1010', '03100019187', 'mujtaba@gmail.com', 'Business', 'Lahore', 'Islamabad', 10);
insert into ENTRY values (11, 'Umair', 23, 'Garden Town', 'Meezan1011', '03111019187', 'umair@gmail.com', 'Economy', 'Quetta', 'Karachi', 11);
insert into ENTRY values (12, 'Nadia', 34, 'PECHS', 'Meezan1012', '03122019187', 'nadia@gmail.com', 'Business', 'Karachi', 'Islamabad', 12);
insert into ENTRY values (13, 'Saad', 36, 'Satellite Town', 'Meezan1013', 'Meezan1013', '03133019187', 'saad@gmail.com', 'First Class', 'Lahore', 'Karachi', 13);
insert into ENTRY values (14, 'Hashir', 21, 'Gulistan-e-Johar', 'Meezan1014', '03144019187', 'hashir@gmail.com', 'Business', 'Karachi', 'Lahore', 14);
insert into ENTRY values (15, 'Farah', 27, 'Model Town', 'Meezan1015', '03155019187', 'farah@gmail.com', 'Economy', 'Islamabad', 'Quetta', 15);
insert into ENTRY values (16, 'Waleed', 32, 'Defence', 'Meezan1016', '03166019187', 'waleed@gmail.com', 'VIP', 'Lahore', 'Quetta', 16);
insert into ENTRY values (17, 'Aiman', 25, 'Faisal Town', 'Meezan1017', '03177019187', 'aiman@gmail.com', 'Economy', 'Karachi', 'Faisalabad', 17);
insert into ENTRY values (18, 'Areeba', 22, 'Johar Town', 'Meezan1018', '03188019187', 'areeba@gmail.com', 'Business', 'Islamabad', 'Karachi', 18);
insert into ENTRY values (19, 'Danish', 29, 'Garden Town', 'Meezan1019', '03199019187', 'danish@gmail.com', 'Economy', 'Quetta', 'Lahore', 19);
insert into ENTRY values (20, 'Irfan', 39, 'Satellite Town', 'Meezan1020', '03200019187', 'irfan@gmail.com', 'Business', 'Karachi', 'Faisalabad', 20);
insert into ENTRY values (21, 'Shahbaz', 30, 'Gulshan-e-Iqbal', 'Meezan1021', '03211019187', 'shahbaz@gmail.com', 'Economy', 'Islamabad', 'Quetta', 21);
insert into ENTRY values (22, 'Zunaira', 26, 'Model Town', 'Meezan1022', '03222019187', 'zunaira@gmail.com', 'Business', 'Quetta', 'Islamabad', 22);
insert into ENTRY values (23, 'Hassan', 24, 'Defence', 'Meezan1023', '03233019187', 'hassan@gmail.com', 'Economy', 'Lahore', 'Karachi', 23);
insert into ENTRY values (24, 'Fatima', 23, 'PECHS', 'Meezan1024', '03244019187', 'fatima@gmail.com', 'Business', 'Karachi', 'Faisalabad', 24);
insert into ENTRY values (25, 'Shiza', 28, 'Johar Town', 'Meezan1025', '03255019187', 'shiza@gmail.com', 'Economy', 'Islamabad', 'Karachi', 25);
insert into ENTRY values (26, 'Abdullah', 30, 'Shalimar', 'Meezan1026', '03266019187', 'abdullah@gmail.com', 'Business', 'Quetta', 'Lahore', 26);
insert into ENTRY values (27, 'Maha', 21, 'Cavalry', 'Meezan1027', '03277019187', 'maha@gmail.com', 'Economy', 'Faisalabad', 'Karachi', 27);
insert into ENTRY values (28, 'Rehan', 35, 'Gulshan', 'Meezan1028', '03288019187', 'rehan@gmail.com', 'Business', 'Lahore', 'Karachi', 28);
insert into ENTRY values (29, 'Hammad', 32, 'Gulshan-e-Jamal', 'Meezan1029', '03299019187', 'hammad@gmail.com', 'Economy', 'Karachi', 'Islamabad', 29);
insert into ENTRY values (30, 'Anum', 27, 'Johar Town', 'Meezan1030', '03300019187', 'anum@gmail.com', 'VIP', 'Islamabad', 'Karachi', 30);

