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

