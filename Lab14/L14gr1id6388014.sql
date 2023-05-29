-- Waris Damkham 6388014
-- Q0: Create BankAccounttable using the following statements
CREATE TABLE BankAccount(
	AccountNum INT NOT NULL PRIMARY KEY,
	ACC_ID INT NOT NULL,
	AccountBalance DECIMAL(10,2),
	FOREIGN KEY (ACC_ID) REFERENCES accounts(acc_id)
);
-- Q1: Create a store procedure 'AddAccounts’ that insert 3 records as follow (no need to pass parameters). 
-- If the records can be inserted, commit the transaction. Otherwise, rollback the transaction.
-- Run the transaction in Q1, select all data in BankAccount, and explain the results.
-- Run the transaction in Q1 again, select all data, and explain the results.
USE Transactions;
DELIMITER //
CREATE PROCEDURE AddAccounts()
BEGIN    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    INSERT INTO BankAccount (AccountNum, ACC_ID, AccountBalance) VALUES (117, 1, 1000.00);
    INSERT INTO BankAccount (AccountNum, ACC_ID, AccountBalance) VALUES (118, 2, 2000.00);
    INSERT INTO BankAccount (AccountNum, ACC_ID, AccountBalance) VALUES (119, 3, 500.00);
    COMMIT;
END //
DELIMITER ;
CALL AddAccounts();
SELECT * FROM BankAccount;

-- Explanation of results:
-- - After running the stored procedure for the first time, 
-- the 3 records will be inserted into the BankAccount table, 
-- and you'll see these rows in the SELECT query result.
-- If you run the stored procedure again, since the AccountNum is the primary key, 
-- you will get a duplicate key error for the primary key, 
-- and the transaction will be rolled back. As a result, 
-- no new records will be inserted, and the SELECT query will show the same 3 records as before.

-- Q2: Create 'TransferMoney' transaction to transfer money 
-- from one account to another account using the variables declared 
-- below ---> to transfer money ‘550’ from account number 117 to account number 118
DELIMITER //
CREATE PROCEDURE TransferMoney()
BEGIN 
    -- Declare variables
    SET @from := 117;
    SET @to := 118;
    SET @amount := 550;
    START TRANSACTION;
    -- Get the current balance of the 'from' account
    SELECT AccountBalance INTO @from_balance
    FROM BankAccount
    WHERE AccountNum = @from;
    -- Get the current balance of the 'to' account
    SELECT AccountBalance INTO @to_balance
    FROM BankAccount
    WHERE AccountNum = @to;
    -- Check if there's enough balance in the 'from' account to transfer the amount
    IF @from_balance >= @amount THEN
        -- Deduct the transfer amount from the 'from' account
        UPDATE BankAccount
        SET AccountBalance = @from_balance - @amount
        WHERE AccountNum = @from;
        -- Add the transfer amount to the 'to' account
        UPDATE BankAccount
        SET AccountBalance = @to_balance + @amount
        WHERE AccountNum = @to;
        -- Print a success message and commit the transaction
        SELECT 'Successfully transferred.' AS Message;
        COMMIT;
    ELSE
        -- Print an error message and rollback the transaction
        SELECT 'Insufficient balance.' AS Message;
        ROLLBACK;
    END IF;
END //
DELIMITER ;

CALL TransferMoney();

SELECT * FROM BankAccount;
-- Explanation of results:
-- If there's enough balance in the 'from' account to transfer the amount, 
-- the transaction will deduct the transfer amount from the 'from' account 
-- and add it to the 'to' account. It will then print a success message 
-- and commit the transaction. As a result, you'll see the updated 
-- account balances of both accounts in the SELECT query result.
-- If there's not enough balance in the 'from' account to transfer the amount, 
-- the transaction will print an error message and rollback the transaction. 
-- As a result, there will be no changes to the 
-- account balances of both accounts in the SELECT query result.