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
	statusID INT FOREIGN KEY REFERENCES ServiceStatus(statusID),
	classID INT
);

INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('Joe', 'Angry drunk', '2002-02-02', '2002-02-03', 2, 2);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('Moe', 'Funny man', '1999-06-02', '1999-06-03', 1, 2);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('Jay', 'Cool guy', '2000-09-15', '2000-09-16', 1, 2);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('May', 'Bubbly', '1975-4-10', '1975-04-11', 1, 1);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('Joe2', 'Wanderer', '1990-02-10', '1990-02-11', 2, 3);

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
	level INT,
	classID INT
);

INSERT INTO ClassLevel(level, classID) VALUES (5, 2);
INSERT INTO ClassLevel(level, classID) VALUES (10, 2);
INSERT INTO ClassLevel(level, classID) VALUES (25, 1);
INSERT INTO ClassLevel(level, classID) VALUES (28, 1);
INSERT INTO ClassLevel(level, classID) VALUES (1, 3);
INSERT INTO ClassLevel(level, classID) VALUES (14, 3);
INSERT INTO ClassLevel(level, classID) VALUES (18, 3);

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
INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (2, 2, 3, '2019-04-09', 150.00);
INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (2, 2, 3, '2019-02-14', 250.00);
INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (2, 2, 3, '2019-02-28', 50.00);


/* Alter table */

ALTER TABLE Tavern ADD numTables INT;
ALTER TABLE Owners ADD numTavernsOwned INT;
ALTER TABLE ClassLevel ADD FOREIGN KEY (classID) REFERENCES Class(classID);


/* Queries for homework assignment 4 */


/* 1. Return users who have admin roles */
SELECT Users.name, Roles.description 
FROM Users 
JOIN
Roles ON Users.roleID = Roles.roleID
WHERE description = 'Admin';



/* 2. Returns users who have admin roles and information about their taverns */
SELECT Users.name AS Name, Roles.description AS Role, Tavern.name AS TavernName, Tavern.numFloors AS NumFloors, Locations.name AS Location
FROM Users 
JOIN
Roles ON Users.roleID = Roles.roleID
JOIN
Tavern ON Users.tavernID = Tavern.tavernID
JOIN 
Locations ON Tavern.locationID = Locations.locationID
WHERE description = 'Admin';



/* 3. Returns all guests ordered by name (ascending) and their classes and corresponding levels */
/* For some reason the way I have my tables set up now, guests have more than one level per class - I will come back and fix this */
SELECT Guests.name, Class.name, ClassLevel.level
From Guests
JOIN
Class ON Guests.classID = Class.classID
JOIN
ClassLevel ON ClassLevel.classID = Class.classID
ORDER BY Guests.name ASC;



/* 4. Returns the top 10 sales in terms of sales price and what the services were */
SELECT TOP 10 Services.name, Sales.cost, Sales.datePurchased
FROM Services
JOIN
Sales ON Services.serviceID = Sales.serviceID
ORDER BY cost DESC;



/* 5. Returns guests with 2 or more classes */
SELECT Guests.name 
FROM Guests 
JOIN 
Class ON Class.classID = Guests.classID 
JOIN 
ClassLevel ON ClassLevel.classID = Guests.classID
GROUP BY Guests.name HAVING COUNT(*) > 1 
ORDER BY Guests.name ASC;



/* 6. Returns guests with 2 or more classes over level 5 */
SELECT Guests.name 
FROM Guests 
JOIN 
Class ON Class.classID = Guests.classID 
JOIN 
ClassLevel ON ClassLevel.classID = Guests.classID
WHERE ClassLevel.level > 5
GROUP BY Guests.name HAVING COUNT(*) > 1 
ORDER BY Guests.name ASC;



/* 7.  Returns guests with ONLY their highest level class */
/* This only returns the person with the highest level across all people and classes -
   not sure how to get it for each guest */
SELECT TOP 1 Guests.name AS Name, Class.name AS Class, ClassLevel.level AS Level
FROM Guests 
JOIN 
Class ON Class.classID = Guests.classID 
JOIN 
ClassLevel ON ClassLevel.classID = Guests.classID
ORDER BY ClassLevel.level DESC;



/* 8. Returns guests that stay within a date range. 
	  Please remember that guests can stay for more than one night AND 
	  not all of the dates they stay have to be in that range (just some of them) */
SELECT Guests.name, RoomStay.dateStayedIn
FROM Guests 
JOIN 
RoomStay ON RoomStay.guestId = Guests.guestID
WHERE dateStayedIn >= '2019-02-01' AND dateStayedIn <= '2019-02-28';



/* 9. Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it

	  I'm pretty sure all we have to do here is concatenate 'PRIMARY KEY IDENTITY(1,1)' to 'taverinID INT' but I'm not sure where exactly 
	  to place the concat within this query */
SELECT CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'Tavern' 
UNION ALL 
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, ( 
	CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
	Then CONCAT ('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') Else '' END) , 
	CASE WHEN refConst.CONSTRAINT_NAME IS NOT NULL 
	Then (CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) Else '' END , ',') as queryPiece 
	FROM INFORMATION_SCHEMA.COLUMNS as cols 
	LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys 
	ON (keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME) 
	LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst 
	ON (refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME) 
	LEFT JOIN (SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
	FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME) 
	WHERE cols.TABLE_NAME = 'Tavern' UNION ALL SELECT ')';