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
	unit VARCHAR(32)
);

INSERT INTO Supplies (name, unit) VALUES ('Ale', 'Barrel');
INSERT INTO Supplies (name, unit) VALUES ('Rat poison', 'Bottle');
INSERT INTO Supplies (name, unit) VALUES ('Cheese', 'Wheel');
INSERT INTO Supplies (name, unit) VALUES ('Candle', 'Stick');
INSERT INTO Supplies (name, unit) VALUES ('Meat', 'Pound');




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



CREATE TABLE ServiceStatus(
	statusID INT IDENTITY(1,1) PRIMARY KEY,
	description VARCHAR(255)
);

INSERT INTO ServiceStatus(description) VALUES ('Available');
INSERT INTO ServiceStatus(description) VALUES ('Unavailable');


CREATE TABLE Sales(
	saleID INT IDENTITY(1,1) PRIMARY KEY,
	serviceID INT,
	guestName VARCHAR(32),
	datePurchased DATETIME,
	amountPurchased INT,
	tavernID INT FOREIGN KEY REFERENCES Tavern(tavernID),
	cost MONEY
);

INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'Jacob', GetDate(), 1, 1, 20.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'Kenneth', GetDate(), 1, 1, 40.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'William', GetDate(), 1, 1, 35.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'Travis', GetDate(), 1, 1, 100.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (5, 'Michael', GetDate(), 1, 1, 5.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'a', GetDate(), 1, 2, 20.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'b', GetDate(), 1, 2, 40.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'c', GetDate(), 1, 2, 35.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'd', GetDate(), 1, 3, 400.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (5, 'e', GetDate(), 1, 3, 550.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'f', GetDate(), 1, 3, 20.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'g', GetDate(), 1, 4, 40.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'h', GetDate(), 1, 5, 350.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'i', GetDate(), 1, 5, 100.00);
INSERT INTO Sales(serviceID, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (5, 'j', GetDate(), 1, 5, 55.00); 


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


/* Queries for homework assignment 5 */

/* 1. Returns a “report” of all users and their roles */
SELECT Users.name as Name, Roles.description AS Role
FROM Users
JOIN Roles 
ON Users.roleID = Roles.roleId
ORDER BY Users.name ASC;
go

/* 2. Returns all classes and the count of guests that hold those classes */
SELECT Class.name, COUNT(guestID) AS NumGuests
FROM Class
JOIN ClassLevel
ON Class.classID = ClassLevel.classID
GROUP BY Class.name;
go

/* 3. Returns all guests ordered by name (ascending) and their classes and corresponding levels. 
	  Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes */
SELECT Guests.name AS Name, Class.name AS Class, ClassLevel.level AS Level,
	   CASE
	   WHEN ClassLevel.level <= 5 THEN 'Beginner'
	   WHEN ClassLevel.level > 5 AND ClassLevel.level <= 10 THEN 'Intermediate'
	   WHEN ClassLevel.level > 10 THEN 'Expert'
	   END
	   AS Ranking
FROM Guests
JOIN ClassLevel
ON Guests.guestID = ClassLevel.guestID
JOIN Class
ON ClassLevel.classID = Class.classID
ORDER BY Guests.name ASC;
go

/* 4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc) */
CREATE FUNCTION Ranking(@level INT)
RETURNS VARCHAR(50)
AS BEGIN
RETURN 
	   CASE
	   WHEN @level <= 5 THEN 'Beginner'
	   WHEN @level > 5 AND @level <= 10 THEN 'Intermediate'
	   WHEN @level > 10 THEN 'Expert'
	   END
END;
go

-- Tests for question 4
-- SELECT dbo.Ranking(1);
-- SELECT dbo.Ranking(10);
-- SELECT dbo.Ranking(11);


/* 5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to */
CREATE FUNCTION OpenRooms(@date DATETIME)
RETURNS TABLE
AS 
RETURN (SELECT Room.roomID AS Room, Tavern.name AS Tavern
		FROM Room
		JOIN RoomStay
		ON Room.roomID = RoomStay.roomID
		JOIN Tavern
		ON Room.tavernID = Tavern.tavernID
		WHERE RoomStay.dateStayedIn != @date
		);
go

-- Tests for question 5
-- SELECT * FROM dbo.OpenRooms('2019-01-10'); -- One room is taken this date
-- SELECT * FROM dbo.OpenRooms('2000-01-01'); -- No rooms are taken this date
-- SELECT * FROM dbo.OpenRooms('2019-02-28'); -- Two rooms are taken this date

/* 6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices)
	  Return Rooms and their taverns based on price inputs */
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

-- Tests for question 6
-- SELECT * FROM dbo.PriceSearch(50, 100);
-- SELECT * FROM dbo.PriceSearch(50, 200);
-- SELECT * FROM dbo.PriceSearch(150, 300);

/* 7. Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny 
	  - thereby making the new room the cheapest one */
DECLARE @min INT
SELECT @min = min(Rate) 
FROM dbo.PriceSearch(0,5000)
INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (1, 1, 2, GETDATE(), @min-.01);
SELECT * FROM RoomStay;






