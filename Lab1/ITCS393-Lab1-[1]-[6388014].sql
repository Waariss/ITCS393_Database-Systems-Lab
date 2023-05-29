CREATE DATABASE IF NOT EXISTS MyDB; -- Create Database MyDB
create table IF NOT EXISTS Student( -- Create ‘Student’ table
-- StudentID (int), FirstName, LastName, NickName, Email,PhoneNumber, Gender, BirthDate (Date)
	StudentID int Not null,
	Firstname varchar(255),
	Lastname varchar(255),
    Nickname varchar(255),
    Email varchar(255),
    Phonenumber varchar(10),
    Gender char(1),
    Birthdate date not null,
    constraint PK_Student PRIMARY KEY (StudentID,Nickname) -- Assign StudentID and NickName to be the PK
);
insert into Student (StudentID, Firstname, Lastname, Nickname, Email, PhoneNumber, Gender, BirthDate) values -- Insert your data into ‘Student’ table
-- Gather your friends’ data
(6388014, 'Waris', 'Damkham', 'M', 'waris.dam@student.mahidol.ac.th', '0899999999', 'M', '2000-11-12'),
(6388022, 'PATTANAN', 'KORKIATTRAKOOL', 'Tai' , 'PATTANAN.kor@student.mahidol.ac.th','0899999999','F','2000-03-22'),
(6388016, 'THANAWATH', 'HUAYHONGTHONG', 'OHM' , 'THANAWATH.hua@student.mahidol.ac.th','0899999999','M','2005-05-15'),
(6388041, 'Chatkawin', 'Phongpawarit', 'Heart', 'chatkawin.pho@student.mahidol.ac.th', '0899999999', 'M', '2002-08-18'),
(6388087, 'Chanisara', 'Kotrachai', 'Fifa', 'Chanisara.kot@student.mahidol.ac.th', '0899999999', 'F', '2001-10-24');
SELECT * FROM Student; -- see the table