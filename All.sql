CREATE DATABASE Company;
USE Company;

CREATE TABLE Employees(
id INT PRIMARY KEY,
name VARCHAR(50),
age INT NOT NULL,
department VARCHAR(50)
);

INSERT INTO Employees
VALUES
(1,"Gabru",27,"IT"),
(2,"Don",56,"Finance"),
(3,"Sheela",29,"HR"),
(4,"Tina",20,"Manufacturing");

CREATE PROCEDURE getEmployees()
SELECT * 
FROM Employees 
WHERE age > 20 AND age < 30;

CALL getEmployees();


CREATE TABLE student(
rollNo INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
marks INT NOT NULL,
grade VARCHAR(1) NOT NULL,
city VARCHAR(20) NOT NULL
);

INSERT INTO student
VALUES
(101,"Anil",78,"C","Pune"),
(102,"Bhumika",93,"A","Pune"),
(103,"Chetan",85,"B","Pune"),
(104,"Dhruv",96,"A","Pune"),
(105,"Gabru",12,"F","Pune"),
(106,"Farah",82,"B","Pune");


SELECT * FROM student;

SELECT name 
FROM student;

SELECT name,rollNO
FROM student;

SELECT name,rollNO
FROM student
WHERE marks + 5 > 80 + 5;

SELECT * 
FROM student
WHERE city NOT IN ("Bathinda")
ORDER BY marks DESC LIMIT 3;


INSERT INTO student
VALUES
(107,"Anil",100,"A","Shimla"),
(108,"Bhumika",99,"A","Manali"),
(109,"Chetan",34,"F","Kerela"),
(110,"Sheetal",70,"C","Kerela"),
(111,"Tina",60,"D","Kerela"),
(112,"Micheal",77,"C","Kerela");

SELECT city,count(*)
FROM student
GROUP BY city;

SELECT name,count(*)
FROM student
GROUP BY name
HAVING max(marks) < 80;

SELECT name, count(*)
FROM student
WHERE marks BETWEEN 70 AND 100
GROUP BY name;

SELECT city, count(*) FROM student GROUP BY city HAVING max(marks) > 80;
SELECT city, count(*) FROM student WHERE marks > 80 GROUP BY city;

CREATE TABLE teacher(
id INT PRIMARY KEY,
name VARCHAR(50),
studentRollNo INT,
FOREIGN KEY (studentRollNo) REFERENCES student(rollNo)
ON UPDATE CASCADE
ON DELETE CASCADE
);

INSERT INTO teacher
VALUES
(1,"Nirmala",101),
(2,"Shallu",102),
(3,"Nirmala",103),
(4,"Nirmala",105),
(5,"Nirmala",108),
(6,"Bobby",104),
(7,"Bobby",106),
(8,"Shallu",109),
(9,"Nirmala",111);

SELECT * FROM teacher;

TRUNCATE TABLE teacher;

DROP TABLE teacher;

UPDATE student
SET rollNo = 115
WHERE rollNO = 104;

SELECT * FROM student;
SELECT * FROM teacher;

DELETE FROM student
WHERE rollNO = 115;


ALTER TABLE teacher
ADD COLUMN dept VARCHAR(20);

SET SQL_SAFE_UPDATES = 0;

UPDATE teacher
SET dept = "Finance"
WHERE name = "Nirmala";

ALTER TABLE student
DROP COLUMN grade;

ALTER TABLE student
RENAME TO studentNew;

SELECT * FROM studentNew;

ALTER TABLE studentNew
RENAME TO student;

SELECT * 
FROM teacher as T
RIGHT JOIN Employees as E
ON T.id = E.id;

SELECT *
FROM teacher as T
LEFT JOIN Employees as E
ON T.id = E.id;

SELECT *
FROM teacher as T
INNER JOIN Employees as E
ON T.dept = E.department;


SELECT * 
FROM teacher as T
LEFT JOIN Employees as E
ON T.id = E.id
UNION
SELECT * 
FROM teacher as T
RIGHT JOIN Employees as E
ON T.id = E.id;

