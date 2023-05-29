-- CREATE DATABASE TestTrigger;
CREATE TABLE person (
	pid			varchar(4) PRIMARY KEY,
	full_name 	varchar(40)  not null,
	budget 		decimal(18,2)  not null,
 	proj_id 	varchar(4)
);
create Table project(
	proj_id			varchar(4) PRIMARY KEY,
	proj_name		varchar(40) not null,
	total_budget	decimal(18,2) not null
);
INSERT INTO person (pid, full_name, budget, proj_id) VALUES
('001','Peter Copper', 20000, 1),
('002','Sarah MaCorr', 10000, 1),
('003','Henry Pipe', 25000, 1),
('004','Wilman Kala', 30000, 2),
('005','Matti Karttunen', 5000, 2),
('006','Luke Miller', 21000, 3),
('007','Margaret Johnson', 22000, 3),
('008','Bruce Randall', 32000, 3),
('009','Hina Siddiqui', 23000, 3),
('010','Joanne Mills', 25000, 4);

INSERT INTO project (proj_id, proj_name, total_budget) VALUES
('1','Project 1', 55000),
('2','Project 2', 35000),
('3','Project 3', 98000),
('4','Project 4', 25000);