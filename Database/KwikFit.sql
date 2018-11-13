DROP TABLE IF EXISTS Jobs;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Orders;

CREATE TABLE IF NOT EXISTS `Customers` (
  `firstName`	TEXT NOT NULL,
  `surname`	TEXT NOT NULL,
  `ID`		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `termLocation`	TEXT NOT NULL,
  'homeLocation'  TEXT NOT NULL
);


INSERT INTO `Customers`(`firstName`,`surname`, 'termLocation', 'homeLocation' ) VALUES ('Ian','Cooper','Cardiff',  'Devon');
INSERT INTO `Customers`(`firstName`,`surname`, 'termLocation', 'homeLocation' ) VALUES ('Chris','Gwilliams','Cardiff',  'asdfs');
INSERT INTO `Customers`(`firstName`,`surname`, 'termLocation', 'homeLocation' ) VALUES ('Dave','Shepard','Forest',  'fghdf');
INSERT INTO `Customers`(`firstName`,`surname`, 'termLocation', 'homeLocation' ) VALUES ('Wendy','Ivins','sdfsdf', 'sdfsdf');

CREATE TABLE IF NOT EXISTS `Jobs` (
  `name`	TEXT NOT NULL,
  `ID`		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `description`	Text
);

INSERT INTO Jobs ('name','description') VALUES ('Oil Change','Change the Oil');
INSERT INTO Jobs ('name','description') VALUES ('MOT','Do the MOT');
INSERT INTO Jobs ('name','description') VALUES ('Oil and Filter ','Charge More');


CREATE TABLE IF NOT EXISTS `Orders` (
  `orderID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `jobID`		INTEGER NOT NULL,
  `customerID`	INTEGER NOT NULl
);

INSERT INTO Orders ('jobID','customerID') VALUES (1,3);
INSERT INTO Orders ('jobID','customerID') VALUES (1,2);
INSERT INTO Orders ('jobID','customerID') VALUES (3,3);
INSERT INTO Orders ('jobID','customerID') VALUES (2,1);

SELECT * FROM Customers WHERE ID=1;
SELECT ID FROM Jobs WHERE Jobs.name = 'Oil Change';
SELECT * FROM Orders WHERE Orders.jobID = (SELECT ID FROM Jobs WHERE Jobs.name = 'Oil Change');
SELECT * FROM Orders Join Jobs ON Orders.jobID=Jobs.ID WHERE Jobs.name = 'Oil Change';
SELECT Customers.firstName FROM Orders Join
            Jobs ON Orders.jobID=Jobs.ID join
            Customers ON Orders.customerID=Customers.ID
            WHERE Jobs.name = 'Oil Change';
