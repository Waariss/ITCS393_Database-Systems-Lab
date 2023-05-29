/* Initial SQL Script for Lab 02
     Student ID _____________________________________
     Student Name ___________________________________
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
