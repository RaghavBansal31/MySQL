CREATE DATABASE school;
USE school;

CREATE TABLE students(
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
age INT NOT NULL,
marks INT NOT NULL,
grade VARCHAR(1) NOT NULL,
city VARCHAR(10) NOT NULL
);

/*  TRIGGERS: They are automatically invoked on events such as INSERT, UPDATE and DELETE on the table.
    1. A trigger can be invoked before or after an event (INSERT, UPDATE, DELETE)
    2. A trigger cannot have parameter and return values.
*/


DELIMITER $$

CREATE TRIGGER update_Grades
BEFORE INSERT ON students   
FOR EACH ROW
BEGIN
     IF NEW.marks >= 90 THEN
        SET NEW.grade = 'A';
	ELSEIF NEW.marks >= 70 THEN
        SET NEW.grade = 'B';
	ELSEIF NEW.marks >= 50 THEN
        SET NEW.grade = 'C';
	ELSE 
        SET NEW.grade = 'F';
	END IF;
    
END$$

DELIMITER ;

DROP TRIGGER update_Grades;

INSERT INTO students
(id,name,age,marks,city)
VALUES
(1,"Gabru",24,87,"Pune"),
(2,"Don",26,40,"Manali"),
(3,"Sheela",44,60,"Shimla"),
(4,"Tina",124,98,"Hyderabad"),
(5,"Mina",94,76,"Mumbai");
SELECT * FROM students;


/*
  FUNCTIONS: They are used for calculation or data manipulation and can be used within SQL Queries
  1. They can accept input parameters
  2. They have a single return value.
*/

CREATE TABLE new_Students(
id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
marks INT,
grade VARCHAR(1),
city VARCHAR(10),
gender VARCHAR(1),
height DECIMAL(5,2)
);

DROP TABLE new_Students;

DELIMITER $$

CREATE FUNCTION get_Grade(marks INT)
RETURNS VARCHAR(1)
DETERMINISTIC
BEGIN
     DECLARE grade VARCHAR(1);
     IF marks >= 90 THEN
        SET grade = 'A';
	ELSEIF marks >= 80 THEN
        SET grade = 'B';
	ELSEIF marks >= 70 THEN
        SET grade = 'C';
	ELSEIF marks >= 50 THEN
        SET grade = 'D';
	ELSE 
       SET grade = 'F';
    END IF;
    
    RETURN grade;
END$$

DELIMITER ;



INSERT INTO new_Students
(id,name,age,marks,city,gender,height)
VALUES
(1, "Gabru", 24, 87, "Pune", "M", 175.5),
(2, "Don", 26, 40, "Manali", "M", 180.2),
(3, "Sheela", 44, 60, "Shimla", "F", 160.0),
(4, "Tina", 124, 98, "Hyderabad", "F", 165.5),
(5, "Mina", 94, 76, "Mumbai", "F", 158.3),
(6, "Ravi", 22, 82, "Pune", "M", 178.0),
(7, "Nina", 30, 72, "Delhi", "F", 162.2),
(8, "Suresh", 27, 55, "Chennai", "M", 170.8),
(9, "Raj", 21, 90, "Mumbai", "M", 180.5),
(10, "Kavita", 35, 88, "Pune", "F", 167.4),
(11, "Arjun", 25, 45, "Bangalore", "M", 172.1),
(12, "Neha", 40, 68, "Goa", "F", 163.0),
(13, "Vishal", 29, 80, "Hyderabad", "M", 176.4),
(14, "Anita", 33, 95, "Delhi", "F", 168.5),
(15, "Pradeep", 28, 60, "Pune", "M", 174.0);

TRUNCATE TABLE new_Students;

SELECT id, name, marks, get_grade(marks) AS grade, city, gender, height FROM new_Students;
