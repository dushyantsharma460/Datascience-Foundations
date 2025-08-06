SELECT * FROM student;

-- DELETE entries where D.O.B is null
DELETE FROM student WHERE date_of_birth IS NULL;
DELETE FROM student WHERE date_of_birth = 'Unknown';

-- DELETE entries where id < 5
DELETE FROM student WHERE id < 5;


-- Use below query to empty the entire table 
DELETE FROM student;

-- Remove your table 
DROP TABLE student;