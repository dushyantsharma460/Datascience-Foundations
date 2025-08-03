SELECT * FROM student;

-- SELCTING DATA CONDITIONALLY
-- Selecting grade 10th student
SELECT * FROM student WHERE grade='10th';


-- Select student where age is greater than 16
SELECT * FROM student WHERE age > 16;


-- Select student where age is greater than 16 and also is in 10th grade
SELECT * FROM student WHERE age > 16 AND grade='12th';


-- Select student where age is in between 15 to 17
SELECT * FROM student WHERE age BETWEEN 15 AND 17;


-- Select student who are in class 10th or 12th (or condition)
SELECT * FROM student WHERE grade IN('10th' , '12th');  -- Multiple or
SELECT * FROM student WHERE grade = '9th' OR grade = '11th';      -- by or we can compare multiple columns

-- Select students who are not in class 10th ,11th ,12th
SELECT * FROM student WHERE grade NOT IN('10th', '11th', '12th');


-- Pattern matching selection
-- Match pattern where name starting with A
SELECT * FROM student WHERE name LIKE 'A%';


-- Match pattern where name not ends with an
SELECT * FROM student WHERE name NOT LIKE '%an';


-- Not equal conditions (<> or !=)
SELECT * FROM student WHERE age <> 15;
SELECT * FROM student WHERE age != 15;


-- Handling NULL Values 
-- Def :- NULL represents missing or unknown values. It is not equal to 0 , empty string, or any other value.

-- NULL can't be compare with (=)
-- This will not work as expected
SELECT * FROM student WHERE date_of_birth = NULL;

-- To compare NULL use IS
SELECT * FROM student WHERE date_of_birth IS NULL;
SELECT * FROM student WHERE date_of_birth IS NOT NULL;


-- Complex Condition by using bracket (Chaining)
SELECT * FROM student WHERE (grade = '10th' OR grade = '11th') AND age >= 16;
SELECT * FROM student WHERE grade IN ('10th', '11th') AND age >= 16;


-- Sorting the selecting values by using (ORDER BY)
SELECT * FROM student WHERE age < 19 ORDER BY age DESC;
SELECT * FROM student WHERE grade = '10th' or grade = '12th' ORDER BY age ASC;


-- You can also limit the row by using limit fuction like top5 , top10
SELECT * FROM student WHERE age < 19 ORDER BY age DESC LIMIT 5;
SELECT * FROM student LIMIT 5;

-- Setting offset(skip offset than start -> skip 2 than count 5 items) (mysql -> SELECT * FROM student LIMIT 2, 5;)
-- But in psql we need to write offset also , offset order is not matter
SELECT * FROM student LIMIT 5 OFFSET 2;
SELECT * FROM student OFFSET 2 LIMIT 5;