CREATE DATABASE Transactions;

USE Transactions;
CREATE TABLE accounts ( 
  acc_id INT,
  acc_name varchar(255),
  acc_balance DECIMAL(10,2),
  PRIMARY KEY(acc_id) 
) ENGINE InnoDB; 

INSERT INTO accounts (acc_id, acc_name, acc_balance)
VALUES (1, 'John Smith', 1000.00),
       (2, 'Jane Doe', 5000.00),
       (3, 'Bob Johnson', 2500.00),
       (4, 'Sarah Lee', 15000.00),
       (5, 'Alex Kim', 7500.00);


