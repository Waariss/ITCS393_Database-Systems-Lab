-- Waris Damkham 6388014
use MovieTesting;
-- q1: Show all title of movies and runtime in the 
-- database that have a runtime of over 2 hours?
select title, runtime 
from movies
where runtime > '02:00:00';
-- q2: Write a query to show name and id of the 
-- actor who played the character "Jenny Curran" in the movie "Forrest Gump"?
select a.actor_id, a.name
from actors a 
inner join movie_cast m on a.actor_id = m.actor_id
inner join movies c on m.movie_id = c.movie_id
where m.character_name = 'Jenny Curran' and c.title = 'Forrest Gump';
-- q3: Write a sqlcommand to show movie_id, title, 
-- and release_dateof all movies that release before 2009
select movie_id, title, release_date 
from movies
where release_date < '2009-01-01';
-- q4: Write a sqlcommand to calculate average age of all actors in the database.
SELECT ROUND(AVG(YEAR(CURRENT_DATE) - YEAR(birthdate))) AS avg_age
FROM actors;
-- q5: Write a sqlcommand to find average runtime of all movies in the database.
SELECT TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(runtime))), '%H:%i:%s') AS avg_runtime
FROM movies;
-- q6: Write a query to create table Q1 with the following 
-- fields userIdchar(36), firstNamenvarchar(20), lastNamenvarchar(20).
CREATE TABLE Q1 (
  userId char(36),
  firstName nvarchar(20),
  lastName nvarchar(20)
);
-- Write two queries to insert you and your friend 
-- data into table Q1 with a random generate on userId. (using UUID_SHORT())
INSERT INTO Q1 (userId, firstName, lastName)
VALUES (UUID_SHORT(), 'Waris', 'Damkham');
INSERT INTO Q1 (userId, firstName, lastName)
VALUES (UUID_SHORT(), 'Chanisara', 'Kotrachai');
-- From Q1, select firstname, lastnameand present these data in one column called 
-- fullnamewith a single space between them, as well as, count total characters of fullname.
SELECT CONCAT(firstName, ' ', lastName) AS fullname, LENGTH(CONCAT(firstName, lastName)) AS fullnamelength
FROM Q1;
-- Write a query to create table Q2 with the following fields Unamenvarchar(32), Upassbinary(64).
CREATE TABLE Q2 (
  Uname NVARCHAR(32),
  Upass BINARY(64)
);
-- Write a query to insert your username e.g., uxx88xxx and password ‘123456’ data into table Q2.
-- To insert into a password field, you need to encode it first using HASH function with MD5 encoding format.
INSERT INTO Q2 (Uname, Upass)
VALUES ('u6388014', MD5('123456'));
Select * from Q1;