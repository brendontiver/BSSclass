/* 
* Author: Brendon Tiver
*
* Creates all tavern database tables and populates them
*
*/


/* Create tables */
DROP TABLE IF EXISTS Tavern;
CREATE TABLE Tavern(
	tavernID INT,
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


DROP TABLE IF EXISTS Users;
CREATE TABLE Users(
	tavernID INT,
	name TEXT,
	roleID INT
);

INSERT INTO Users(tavernID, name, roleID) VALUES (1, 'Tom', 1);
INSERT INTO Users(tavernID, name, roleID) VALUES (2, 'Jon', 1);
INSERT INTO Users(tavernID, name, roleID) VALUES (3, 'Guy', 2);
INSERT INTO Users(tavernID, name, roleID) VALUES (3, 'Sam', 3);
INSERT INTO Users(tavernID, name, roleID) VALUES (5, 'Liz', 2);


DROP TABLE IF EXISTS Roles;
CREATE TABLE Roles(
	roleID INT,
	description VARCHAR(255)
);

INSERT INTO Roles(description) VAlUES('Bartender');
INSERT INTO Roles(description) VAlUES('Waiter');
INSERT INTO Roles(description) VAlUES('Chef');
INSERT INTO Roles(description) VAlUES('Cleaner');
INSERT INTO Roles(description) VAlUES('Host');


DROP TABLE IF EXISTS Owners;
CREATE TABLE Owners(
	ownerID INT,
	name TEXT,
	ownerInformation VARCHAR(255)
);
INSERT INTO Owners(name, ownerInformation) VALUES ('Paddy', 'Very, very rich');
INSERT INTO Owners(name, ownerInformation) VALUES ('Danny', 'A great guy');
INSERT INTO Owners(name, ownerInformation) VALUES ('Bobby', 'A good friend');
INSERT INTO Owners(name, ownerInformation) VALUES ('Jerry', 'Kind of strange');
INSERT INTO Owners(name, ownerInformation) VALUES ('Harry', 'Unpredictable');


DROP TABLE IF EXISTS Rats;
CREATE TABLE Rats(
	tavernID INT,
	name TEXT
);

INSERT INTO Rats(name) VALUES ('Squeaks');
INSERT INTO Rats(name) VALUES ('Nibbler');
INSERT INTO Rats(name) VALUES ('Chomper');
INSERT INTO Rats(name) VALUES ('Tiny');
INSERT INTO Rats(name) VALUES ('Scamper');

DROP TABLE IF EXISTS Locations;
CREATE TABLE Locations(
	locationID INT,
	name VARCHAR(255)
);

INSERT INTO Locations (name) VALUES ('Pubsville');
INSERT INTO Locations (name) VALUES ('Downtown');
INSERT INTO Locations (name) VALUES ('Uptown');
INSERT INTO Locations (name) VALUES ('Oldesville');
INSERT INTO Locations (name) VALUES ('Marketplace');


DROP TABLE IF EXISTS Supplies;
CREATE TABLE Supplies(
	supplyID INT,
	name TEXT,
	unit VARCHAR(32)
);

INSERT INTO Supplies (name, unit) VALUES ('Ale', 'Barrel');
INSERT INTO Supplies (name, unit) VALUES ('Rat poison', 'Bottle');
INSERT INTO Supplies (name, unit) VALUES ('Cheese', 'Wheel');
INSERT INTO Supplies (name, unit) VALUES ('Candle', 'Stick');
INSERT INTO Supplies (name, unit) VALUES ('Meat', 'Pound');



DROP TABLE IF EXISTS Inventory;
CREATE TABLE Inventory(
	inventoryID INT,
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


DROP TABLE IF EXISTS SuppliesReceived;
CREATE TABLE SuppliesReceived(
	supplyID INT,
	tavernID INT,
	cost DECIMAL,
	amountReceived INT,
	dateReceived DATETIME
);

INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(1, 3, 50.0, 5, GetDate());
INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(3, 4, 20.0, 2, GetDate());
INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(2, 3, 40.0, 3, GetDate());
INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(4, 5, 35.0, 3, GetDate());
INSERT INTO SuppliesReceived(supplyID, tavernID, cost, amountReceived, dateReceived) VALUES(2, 1, 15.0, 1, GetDate());



DROP TABLE IF EXISTS Services;
CREATE TABLE Services(
	serviceID INT,
	name TEXT,
	statusID INT
);

INSERT INTO Services(name, statusID) VALUES ('Blade sharpening', 1);
INSERT INTO Services(name, statusID) VALUES ('Boarding', 1);
INSERT INTO Services(name, statusID) VALUES ('Horse brushing', 1);
INSERT INTO Services(name, statusID) VALUES ('Massage', 0);
INSERT INTO Services(name, statusID) VALUES ('Boot shining', 1);


DROP TABLE IF EXISTS ServiceStatus;
CREATE TABLE ServiceStatus(
	statusID INT,
	description VARCHAR(255)
);

INSERT INTO ServiceStatus(description) VALUES ('Available');
INSERT INTO ServiceStatus(description) VALUES ('Unavailable');

DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales(
	saleID INT,
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




