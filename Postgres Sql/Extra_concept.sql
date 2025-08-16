-- Extra in psql

-- 1. Command Line for psql 

-- Install PostgreSQL on Ubuntu (apt install postgresql).

-- Learn psql commands:
-- \l → list databases
-- \c dbname → connect
-- \dt → list tables
-- \d tablename → describe table
-- \q → quit


-- 2. Indexing (CREATE INDEX, btree, GIN, HASH).

-- a. What is an Index?
-- An index is like a book index — instead of scanning the whole book (table), the database jumps directly to the location of the data.
-- 👉 Speeds up SELECT queries but slows down INSERT/UPDATE/DELETE (because index must also update).


-- b. Default Index (Primary Key)

-- When you created:

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);


-- Postgres automatically created a B-tree index on id.
-- So searching by id is already fast:

SELECT * FROM students WHERE id = 10;



-- c. CREATE INDEX (Manually)
-- Example: Search by name

-- If you often search students by name:

CREATE INDEX idx_students_name ON students(name);


-- Now this query will be faster:

SELECT * FROM students WHERE name = 'Priya';



-- d. Types of Indexes
-- (a) B-tree Index (Default)

-- Best for: =, <, >, BETWEEN, ORDER BY.

-- Example:

CREATE INDEX idx_marks_score ON marks(score);


-- Now queries like this are fast:

SELECT * FROM marks WHERE score > 80;

-- (b) Hash Index

-- Best for: Equality (=) only.

-- Example:

-- CREATE INDEX idx_marks_subject_hash ON marks USING HASH(subject);


-- Now:

SELECT * FROM marks WHERE subject = 'Math';


-- ⚠️ Not useful for range queries (>, <).

-- (c) GIN Index (Generalized Inverted Index)

-- Best for: Full-text search, JSON, array columns.

-- Example: Suppose you had an array of subjects:

ALTER TABLE students ADD COLUMN hobbies TEXT[];

UPDATE students SET hobbies = ARRAY['Cricket', 'Reading'] WHERE id = 1;   -- Rohan
UPDATE students SET hobbies = ARRAY['Football', 'Music'] WHERE id = 2;   -- Aakash
UPDATE students SET hobbies = ARRAY['Dance', 'Singing'] WHERE id = 3;    -- Priya
UPDATE students SET hobbies = ARRAY['Cricket', 'Cooking'] WHERE id = 4;  -- Sneha
UPDATE students SET hobbies = ARRAY['Music', 'Drawing'] WHERE id = 5;    -- Rahul
UPDATE students SET hobbies = ARRAY['Photography', 'Reading'] WHERE id = 6; -- Anjali
UPDATE students SET hobbies = ARRAY['Cricket'] WHERE id = 7;             -- Vikram
UPDATE students SET hobbies = ARRAY['Travel', 'Dance'] WHERE id = 8;     -- Simran
UPDATE students SET hobbies = ARRAY['Gaming'] WHERE id = 9;              -- Karan
UPDATE students SET hobbies = ARRAY['Cricket', 'Music'] WHERE id = 10;   -- Neha
UPDATE students SET hobbies = ARRAY['Dance', 'Music'] WHERE id = 11;     -- Harry
UPDATE students SET hobbies = ARRAY['Reading', 'Travel'] WHERE id = 12;  -- Lakshayraj
UPDATE students SET hobbies = ARRAY['Singing'] WHERE id = 13;            -- Ishita
UPDATE students SET hobbies = ARRAY['Cricket'] WHERE id = 14;            -- Amit
UPDATE students SET hobbies = ARRAY['Cooking', 'Reading'] WHERE id = 15; -- Meena


-- Then:

CREATE INDEX idx_students_hobbies_gin ON students USING GIN(hobbies);


-- Now searching arrays is fast:

SELECT * FROM students WHERE hobbies @> ARRAY['Cricket'];

-- (d) BRIN (Block Range Index) – (extra info)

-- Good for large sequential data (like timestamps).

-- Very small index size.
-- Not needed in your case, but useful for time-series.


-- ⚡ Summary:

-- B-tree (default) → best for ranges, sorting, most queries.
-- Hash → only equality checks.
-- GIN → text search, JSON, arrays.
-- BRIN → huge sequential data.



-- 3. Views & Materialized Views.

-- a. View

-- A view is a virtual table based on the result of a SQL query.
-- It does not store data physically (only the query definition is stored).
-- Whenever you query a view, it fetches data from the underlying base tables.


-- Properties:

-- Always shows the latest data (since it queries the base table every time).
-- No extra storage (except metadata).
-- Can be read-only or updatable (depending on the query).


-- b. Materialized View

-- A materialized view is a physical copy of the query result, stored in the database.
-- It stores the data like a snapshot.
-- Does not update automatically; you need to refresh it to see latest data.


-- Syntax (PostgreSQL):

-- CREATE MATERIALIZED VIEW mv_name AS
-- SELECT column1, column2
-- FROM table_name
-- WHERE condition;


-- REFRESH MATERIALIZED VIEW mv_name;

-- Example 

-- CREATE MATERIALIZED VIEW sales_summary AS
-- SELECT customer_id, SUM(amount) AS total_spent
-- FROM sales
-- GROUP BY customer_id;


-- Properties:

-- Faster for complex queries (since data is precomputed and stored).
-- Consumes storage.
-- Needs manual or scheduled refresh (REFRESH MATERIALIZED VIEW).


-- Comparision

-- | Feature        | View (Normal View)             | Materialized View                         |
-- | -------------- | ------------------------------ | ----------------------------------------- |
-- | Storage        | No (only query definition)     | Yes (stores actual data)                  |
-- | Data Freshness | Always up-to-date              | Stale (needs refresh)                     |
-- | Performance    | Slower (runs query each time)  | Faster (precomputed)                      |
-- | Use Case       | Simple queries, real-time data | Complex queries, performance optimization |


-- 4. Functions: COALESCE, CASE, string & date functions

CREATE TABLE studentsFunc (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    hobbies TEXT,
    marks INT,
    admission_date DATE
);

INSERT INTO studentsFunc (id, name, hobbies, marks, admission_date) VALUES
(1, 'Rohan', 'Cricket', 85, '2023-06-10'),
(2, 'Aakash', NULL, 55, '2022-07-12'),
(3, 'Priya', 'Music', 40, '2021-08-25'),
(4, 'Sneha', NULL, 72, '2023-01-05'),
(5, 'Karan', 'Cricket', NULL, '2020-12-15');


SELECT * FROM studentsFunc;


-- a. COALESCE

-- Returns the first non-NULL value.

-- Show hobbies, if NULL then show 'No Hobby'
-- Array ma se single value kadh rha
SELECT id, name, COALESCE(hobbies, 'No Hobby') AS hobby FROM studentsFunc;


-- 👉 If hobbies are NULL (like Aakash & Sneha), it will show "No Hobby".


-- b. CASE

-- Grade students based on marks
SELECT id, name, marks,
       CASE
         WHEN marks >= 75 THEN 'A'
         WHEN marks BETWEEN 50 AND 74 THEN 'B'
         WHEN marks IS NULL THEN 'Not Attempted'
         ELSE 'C'
       END AS grade
FROM studentsFunc;

-- 👉 Karan will show "Not Attempted" because marks is NULL.



-- c. String Functions
-- Uppercase, Length, Concatenate

SELECT 
    name,
    UPPER(name) AS upper_name,
    LENGTH(name) AS name_length,
    CONCAT(name, ' likes ', COALESCE(hobbies, 'nothing')) AS details
FROM studentsFunc;


-- 👉 Example: "Rohan likes Cricket", "Aakash likes nothing".

-- Other common string functions:

-- LOWER(name) → lowercase
-- SUBSTRING(name, 1, 3) → first 3 letters
-- POSITION('a' IN name) → find position of letter


-- d. Date Functions

-- Extract year and calculate how old the admission is
SELECT 
    name,
    admission_date,
    EXTRACT(YEAR FROM admission_date) AS admission_year,
    AGE(admission_date) AS years_in_college,
    CURRENT_DATE - admission_date AS days_since_admission
FROM students;


-- 👉 This will show:

-- Admission year (like 2023)
-- How long since admission (e.g., 2 years 1 mon)
-- Exact number of days


-- ✨ Summary:

-- COALESCE → handle NULL values
-- CASE → conditional logic
-- String functions → manipulate text (UPPER, LENGTH, CONCAT, etc.)
-- Date functions → extract or calculate with dates (EXTRACT, AGE, etc.)

