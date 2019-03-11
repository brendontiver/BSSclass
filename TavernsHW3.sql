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
	tavernID INT,
	name VARCHAR(32),
	roleID INT
);

INSERT INTO Users(tavernID, name, roleID) VALUES (1, 'Tom', 1);
INSERT INTO Users(tavernID, name, roleID) VALUES (2, 'Jon', 1);
INSERT INTO Users(tavernID, name, roleID) VALUES (3, 'Guy', 2);
INSERT INTO Users(tavernID, name, roleID) VALUES (3, 'Sam', 3);
INSERT INTO Users(tavernID, name, roleID) VALUES (5, 'Liz', 2);



CREATE TABLE Roles(
	roleID INT IDENTITY(1,1) PRIMARY KEY,
	description VARCHAR(255)
);

INSERT INTO Roles(description) VAlUES('Bartender');
INSERT INTO Roles(description) VAlUES('Waiter');
INSERT INTO Roles(description) VAlUES('Chef');
INSERT INTO Roles(description) VAlUES('Cleaner');
INSERT INTO Roles(description) VAlUES('Host');



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
	supplyID INT,
	tavernID INT,
	updated DATETIME,
	count INT
);

INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(1, 1, GetDate(), 5);
INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(1, 3, GetDate(), 2);
INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(3, 1, GetDate(), 1);
INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(5, 4, GetDate(), 10);
INSERT INTO Inventory(supplyID, tavernID, updated, count) VALUES(2, 2, GetDate(), 20);



CREATE TABLE SuppliesReceived(
	supplyID INT,
	tavernID INT,
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
	service VARCHAR(255),
	guestName VARCHAR(32),
	datePurchased DATETIME,
	amountPurchased INT,
	tavernID INT,
	cost MONEY
);

INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'Jacob', GetDate(), 1, 1, 20.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'Kenneth', GetDate(), 1, 1, 40.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'William', GetDate(), 1, 1, 35.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'Travis', GetDate(), 1, 1, 100.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (5, 'Michael', GetDate(), 1, 1, 5.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'a', GetDate(), 1, 2, 20.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'b', GetDate(), 1, 2, 40.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'c', GetDate(), 1, 2, 35.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'd', GetDate(), 1, 3, 400.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (5, 'e', GetDate(), 1, 3, 550.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'f', GetDate(), 1, 3, 20.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'g', GetDate(), 1, 4, 40.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (2, 'h', GetDate(), 1, 5, 350.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (1, 'i', GetDate(), 1, 5, 100.00);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID, cost) VALUES (5, 'j', GetDate(), 1, 5, 55.00);


CREATE TABLE Guests(
	guestID INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(32),
	notes VARCHAR(255),
	birthday DATETIME,
	cakeday DATETIME,
	statusID INT,
	classID INT
);

INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('Joe', 'Angry drunk', '2002-02-02', '2002-02-03', 2, 2);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('Moe', 'Funny man', '1999-06-02', '1999-06-03', 1, 2);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('Jay', 'Cool guy', '2000-09-15', '2000-09-16', 1, 2);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('May', 'Bubbly', '1975-4-10', '1975-04-11', 1, 1);
INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('Joe', 'Wanderer', '1990-02-10', '1990-02-11', 2, 3);

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
	guestID INT FOREIGN KEY REFERENCES Guests(guestID),
	classID INT
);

INSERT INTO ClassLevel(level, guestID, classID) VALUES (5, 1, 2);
INSERT INTO ClassLevel(level, guestID, classID) VALUES (10, 2, 2);
INSERT INTO ClassLevel(level, guestID, classID) VALUES (25, 3, 1);
INSERT INTO ClassLevel(level, guestID, classID) VALUES (28, 4, 1);
INSERT INTO ClassLevel(level, guestID, classID) VALUES (1, 1, 3);
INSERT INTO ClassLevel(level, guestID, classID) VALUES (14, 5, 3);
INSERT INTO ClassLevel(level, guestID, classID) VALUES (18, 2, 3);

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

INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (1, 1, 2, '2019-03-10', 100.00);
INSERT INTO RoomStay(guestID, roomID, saleID, dateStayedIn, rate) VALUES (2, 2, 3, '2019-03-09', 150.00);


/* Alter table */

ALTER TABLE Tavern ADD numTables INT;
ALTER TABLE Owners ADD numTavernsOwned INT;
ALTER TABLE ClassLevel ADD FOREIGN KEY (classID) REFERENCES Class(classID);


/* Queries for homework assignment 3 */


/* 2. Returns guess with bithday before 2000 */
SELECT name, birthday FROM Guests
WHERE datepart(year, birthday) < 2000;  

/* 3. Return rooms that cost more than 100 gold a night */
SELECT tavernID, Room.roomID, RoomStay.rate FROM Room
JOIN RoomStay ON Room.roomID = RoomStay.roomID
WHERE RoomStay.rate > 100;

/* 4. Returns unique guest names */
SELECT DISTINCT name FROM Guests;

/* 5. Returns all guests ordered by name */
SELECT name FROM Guests
ORDER BY name DESC;

/* 6. Returns top 10 highest price sales */
SELECT TOP(10) saleID, guestName, cost FROM Sales
ORDER BY cost DESC;

/* 7. Returns all lookup table names */
SELECT name FROM Tavern UNION
SELECT name FROM Users UNION
SELECT name FROM Owners UNION
SELECT name FROM Locations UNION
SELECT name FROM Supplies UNION
SELECT name FROM Services UNION
SELECT name FROM Guests UNION
SELECT name FROM Class;


/* 8. Returns guest classes with levels and level grouping */
SELECT Guests.name AS name, Class.name AS Class, ClassLevel.level AS Level, 'Lvl 1-10' AS Grouping FROM ClassLevel
JOIN Guests on ClassLevel.guestID = Guests.guestID
JOIN Class on Class.classID = ClassLevel.classID 
WHERE level BETWEEN 1 AND 10
UNION
SELECT Guests.name AS name, Class.name AS Class, ClassLevel.level AS Level, 'Lvl 11-20' AS Grouping FROM ClassLevel
JOIN Guests on ClassLevel.guestID = Guests.guestID
JOIN Class on Class.classID = ClassLevel.classID 
WHERE level BETWEEN 11 AND 20
UNION
SELECT Guests.name AS name, Class.name AS Class, ClassLevel.level AS Level, 'Lvl 21-30' AS Grouping FROM ClassLevel
JOIN Guests on ClassLevel.guestID = Guests.guestID
JOIN Class on Class.classID = ClassLevel.classID 
WHERE level BETWEEN 21 AND 30
ORDER BY ClassLevel.level ASC;

/* 9. Insert commands */
/* Was not exactly sure what was being asked by this question and am unsure how to start */
