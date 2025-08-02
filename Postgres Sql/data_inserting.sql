CREATE TABLE student (
	id INT PRIMARY KEY,
	name VARCHAR(100),
	age INT,
	grade VARCHAR(10),
	date_of_birth DATE
);

-- In psql values are in single quotes ('') while in mysql allowed both but recomment single quotes for string
INSERT INTO student (id, name, age, grade, date_of_birth)
VALUES (1, 'Dushyant', 21, '10th', '2004-08-05');


SELECT * FROM student;

-- inserting data one by one
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (2, 'Ravi Sharma', 17, '11th', '2006-03-22');
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (3, 'Meena Joshi', 15, '9th', NULL);
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (4, 'Arjun Verma', 18, '12th', NULL);
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (5, 'Sara Ali', 16, '10th', NULL);
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (6, 'Karan Mehta', 17, '11th', NULL);
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (7, 'Tanya Roy', 15, '9th', NULL);
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (8, 'Vikram Singh', 18, '12th', NULL);
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (9, 'Anjali Desai', 16, '10th', NULL);
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (10, 'Farhan Zaidi', 17, '11th', NULL);
INSERT INTO student (id, name, age, grade, date_of_birth) VALUES (11, 'Ayesha Khan', 16, '10th', '2007-05-15');



-- Inserting bulk data together
INSERT INTO student (id, name, age, grade) VALUES
	(12, 'Ayesha Khan', 16, '10th'),
	(13, 'Ravi Sharma', 17, '11th'),
	(14, 'Meena Joshi', 15, '9th'),
	(15, 'Arjun Verma', 18, '12th'),
	(16, 'Sara Ali', 16, '10th'),
	(17, 'Karan Mehta', 17, '11th'),
	(18, 'Tanya Roy', 15, '9th'),
	(19, 'Vikram Singh', 18, '12th'),
	(20, 'Anjali Desai', 16, '10th'),
	(21, 'Farhan Zaidi', 17, '11th');


-- Seleting all data from the table student (result is column seprated)
SELECT * FROM student;

-- Selecting specific thing from table
SELECT id,name FROM student;

-- Selecting thing in combined form (Tuple -> result is comma seprated)
SELECT (id,name) FROM student;

-- Selecting thing in combined form (Array -> result in {})
SELECT ARRAY[id::text, name] FROM student;