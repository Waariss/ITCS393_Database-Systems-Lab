/* Initial SQL Script for Lab 02
     Student ID 6388014
     Student Name Waris Damkham
*/


-- DROP DATABASE if exists
DROP DATABASE IF EXISTS myFriends;
  
-- Create Database 
CREATE Database myFriends; 
Use myFriends;

-- Create Tables
CREATE TABLE myStudents(
	StudentID INT NOT NULL,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50)
);

CREATE TABLE myFriends(
	FriendID INT NOT NULL,
	NickName NVARCHAR(20) NOT NULL,
	FirstName NVARCHAR(50) ,
	LastName NVARCHAR(50),
	PhoneNo NCHAR(13)
);
 
CREATE TABLE myProjects(
	ProjNo INT NOT NULL,
	FriendMembers INT NOT NULL,
	ProjectName NVARCHAR(200),
	DueDate date
);

/* YOUR SQL Commands can start here!! 
   Instructions:
	1. Assign "FriendID" to be FK for myFriends table, which links to myStudents table.
	2. Assign "FriendMembers" to be FK for myProjects table, which links to myStudent table.
	3. Assign "ProjNo and FriendMembers" to be COMPOSITE PKs for myProjects table.
     	4. Assign "studentID" to be PK for myStudents table.
	5. Assign "FriendID and NickName" to be COMPOSITE PKs for myFriends table.
*/
ALTER Table myStudents ADD constraint PK_StudentID primary key (StudentID);

ALTER Table myFriends ADD constraint FK_StudentID foreign key (FriendID) references myStudents(StudentID);

ALTEr Table myProjects ADD constraint Fk_FriendMembers foreign key (FriendMembers) references myStudents(StudentID);

alter table myProjects ADD constraint PK_ProjNo_FriendMembers primary key (ProjNo, FriendMembers);

alter table myFriends ADD constraint PK_FriendID_NickName primary key (FriendID, NickName);

