-- Q1 – Create table named “LogFileAudit”
CREATE TABLE LogFileAudit (
    LogID varchar(255) primary key,
    Log_Action varchar(255) not null,
    tableName varchar(255) not null
);
-- Q2.1 --
-- Create a trigger addLogINS to insert a log data into LogFileAudit 
-- after inserting data into the person table. (0.5 points)
-- 1. The LogID value is the max value of LogID + 1 
-- 2. The Action value is ‘INSERT’, and
-- 3. The TableName value is ‘person’ 
DELIMITER \\
CREATE TRIGGER addLogINS
AFTER INSERT
ON person FOR EACH ROW
BEGIN
  DECLARE newLogID INT;
  
  SELECT COALESCE(MAX(LogID) + 1, 1) INTO newLogID FROM LogFileAudit;
  
  INSERT INTO LogFileAudit (LogID, Log_Action, TableName)
  VALUES (newLogID, 'INSERT', 'person');
END; \\
DELIMITER ;
-- Insert data
INSERT INTO person (PID, Full_name, Budget, Proj_id)
VALUES (011, 'AAA', 20000, 1);
select * from LogFileAudit;
-- Q2.2 --
-- Create a trigger addLogDEL to insert a log data into LogFileAudit 
-- after deleting data from the project table. (0.5 points)
-- 1. The LogID value is the max value of LogID + 1 
-- 2. The Action value is ‘DELETE’, and
-- 3. The TableName value is ‘projects’
DELIMITER \\
CREATE TRIGGER addLogDEL
AFTER DELETE
ON project FOR EACH ROW
BEGIN
  DECLARE newLogID INT;
  
  SELECT COALESCE(MAX(LogID) + 1, 1) INTO newLogID FROM LogFileAudit;
  
  INSERT INTO LogFileAudit (LogID, Log_Action, TableName)
  VALUES (newLogID, 'DELETE', 'projects');
END; \\
DELIMITER ;
-- need to set before delete
SET SQL_SAFE_UPDATES = 0;

DELETE FROM project WHERE proj_id = 4;

SET SQL_SAFE_UPDATES = 1;

select * from LogFileAudit;
