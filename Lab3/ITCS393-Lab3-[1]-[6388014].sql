-- Waris Damkham 6388014 
-- Use Database
use ICTTutorial;
-- Q1 List students’ ID, first name, last name, and Age of every students who use “Hotmail” internet account --
SELECT	StudentID, Firstname, Lastname, YEAR(CURRENT_TIMESTAMP) - YEAR(Student.Birthdate) AS Age
FROM Student WHERE EMail like '%hotmail%';
-- Q2 List students’ full name and Age of all students  whose age is older than 20 years old.
Select concat (FirstName,' ',Lastname) as 'Fullname', YEAR(CURRENT_TIMESTAMP) - YEAR(Student.Birthdate) AS Age 
From Student Where YEAR(CURRENT_TIMESTAMP) - YEAR(Student.Birthdate) > 20;
-- Q3 List students’ full name, email address and phone number who did not make the payment yet.
Select concat (M.FirstName,' ',M.Lastname) as 'Fullname',M.EMail,M.Phone
From student M left join Payment p on M.StudentID = p.StudentID where M.StudentID = p.StudentID is null;
-- Q4 List students’ ID, ExamID, full name, and examination score for all students.
Select M.StudentID,p.ExamID,concat (M.FirstName,' ',M.Lastname) as 'Fullname',e.Score
from Student M inner join PracticeExam p on M.StudentID = p.StudentID inner join ExamScore e on p.ExamID = e.ExamID;
-- Q5 List students’ full name, and examination score who can earn the highest score.
Select concat (M.FirstName,' ',M.Lastname) as 'Fullname',e.Score
from Student M inner join PracticeExam p on M.StudentID = p.StudentID inner join ExamScore e on p.ExamID = e.ExamID WHERE e.Score = (SELECT MAX(Score) FROM ExamScore);
-- Q6 Find the instructors' full name who teach for the most expensive course.
SELECT i.FirstName, i.LastName 
FROM Instructor i JOIN Course c ON i.InstructorID = c.InstructorID WHERE c.CourseAmount = (SELECT MAX(CourseAmount) FROM Course);
-- Q7 Find the top 5 students' name who enrolled for the course that are most expensive.
Select concat (M.FirstName,' ',M.Lastname) as 'Fullname'
from Student M join EnrollCourse e ON M.StudentID = e.StudentID join Course c ON e.courseID = c.courseID 
WHERE c.CourseAmount = (SELECT MAX(CourseAmount) FROM Course) ORDER BY c.CourseAmount DESC LIMIT 5;
-- Q8 Find the courses that are not recorded the ELearning VDO yet.
SELECT c.CourseName FROM Course c
LEFT JOIN ELearningVDO e ON c.CourseID = e.CourseID WHERE e.CourseID IS NULL;