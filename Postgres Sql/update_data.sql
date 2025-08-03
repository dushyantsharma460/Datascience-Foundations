SELECT * FROM student;

-- I wants grade 10th changes into roman format (UPDATE)
UPDATE student SET grade = 'X' 	WHERE grade = '10th';

SELECT * FROM student;

-- Update multiple column (set another column by another column condition)
UPDATE student SET age = 16 WHERE grade = 'X';


-- Prmote all students to same grade A
UPDATE student SET grade = 'A';

-- Set grade A++ where grade is A (Want to use any condition you can)(EX - Promote all students in 9th grade to 10th grade)
UPDATE student SET grade = 'A++' WHERE grade = 'A' AND age > 16;   -- From this my data of less than 16 is gone !!!
UPDATE student SET grade = 'A++' WHERE grade = 'A'; 


-- Increase age by 1 for students younger than 18
UPDATE student SET age = age + 1 WHERE age < 18;


-- UPDATE the NULL by using IS 
-- UPDATE student SET date_of_birth='Unknown' WHERE date_of_birth IS NULL;   -- Error due to type date
-- First alter the type
ALTER TABLE student ALTER COLUMN date_of_birth TYPE TEXT;

-- Now it works
UPDATE student SET date_of_birth='Unknown' WHERE date_of_birth IS NULL; 


-- Now if age = 18 grade B and date of birth "Mature"
UPDATE student SET date_of_birth='Mature', grade='B' WHERE age=18;

SELECT * FROM student;

