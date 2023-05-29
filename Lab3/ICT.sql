/* Assignment 1 Solutions */

-- Drop database if exist
DROP DATABASE IF EXISTS ICTTutorial;
  
-- Create Database 
CREATE DATABASE ICTTutorial; 

-- Use database
USE ICTTutorial;

CREATE TABLE Student(
	StudentID VARCHAR(8) NOT NULL,
	FirstName VARCHAR(50) ,
	LastName VARCHAR(50),
	Address VARCHAR(100),
	Birthdate DATE,
	EMail VARCHAR(50),
	Phone VARCHAR(20),
	UserID VARCHAR(50),
	Password VARCHAR(50),
	PRIMARY KEY (StudentID)
);

CREATE TABLE Instructor(
	InstructorID VARCHAR(5)NOT NULL,
	FirstName VARCHAR(50) ,
	LastName VARCHAR(50),
	Address VARCHAR(100),
	Birthdate DATE,
	EMail VARCHAR(50),
	Phone VARCHAR(50),
	UserID VARCHAR(50),
	Password VARCHAR(50),
	PRIMARY KEY (InstructorID)
);

CREATE TABLE Course(
	CourseID VARCHAR(5) NOT NULL,
	InstructorID VARCHAR(5),
	CourseName VARCHAR(50),
	CourseAmount DECIMAL(13, 4),
	PRIMARY KEY (CourseID),
	FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

CREATE TABLE EnrollCourse (
    StudentID VARCHAR(8),
    CourseID VARCHAR(5),
    FOREIGN KEY (StudentID) REFERENCES Student (StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);


CREATE TABLE Transaction(
	TransactionID VARCHAR(5) NOT NULL PRIMARY KEY,
	Amount DECIMAL(13, 4)
);

CREATE TABLE Payment(
	StudentID VARCHAR(8),
	TransactionID VARCHAR(5),
	PRIMARY KEY (StudentID),
	FOREIGN KEY (TransactionID) REFERENCES Transaction(TransactionID),
	FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);
 

CREATE TABLE ExamScore (
    ExamID VARCHAR(5) NOT NULL,
    Score DOUBLE,
    PRIMARY KEY (ExamID)
);

CREATE TABLE PracticeExam (
    StudentID VARCHAR(8),
    ExamID VARCHAR(5),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ExamID) REFERENCES ExamScore (ExamID)
);

CREATE TABLE ELearningVDO (
    CourseID VARCHAR(5),
    Lesson VARCHAR(50),
    Details VARCHAR(50),
    FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);

CREATE TABLE BookStocking(
	BookID VARCHAR(5) NOT NULL,
	CourseID VARCHAR(5),
	BookName VARCHAR(50),
	Author VARCHAR(50),
	Remaining INT, 
	Price DECIMAL(13, 4),
	PRIMARY KEY (BookID),
	FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Insert data
USE ICTTutorial;

INSERT INTO student VALUES('u0001','Sukit','Lertsuk','154/2 Soi Rang-nam', '1997-08-04','sukit@hotmail.com','mobile:0932133484','sukit.ler','sk9dkc');
INSERT INTO student VALUES('u0002','Chatree','Meekerd','254 Salaya', '2001-01-14','chatree@gmail.com','mobile:0852354821','chatree','28dc8ds');
INSERT INTO student VALUES('u0003','Chujai','Sae-Tung','124/225 Klongluang', '1999-06-21','chujai@gmail.com','mobile:0825212410','chujai','15d8ds5');
  

INSERT INTO instructor VALUES('i1001','Nikorn','Sawanglap','1125 Bangkae', '1975-08-29','nikorn@hotmail.com','mobile:0932322343;office:023932323','nikorn','285d8d2');
INSERT INTO instructor VALUES('i1002','Nongkran','Poonpol','45/4523 Lamlookka', '1971-02-19','nongkran@hotmail.com','mobile:0852314043;office:021872421','nongkran','45d28ds');
INSERT INTO instructor VALUES('i1003','Chokchai','Sakooldee','515 Moo2 Bangkontee', '1984-09-09','chokchai@hotmail.com','mobile:0959323353;office:023251582','chokchai','d3dd8da2');
  
INSERT INTO course VALUES('ICT01','i1001','Introduction to Database', 50000);
INSERT INTO course VALUES('ICT02','i1002','Expert System', 75000);
INSERT INTO course VALUES('ICT03','i1003','Computational Thinking', 35000);
 
INSERT INTO elearningvdo VALUES('ICT01','Background','All about database');
INSERT INTO elearningvdo VALUES('ICT01','Business Environment','Introduction to current business environment');
INSERT INTO elearningvdo VALUES('ICT02','Artificial Intelligence in Real world','Introduction to AI in real world');

INSERT INTO enrollcourse VALUES ('u0001','ICT01');
INSERT INTO enrollcourse VALUES ('u0001','ICT02');
INSERT INTO enrollcourse VALUES ('u0002','ICT01');
INSERT INTO enrollcourse VALUES ('u0003','ICT02');

INSERT INTO examscore VALUES ('es001',85);
INSERT INTO examscore VALUES ('es002',95);
INSERT INTO examscore VALUES ('es003',65);
INSERT INTO examscore VALUES ('es004',85);

INSERT INTO practiceexam VALUES('u0001','es001');
INSERT INTO practiceexam VALUES('u0001','es002');
INSERT INTO practiceexam VALUES('u0002','es003');
INSERT INTO practiceexam VALUES('u0003','es003');

INSERT INTO transaction VALUES ('t0001',50000);
INSERT INTO transaction VALUES ('t0002',65000);
INSERT INTO transaction VALUES ('t0003',80000);


INSERT INTO payment VALUES ('u0001','t0001');
INSERT INTO payment VALUES ('u0002','t0002');
INSERT INTO payment VALUES ('u0003','t0003');
 
 
INSERT INTO bookstocking VALUES ('B001','ICT01','DBMS in action','M.J.Fox',39,1240);
INSERT INTO bookstocking VALUES ('B002','ICT01','Database Design','Peter Gilbert',78, 1850);
INSERT INTO bookstocking VALUES ('B003','ICT02','Expert System Design','J.Joe',64, 950); 
select * from student;
select * from Payment;
select * from examscore;
select * from practiceexam;
select * from course;