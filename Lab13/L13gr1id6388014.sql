use TestTrigger;
select * from person;
select * from project;
-- Q1
-- create LogFileAudit table
CREATE TABLE LogFileAudit (
  LogID VARCHAR(225) PRIMARY KEY,
  Action VARCHAR(225) NOT NULL,
  TableName VARCHAR(225)
);
-- Create a trigger addLogINS to insert a log data into LogFileAudit 
-- after inserting data into the person table. 
-- 1. The LogID value is the max value of LogID + 1 
-- 2. The Action value is ‘INSERT’, 
-- 3. The TableName value is ‘person’
DELIMITER \\
CREATE TRIGGER addLogINS
AFTER INSERT ON person
FOR EACH ROW
BEGIN
  INSERT INTO LogFileAudit (LogID, Action, TableName)
  SELECT IFNULL(MAX(LogID)+1, 1), 'INSERT', 'person' 
  -- if logid is null == 1
  FROM LogFileAudit;
END; \\
DELIMITER ;

insert into person (pid, full_name, budget, proj_id)
values ('011','John Doe',1000.00,'1');
select * from LogFileAudit;

-- Create a trigger addLogDEL to insert a log data into LogFileAudit after deleting data from the project table.
-- The LogID value is the max value of LogID + 1
-- The Action value is ‘DELETED’, and
-- The TableName value is ‘project’
DELIMITER \\
CREATE TRIGGER addLogDEL
AFTER DELETE ON project
FOR EACH ROW
BEGIN
  INSERT INTO LogFileAudit (LogID, Action, TableName)
  SELECT IFNULL(MAX(LogID)+1, 1), 'DELETED', 'project'
  FROM LogFileAudit;
END;\\
DELIMITER ;

Delete from project where proj_id = '1';
select * from LogFileAudit;

-- Create a trigger “cascade_insert” to insert a new record into the project table 
-- after inserting a new person into the person table, 
-- if the project id does not exist yet in the project table.
-- 1. The new project record, will have a default project_name as(Unknown) 
-- and the total_budget is equal to the person’s budget
DELIMITER \\
CREATE TRIGGER cascade_insert
AFTER INSERT ON person
FOR EACH ROW
BEGIN
  DECLARE total_budget DECIMAL(10, 2);
  SET total_budget = NEW.budget;
  IF NOT EXISTS (
    SELECT 1 FROM project WHERE proj_id = NEW.pid
  ) THEN
    INSERT INTO project (proj_id, proj_name, total_budget)
    VALUES (NEW.proj_id, "Unknow", total_budget);
  END IF;
END;\\
DELIMITER ;

INSERT INTO person ( pid , full_name , budget, proj_id ) VALUES ('012','Harry Potter', 15000.00 , 5);
select * from LogFileAudit;
select * from person;
select * from project;

