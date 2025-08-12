-- Drop and create the database

-- Sql query for create db and use
-- DROP DATABASE IF EXISTS dushyantjoins;
-- CREATE DATABASE dushyantjoins;
-- USE dushyantjoins;


-- Use dushyantjoins database in psql 
-- DROP DATABASE IF EXISTS dushyantjoins;
-- CREATE DATABASE dushyantjoins;
-- \c dushyantjoins;


-- Create students table
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert students
INSERT INTO students (id, name) VALUES
(1, 'Rohan'),
(2, 'Aakash'),
(3, 'Priya'),
(4, 'Sneha'),
(5, 'Rahul'),
(6, 'Anjali'),
(7, 'Vikram'),
(8, 'Simran'),
(9, 'Karan'),
(10, 'Neha'),
(11, 'Harry'),
(12, 'Lakshayraj Dash'),
(13, 'Ishita'),
(14, 'Amit'),
(15, 'Meena');

-- Selection
SELECT * FROM students;

-- Create marks table
CREATE TABLE marks (
    id SERIAL PRIMARY KEY,
    student_id INT,
    subject VARCHAR(30),
    score INT,
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Insert marks
INSERT INTO marks (student_id, subject, score) VALUES
(1, 'Math', 92),
(1, 'Science', 88),
(2, 'Math', 81),
(2, 'English', 79),
(3, 'Math', 75),
(3, 'Science', 73),
(4, 'Science', 85),
(5, 'English', 78),
(5, 'Math', 80),
(6, 'Science', 66),
(6, 'English', 68),
(7, 'Math', 55),
(8, 'English', 74),
(10, 'Science', 89),
(10, 'Math', 83),
(12, 'Math', 77),
(12, 'Science', 79),
(13, 'English', 60),
(14, 'Science', 69),
(14, 'English', 72);


SELECT * FROM marks;

-- Note: Students 9 (Karan), 11 (Harry), and 15 (Meena) have NO marks.


-- Now Join Selection 

-- Inner Join (Both table common record) (Deffult Join)
SELECT students.name, marks.subject, marks.score FROM students inner join marks on students.id = marks.student_id;

-- Syntax 2 (Using aliases)
SELECT s.name, m.subject, m.score
FROM students AS s
INNER JOIN marks AS m
    ON s.id = m.student_id;

-- Syntax 3 (Skip As or Skip aliases)
SELECT s.name, m.subject, m.score
FROM students s
INNER JOIN marks m
    ON s.id = m.student_id;



-- Left join (Include all data from the left column)(or LEFT OUTER JOIN)
SELECT students.name, marks.subject, marks.score FROM students left join marks on students.id = marks.student_id;


-- Right join (Include all data from the right column) (or RIGHT OUTER JOIN)
SELECT students.name, marks.subject, marks.score FROM students right join marks on students.id = marks.student_id;


-- Cross join (Include all data both the table) ()
SELECT students.name, marks.subject, marks.score FROM students cross join marks;


-- Natural Join V/S INNER Join
SELECT *
FROM students
NATURAL JOIN marks;


-- | Feature              | **NATURAL JOIN**                                                          | **INNER JOIN**                                                  |
-- | -------------------- | ------------------------------------------------------------------------- | --------------------------------------------------------------- |
-- | **Join condition**   | Automatically joins on **all columns with the same name** in both tables. | Joins on **explicit condition** you provide in the `ON` clause. |
-- | **Column selection** | Removes one duplicate copy of the join column(s).                         | Keeps both columns unless you choose otherwise.                 |
-- | **Control**          | Less control — can cause mistakes if unwanted columns have the same name. | Full control — you decide exactly which columns to match.       |
-- | **Readability**      | Shorter syntax, but less obvious to someone reading the query.            | More explicit, so easier to understand what’s being matched.    |



-- Remember: NATURAL JOIN is just a convenience when column names match but INNER JOIN is the default and is preferred for clarity.
-- if the column names match and you intend to join on exactly those columns, then NATURAL JOIN and INNER JOIN will return the same rows.
-- With your current tables, the result is not the same — because students has id and marks has student_id, so NATURAL JOIN won’t match anything (it would actually return a CROSS JOIN effect since there’s no common column name).



-- Cross Join V/s Full join 

SELECT s.name, m.subject
FROM students s
CROSS JOIN marks m;


-- Cross Join -> Returns all possible combinations of rows from both tables (Cartesian product).
-- Row count = (rows in table A) × (rows in table B)./
-- students = 15 rows
-- marks = 20 rows
-- → CROSS JOIN result = 15 × 20 = 300 rows


-- FULL JOIN RESULT 

SELECT s.id, s.name, m.subject
FROM students s
FULL JOIN marks m
    ON s.id = m.student_id;

-- Returns all matching rows plus all unmatched rows from both tables.
-- Matches rows using a condition (ON clause).
-- If no match, missing values are filled with NULL.
-- Row count ≤ (rows in table A + rows in table B).


-- | Feature         | CROSS JOIN                           | FULL JOIN                           |
-- | --------------- | ------------------------------------ | ----------------------------------- |
-- | Match Condition | None                                 | Required (`ON`)                     |
-- | Output Size     | Maximum possible (Cartesian product) | Depends on matches + unmatched rows |
-- | Purpose         | Combine every row from both tables   | Combine matched and unmatched data  |
-- | NULLs           | No NULLs (every combination exists)  | NULLs appear for unmatched rows     |


-- Self Join (IN SQL)
-- A SELF JOIN is when a table is joined with itself.
-- We treat one copy as table A and another as table B by giving them different aliases.
-- It can be INNER, LEFT, etc., just like a normal join.
-- Useful for comparing rows in the same table (e.g., hierarchy, relationships, similarities).

SELECT s1.name AS student1, s2.name AS student2
FROM students s1
JOIN students s2
    ON LEFT(s1.name, 1) = LEFT(s2.name, 1)
    AND s1.id <> s2.id;


-- LEFT(name, 1) takes the first letter of the name.
-- We match students whose names start with the same letter.(AND Condition is for not same name match)
	

-- students is used twice: once as s1, once as s2.
-- We match rows within the same table based on the condition.
-- s1.id <> s2.id avoids matching a row with itself.


-- Real-world uses of SELF JOIN

-- Hierarchy trees (e.g., employees reporting to managers).
-- Finding duplicates in the same table.
-- Comparing rows for similarity.


