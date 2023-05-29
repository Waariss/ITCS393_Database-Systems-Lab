CREATE DATABASE IF NOT EXISTS PremierProducts;

USE PremierProducts;

DROP TABLE IF EXISTS OrderLine;
DROP TABLE IF EXISTS Part;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Rep;

CREATE TABLE Rep (
  RepNum INT PRIMARY KEY,
  LastName VARCHAR(100), 
  FirstName VARCHAR(50),
  Street VARCHAR(255),
  City VARCHAR(100),
  State VARCHAR(30),
  Zip VARCHAR(30),
  Commision DECIMAL(10,2),
  Rate FLOAT
);

CREATE TABLE Customer (
  CustomerNum INT PRIMARY KEY,
  CustomerName VARCHAR(255),
  Street VARCHAR(255),
  City VARCHAR(100),
  State VARCHAR(30),
  Zip VARCHAR(30),
  Balance DECIMAL(10,2),
  CreditLine DECIMAL(10,2),
  RepNum INT,
  FOREIGN KEY (RepNum) REFERENCES Rep(RepNum)
);

CREATE TABLE Orders (
  OrderNum INT PRIMARY KEY,
  OrderDate DATETIME,
  CustomerNum INT,
  FOREIGN KEY (CustomerNum) REFERENCES Customer(CustomerNum)
);

CREATE TABLE Part (
  PartNum VARCHAR(10) PRIMARY KEY,
  Description VARCHAR(255),
  OnHand INT,
  Class VARCHAR(10),
  Warehouse SMALLINT,
  Price DECIMAL(10,2)
);

CREATE TABLE OrderLine (
  OrderNum INT,
  PartNum VARCHAR(10),	
  NumOrdered INT,
  QuotedPrice DECIMAL(10,2),
  FOREIGN KEY (OrderNum) REFERENCES Orders(OrderNum),
  FOREIGN KEY (PartNum) REFERENCES Part(PartNum)
);

CREATE TABLE CurrentOrders(
  CustomerName VARCHAR(50),
  OrderNum INT,
  PartNum VARCHAR(10),
  Description VARCHAR(255),
  NumOrdered INT,
  QuotedPrice DECIMAL(10,2),
  Warehouse SMALLINT,
  RepNum INT, 
  FOREIGN KEY (RepNum) REFERENCES Rep(RepNum),
  FOREIGN KEY (OrderNum) REFERENCES Orders(OrderNum),
  FOREIGN KEY (PartNum) REFERENCES Part(PartNum)
);
