/* 
* Author: Brendon Tiver
*
* Creates all tavern database tables and populates them
*
*/

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
	name TEXT,
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
	name TEXT,
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
	name TEXT,
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
	name TEXT
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
	name TEXT,
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
	name TEXT,
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
	guestName TEXT,
	datePurchased DATETIME,
	amountPurchased INT,
	tavernID INT
);

INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID) VALUES (1, 'Jacob', GetDate(), 1, 1);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID) VALUES (2, 'Kenneth', GetDate(), 1, 1);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID) VALUES (3, 'William', GetDate(), 1, 1);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID) VALUES (1, 'Travis', GetDate(), 1, 1);
INSERT INTO Sales(service, guestName, datePurchased, amountPurchased, tavernID) VALUES (5, 'Michael', GetDate(), 1, 1);


CREATE TABLE Guests(
	guestID INT IDENTITY(1,1) PRIMARY KEY,
	name TEXT,
	notes VARCHAR(255),
	birthday DATETIME,
	cakeday DATETIME,
	statusID INT,
	classID INT
);

INSERT INTO Guests(name, notes, birthday, cakeday, statusID, classID) VALUES ('Joe', 'Angry drunk', 5555-06-02, 5555-06-03, 1, 4);

CREATE TABLE GuestStatus(
	statusID INT IDENTITY(1,1) PRIMARY KEY,
	guestID INT,
	name TEXT
);

INSERT INTO GuestStatus(name) VALUES ('Passed out');

CREATE TABLE Class(
	classID INT IDENTITY(1,1) PRIMARY KEY,
	name TEXT
);

INSERT INTO Class(name) VALUES ('Wizard');
INSERT INTO Class(name) VALUES ('Warrior');

CREATE TABLE ClassLevel(
	classLevelID INT IDENTITY(1,1) PRIMARY KEY,
	level INT,
	guestID INT FOREIGN KEY REFERENCES Guests(guestID),
	classID INT
);

INSERT INTO ClassLevel(level, guestID, classID) VALUES (5, 1, 2);

/* Alter table */

ALTER TABLE Tavern ADD numTables INT;
ALTER TABLE Owners ADD numTavernsOwned INT;
ALTER TABLE ClassLevel ADD FOREIGN KEY (classID) REFERENCES Class(classID);






