-- In mysql -> CREATE DATABASE school;   USE school;
-- Using school database


CREATE TABLE classes (
	class_id SERIAL PRIMARY KEY,
	class_name VARCHAR(50) NOT NULL
);

-- We map the class_id to classes table

CREATE TABLE students (
	student_id SERIAL PRIMARY KEY,
	student_name VARCHAR(100) NOT NULL,
	class_id INT,
	FOREIGN KEY (class_id) REFERENCES classes(class_id)
		ON UPDATE CASCADE
		ON DELETE SET NULL
);

-- It is not compulsary that foreign key column name is same as that of mapping column name
-- Using below table right now

CREATE TABLE students (
	student_id SERIAL PRIMARY KEY,
	student_name VARCHAR(100) NOT NULL,
	class_id_of_student INT,
	FOREIGN KEY (class_id_of_student) REFERENCES classes(class_id)
		ON UPDATE CASCADE
		ON DELETE SET NULL
);

-- • ON DELETE SET NULL : If a class is deleted, the related students will have class_id_of_student set to NULL .
-- • ON UPDATE CASCADE : If a class ID changes, it will update automatically in the students table.


INSERT INTO classes (class_name) VALUES ('Mathematics'), ('Science'), ('History');
SELECT * FROM classes;


INSERT INTO students (student_name, class_id_of_student) VALUES
('Alice', 1),
('Bob', 2),
('Charlie', 1);

SELECT * FROM students;

-- Example of ON DELETE SET NULL
DELETE FROM classes where class_id = 2;
-- change toh classes table (class_id) par it also null the respective forign key
-- From this mera lookup fail nhi hoga


-- Example of ON UPDATE CASCADE
UPDATE classes SET class_id = 101 WHERE class_id = 1;
UPDATE classes SET class_id = 102 WHERE class_id = 2;
UPDATE classes SET class_id = 103 WHERE class_id = 3;


-- mana classes ma change kiya toh forign key wali table mai bhi change ho gya due to ON UPDATE CASCADE
-- agar change na hoya toh aap samajh sakta ho ki kitni bdi problem ho jya gi


-- Explain the table from this query -> SHOW CREATE TABLE students;

-- List all the foreign key constraint from the database 
-- In mysql 


-- SELECT
-- table_name,
-- column_name,
-- constraint_name,
-- referenced_table_name,
-- referenced_column_name
-- FROM
-- information_schema.key_column_usage
-- WHERE
-- referenced_table_name IS NOT NULL
-- AND table_schema = 'school';


-- In psql 
SELECT
    tc.table_name,
    kcu.column_name,
    tc.constraint_name,
    ccu.table_name AS referenced_table_name,
    ccu.column_name AS referenced_column_name
FROM
    information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.constraint_schema = kcu.constraint_schema
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
    AND ccu.constraint_schema = tc.constraint_schema
WHERE
    tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema = 'public'  -- schema name, not DB name
ORDER BY
    tc.table_name, tc.constraint_name;
