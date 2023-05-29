-- ﻿-- Waris Damkham, 6388014, Track SE
-- -- This is an example of the answer file that you have to submit

-- Q1 –
CREATE TABLE LogFileAudit (
    LogID varchar(255) primary key,
    Log_Action varchar(255) not null,
    tableName varchar(255) not null
);

-- Q2.1 -_
DELIMITER \\
CREATE TRIGGER addLogINS
AFTER INSERT
ON person FOR EACH ROW
BEGIN
  DECLARE newLogID INT;
  
  SELECT MAX(LogID) + 1 INTO newLogID FROM LogFileAudit;
  
  INSERT INTO LogFileAudit (LogID, Log_Action, TableName)
  VALUES (newLogID, 'INSERT', 'person');
END; \\
DELIMITER ;

INSERT INTO person (PID, Full_name, Budget, Proj_id)
VALUES (011, 'AAA', 20000, 1);

-- Q2.2 --

