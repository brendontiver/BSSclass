/* 
* Author: Brendon Tiver
*
* Creates all tavern database tables and populates them
*
*/


DROP TABLE IF EXISTS RoomStay;
DROP TABLE IF EXISTS RoomStatus;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS ClassLevel;
DROP TABLE IF EXISTS Class;
DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS ServiceStatus;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS SuppliesReceived;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Locations;
/*DROP TABLE IF EXISTS Rats;*/
DROP TABLE IF EXISTS Owners;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Tavern;



/* Create tables */

CREATE TABLE Tavern(
	tavernID INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(32),
	numFloors INT,
	locationID INT,
	ownerID INT
);

INSERT INTO Tavern(name, numFloors, locationID, ownerID) VALUES ('Paddys', 1, 1, 2);
INSERT INTO Tavern(name, numFloors, locationID, ownerID) VALUES ('Dannys', 1, 2, 3);
INSERT INTO Tavern(name, numFloors, locationID, ownerID) VALUES ('Bobbys', 2, 3, 5);
INSERT INTO Tavern(name, numFloors, locationID, ownerID) VALUES ('Jerrys', 1, 5, 1);
INSERT INTO Tavern(name, numFloors, locationID, ownerID) VALUES ('Harrys', 2, 4, 4);



CREATE TABLE Users(
	userID INT IDENTITY(1,1) PRIMARY KEY,
	tavernID INT FOREIGN KEY REFERENCES Tavern(tavernID),
	name VARCHAR(32),
	roleID INT
);

INSERT INTO Users(tavernID, name, roleID) VALUES (1, 'Tom', 1);
INSERT INTO Users(tavernID, name, roleID) VALUES (2, 'Jon', 1);
INSERT INTO Users(tavernID, name, roleID) VALUES (3, 'Guy', 2);
INSERT INTO Users(tavernID, name, roleID) VALUES (3, 'Sam', 3);
INSERT INTO Users(tavernID, name, roleID) VALUES (5, 'Liz', 2);
INSERT INTO Users(tavernID, name, roleID) VALUES (3, 'Adam', 6);
INSERT INTO Users(tavernID, name, roleID) VALUES (1, 'Joseph', 6);



CREATE TABLE Roles(
	roleID INT IDENTITY(1,1) PRIMARY KEY,
	description VARCHAR(255)
);

INSERT INTO Roles(description) VALUES('Bartender');
INSERT INTO Roles(description) VALUES('Waiter');
INSERT INTO Roles(description) VALUES('Chef');
INSERT INTO Roles(description) VALUES('Cleaner');
INSERT INTO Roles(description) VALUES('Host');
INSERT INTO Roles(description) VALUES('Admin'); -- Created for question 1 on homework 4



CREATE TABLE Owners(
	ownerID INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(32),
	ownerInformation VARCHAR(255)
);
INSERT INTO Owners(name, ownerInformation) VALUES ('Paddy', 'Very, very rich');
INSERT INTO Owners(name, ownerInformation) VALUES ('Danny', 'A great guy');
INSERT INTO Owners(name, ownerInformation) VALUES ('Bobby', 'A good friend');
INSERT INTO Owners(name, ownerInformation) VALUES ('Jerry', 'Kind of strange');
INSERT INTO Owners(name, ownerInformation) VALUES ('Harry', 'Unpredictable');


/* Getting rid of the rats

CREATE TABLE Rats(
	tavernID INT,
	name VARCHAR(32)
);

INSERT INTO Rats(name) VALUES ('Squeaks');
INSERT INTO Rats(name) VALUES ('Nibbler');
INSERT INTO Rats(name) VALUES ('Chomper');
INSERT INTO Rats(name) VALUES ('Tiny');
INSERT INTO Rats(name) VALUES ('Scamper');
*/

CREATE TABLE Locations(
	locationID INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(255)
);

INSERT INTO Locations (name) VALUES ('Pubsville');
INSERT INTO Locations (name) VALUES ('Downtown');
INSERT INTO Locations (name) VALUES ('Uptown');
INSERT INTO Locations (name) VALUES ('Oldesville');
INSERT INTO Locations (name) VALUES ('Marketplace');



CREATE TABLE Supplies(
	supplyID INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(32),
	unit VARCHAR(32),
	supplyCount INT
);


INSERT INTO Supplies (name, unit, supplyCount) VALUES ('Ale', 'Barrel', 30);
INSERT INTO Supplies (name, unit, supplyCount) VALUES ('Rat poison', 'Bottle', 5);
INSERT INTO Supplies (name, unit, supplyCount) VALUES ('Cheese', 'Wheel', 3);
INSERT INTO Supplies (name, unit, supplyCount) VALUES ('Candle', 'Stick', 40);
INSERT INTO Supplies (name, unit, supplyCount) VALUES ('Meat', 'Pound', 25);



CREATE TABLE Inventory(
	inventoryID INT IDENTITY(1,1) PRIMARY KEY,
	supplyID INT FOREIGN KEY REFERENCES Supplies(supplyID),
	tavernID INT FOREIGN KEY REFERENCES Tavern(tavernID),
	updated DATETIME,
	count INT
);

INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(1, 1, GetDate(), 5);
INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(1, 3, GetDate(), 2);
INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(3, 1, GetDate(), 1);
INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(5, 4, GetDate(), 10);
INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(2, 2, GetDate(), 20);



CREATE TABLE SuppliesReceived(
	supplyID INT FOREIGN KEY REFERENCES Supplies(supplyID),
	tavernID INT FOREIGN KEY REFERENCES Tavern(tavernID),
	cost DECIMAL,
	amountReceived INT,
	dateReceived DATETIME,
	PRIMARY KEY (supplyID, tavernID)
);

INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(1, 3, 50.0, 5, GetDate());
INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(3, 4, 20.0, 2, GetDate());
INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(2, 3, 40.0, 3, GetDate());
INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(4, 5, 35.0, 3, GetDate());
INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(2, 1, 15.0, 1, GetDate());




CREATE TABLE Services(
	serviceID INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(32),
	statusID INT 
);


INSERT INTO Services(name, statusID) VALUES ('Blade sharpening', 1);
INSERT INTO Services(name, statusID) VALUES ('Boarding', 1);
INSERT INTO Services(name, statusID) VALUES ('Horse brushing', 1);
INSERT INTO Services(name, statusID) VALUES ('Massage', 0);
INSERT INTO Services(name, statusID) VALUES ('Boot shining', 1);
INSERT INTO	Services(name, statusID) VALUES ('Supply Sale', 1);



CREATE TABLE ServiceStatus(
	statusID INT IDENTITY(1,1) PRIMARY KEY,
	description VARCHAR(255)
);

INSERT INTO ServiceStatus(description) VALUES ('Available');
INSERT INTO ServiceStatus(description) VALUES ('Unavailable');


CREATE TABLE Sales(
	saleID INT IDENTITY(1,1) PRIMARY KEY,
	supplyID INT,
	guestID INT,
	datePurchased DATETIME,
	amountPurchased INT,
	tavernID INT FOREIGN KEY REFERENCES Tavern(tavernID),
	cost MONEY
);

INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 1, GetDate(), 1, 1, 20.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 1, GetDate(), 1, 1, 40.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 2, GetDate(), 1, 1, 35.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 3, GetDate(), 1, 1, 100.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (5, 4, GetDate(), 1, 1, 5.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 3, GetDate(), 1, 2, 20.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 4, GetDate(), 1, 2, 40.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 2, GetDate(), 1, 2, 35.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 5, GetDate(), 1, 3, 400.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (5, 5, GetDate(), 1, 3, 550.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 2, GetDate(), 1, 3, 20.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 1, GetDate(), 1, 4, 40.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 4, GetDate(), 1, 5, 350.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 3, GetDate(), 1, 5, 100.00);
INSERT INTO Sales(supplyID, guestID, datePurchased, amountPurchased, tavernID, cost) VALUES (5, 3, GetDate(), 1, 5, 55.00); 


CREATE TABLE Guests(
	guestID INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(32),
	notes VARCHAR(255),
	birthday DATETIME,
	cakeday DATETIME,
	statusID INT FOREIGN KEY REFERENCES ServiceStatus(statusID)
);

INSERT INTO Guests(name, notes, birthday, cakeday, statusID) VALUES ('Joe', 'Angry drunk', '2002-02-02', '2002-02-03', 2);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID) VALUES ('Moe', 'Funny man', '1999-06-02', '1999-06-03', 1);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID) VALUES ('Jay', 'Cool guy', '2000-09-15', '2000-09-16', 1);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID) VALUES ('May', 'Bubbly', '1975-4-10', '1975-04-11', 1);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID) VALUES ('Joe2', 'Wanderer', '1990-02-10', '1990-02-11', 2);

CREATE TABLE GuestStatus(
	statusID INT IDENTITY(1,1) PRIMARY KEY,
	guestID INT,
	name VARCHAR(32)
);
INSERT INTO GuestStatus(name) VALUES ('Sober');
INSERT INTO GuestStatus(name) VALUES ('Passed out');

CREATE TABLE Class(
	classID INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(32)
);

INSERT INTO Class(name) VALUES ('Wizard');
INSERT INTO Class(name) VALUES ('Warrior');
INSERT INTO Class(name) VALUES ('Cleric');



CREATE TABLE ClassLevel(
	classLevelID INT IDENTITY(1,1) PRIMARY KEY,
	guestID INT FOREIGN KEY REFERENCES Guests(guestID),
	classID INT FOREIGN KEY REFERENCES Class(classID),
	level INT
	
);

INSERT INTO ClassLevel(guestID, classID, level) VALUES (1, 1, 5);
INSERT INTO ClassLevel(guestID, classID, level) VALUES (1, 3, 12);
INSERT INTO ClassLevel(guestID, classID, level) VALUES (2, 2, 15);
INSERT INTO ClassLevel(guestID, classID, level) VALUES (3, 2, 8);
INSERT INTO ClassLevel(guestID, classID, level) VALUES (4, 3, 22);
INSERT INTO ClassLevel(guestID, classID, level) VALUES (5, 1, 25);
INSERT INTO ClassLevel(guestID, classID, level) VALUES (5, 2, 14);

CREATE TABLE Room(
	roomID INT IDENTITY(1,1) PRIMARY KEY, 
	tavernID INT,
	roomStatusID INT
);

INSERT INTO Room(tavernID, roomStatusID) VALUES (1, 1);
INSERT INTO Room(tavernID, roomStatusID) VALUES (1, 0);
INSERT INTO Room(tavernID, roomStatusID) VALUES (3, 0);
INSERT INTO Room(tavernID, roomStatusID) VALUES (4, 1);
INSERT INTO Room(tavernID, roomStatusID) VALUES (5, 1);

CREATE TABLE RoomStatus(
	roomStatusID INT IDENTITY(1,1) PRIMARY KEY,
	description VARCHAR(32)
);

INSERT INTO RoomStatus(description) VALUES ('Active');
INSERT INTO RoomStatus(description) VALUES ('Inactive');

CREATE TABLE RoomStay(
	guestID INT,
	roomID INT,
	saleID INT,
	dateStayedIn DATETIME,
	rate MONEY
);

INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (1, 1, 2, '2019-01-10', 100.00);
INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (2, 2, 3, '2019-03-09', 150.00);
INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (2, 3, 3, '2019-04-09', 150.00);
INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (2, 3, 3, '2019-02-14', 250.00);
INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (2, 4, 3, '2019-02-28', 50.00);
INSERT INTO RoomStay(guestId, roomID, saleID, dateStayedIn, rate) VALUES (3, 2, 2, '2019-02-28', 80.00);


/* Alter table */

ALTER TABLE Tavern ADD numTables INT;
ALTER TABLE Owners ADD numTavernsOwned INT;
ALTER TABLE ClassLevel ADD FOREIGN KEY (classID) REFERENCES Class(classID);

go
/* Homework assignment 6 */

/* 1. Write a stored procedure that takes a class name and returns all guests that have any levels of that class */
DROP PROC IF EXISTS searchByClass
go

CREATE PROCEDURE searchByClass
@class VARCHAR(30)
AS
SELECT Guests.name AS Name, Class.name AS Class, ClassLevel.level as Level
FROM Guests
JOIN ClassLevel 
ON ClassLevel.guestID = Guests.guestID
JOIN Class
ON Class.classID = ClassLevel.classID
WHERE Class.name = @class
go

-- Test for Q1
-- EXEC searchByClass @class = 'Wizard'
-- go


/* 2. Write a stored procedure that takes a guest id and returns the total that guest spent on services */
DROP PROC IF EXISTS amountSpentByGuest
go

CREATE PROCEDURE amountSpentByGuest
@guestid INT
AS
SELECT Guests.name AS Name, SUM(Sales.cost) AS TotalSpent
FROM Guests
JOIN Sales 
ON Sales.guestID = Guests.guestID
WHERE Guests.guestID = @guestid
GROUP BY Guests.name
go

-- Test for Q2
-- EXEC amountSpentByGuest @guestid = 1
-- go


/* 3. Write a stored procedure that takes a level and an optional argument that determines 
      whether the procedure returns guests of that level and higher or that level and lower */
DROP PROC IF EXISTS returnHigherOrLowerLevel
go

CREATE PROCEDURE returnHigherOrLowerLevel
@level INT, @highorlow INT = NULL
AS

IF(@highorlow = 0) -- Use 0 to return levels <= to input
SELECT Guests.name AS Name, Class.name AS Class, ClassLevel.level AS Level
FROM Guests
JOIN ClassLevel
ON ClassLevel.guestID = Guests.guestID
JOIN Class
ON Class.classID = ClassLevel.classID
WHERE ClassLevel.level <= @highorlow;

ELSE IF(@highorlow = 1) -- Use 1 to return level >= input
SELECT Guests.name AS Name, Class.name AS Class, ClassLevel.level AS Level
FROM Guests
JOIN ClassLevel
ON ClassLevel.guestID = Guests.guestID
JOIN Class
ON Class.classID = ClassLevel.classID
WHERE ClassLevel.level >= @highorlow;

ELSE -- Do not specify 1 or 0 to return level = to input
SELECT Guests.name AS Name, Class.name AS Class, ClassLevel.level AS Level
FROM Guests
JOIN ClassLevel
ON ClassLevel.guestID = Guests.guestID
JOIN Class
ON Class.classID = ClassLevel.classID
WHERE ClassLevel.level = @highorlow;
go

-- Tests for Q3
-- EXEC returnHigherOrLowerLevel @level = 10
-- go

-- EXEC returnHigherOrLowerLevel @level = 15, @highorlow = 1 /* Still getting levels lower than 15 here for some reason */
-- go

/* 4. Write a stored procedure that deletes a Tavern ( don’t run it yet or rollback your transaction if you do ) */
DROP PROC IF EXISTS deleteTavern
go

CREATE PROCEDURE deleteTavern
@tavernName VARCHAR(30)
AS 
DELETE  
FROM Tavern
WHERE Tavern.name = @tavernName
go

-- No tests for Q4 as I do not want to delete a tavern 

/* 5. Write a trigger that watches for deleted taverns and use it to remove taverns, supplies, rooms, and services tied to it */
DROP TRIGGER IF EXISTS deleteTavernInventory
go

CREATE TRIGGER deleteTavernInventory
ON dbo.Tavern
AFTER DELETE 
AS BEGIN

DELETE Inventory 
FROM Inventory
JOIN Tavern
ON Tavern.tavernID = Inventory.tavernID
WHERE Inventory.tavernID = (SELECT deleted.tavernID
							FROM deleted)

DELETE Room 
FROM Room
JOIN Tavern
ON Tavern.tavernID = Room.tavernID
WHERE Room.tavernID = (SELECT deleted.tavernID
							FROM deleted)

/* My services were not tied to one particular tavern but
   if they were this is what it would look like

DELETE Services 
FROM Services
JOIN Tavern
ON Tavern.tavernID = Services.tavernID
WHERE Services.tavernID = (SELECT deleted.tavernID
							FROM deleted)
*/
END
go



/* 6. Write a stored procedure that uses the function from the last assignment that returns open rooms with their prices, 
      and automatically book the lowest price room with a guest for one day */
DROP FUNCTION IF EXISTS PriceSearch
go

CREATE FUNCTION PriceSearch(@min MONEY, @max MONEY)
RETURNS TABLE
AS 
RETURN (SELECT Room.roomID AS Room, Tavern.name AS Tavern, RoomStay.rate AS Rate
		FROM Room
		JOIN RoomStay
		ON Room.roomID = RoomStay.roomID
		JOIN Tavern
		ON Room.tavernID = Tavern.tavernID
		WHERE @min < RATE AND Rate < @max
		);
go


DROP PROC IF EXISTS bookLowestPricedRoom
go

CREATE PROCEDURE bookLowestPricedRoom
@date
AS
 -- I'm not sure how to utilize the function from the last assignment to find the lowest price at a specific date


/* 7. Write a trigger that watches for new bookings and adds a new sale for the guest 
      for a service (for free if you can in your schema) */

	  -- Not sure what is meant by adding a new sale for the guest for a service in this question

