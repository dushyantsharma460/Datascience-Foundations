-- Advanced Topics

-- Window functions (ROW_NUMBER(), RANK(), LEAD(), LAG()) 
-- Transactions (BEGIN, COMMIT, ROLLBACK) 
-- User Access Security 
-- Normalization (1NF, 2NF, 3NF) 
-- Query optimization & execution plans


-- 1. Window Functions

-- Window functions perform calculations across a set of table rows related to the current row. They don’t collapse rows like GROUP BY.
SELECT * FROM employees;

-- a) ROW_NUMBER()
-- Assigns a unique number to each row in a partition.
SELECT 
    department,
    first_name,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num
FROM employees;


-- b) RANK()
-- Gives ranks, same value gets same rank, but gaps exist for ties.
SELECT 
    department,
    first_name,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;


-- Difference between row_number and rank
-- | Feature           | `ROW_NUMBER()`                                                                         | `RANK()`                                                          |
-- | ----------------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
-- | **Purpose**       | Assigns a unique sequential number to each row in the result set, without ties.        | Assigns a ranking to rows, **with the same rank for ties**.       |
-- | **Ties handling** | No ties — each row gets a different number.                                            | Ties get the same rank, and the next rank is skipped accordingly. |
-- | **Example**       | If two rows have the same value, they still get different row numbers (e.g., 1, 2, 3). | If two rows tie for rank 1, the next rank will be 3 (not 2).      |
-- | **Use case**      | When you need a strict sequence without gaps.                                          | When you want to show ranking with gaps for ties.                 |



-- c) LEAD() / LAG()
-- LEAD() → next row value
-- LAG() → previous row value
SELECT 
    first_name,
    salary,
    LAG(salary, 1) OVER (ORDER BY salary) AS prev_salary,
    LEAD(salary, 1) OVER (ORDER BY salary) AS next_salary
FROM employees;
-- Useful for comparing with previous/next row.



-- 2. Transactions
BEGIN;  -- start transaction

UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 101;

UPDATE employees
SET salary = salary - 5000
WHERE employee_id = 102;

-- COMMIT;  -- save changes
ROLLBACK;  -- undo changes if something goes wrong


-- BEGIN → start -> BEGIN and START TRANSACTION are the same in terms of functionality — both start a new transaction.
-- COMMIT → save
-- ROLLBACK → undo



-- 3. User Access Security
CREATE ROLE username WITH LOGIN PASSWORD 'pwd'; GRANT SELECT ON table TO username;



-- GRANT SELECT ON table TO username;
-- Gives that role read-only access (SELECT) to a specific table.

-- This means they can run queries like SELECT * FROM table, but not insert, update, or delete data in it.

-- More permission
GRANT SELECT, INSERT, UPDATE, DELETE ON table TO username;
-- or 
GRANT ALL PRIVILEGES ON table TO username;


-- Set the grant to current db
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO dushyantjoins;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO dushyantjoins;


-- First command → abhi jo tables hain un sab par CRUD access dega.
-- Second command → aage future me jo naye tables banenge unpe bhi CRUD access automatically mil jayega.
-- ⚠ Ye commands chalane ke liye tumhare paas superuser ya owner privileges hone chahiye us database me.



-- Normalization (1NF, 2NF, 3NF)

-- What is Normalization

-- Database normalization is a technique of organising the data in the database 
-- It is systematic approach of decomposing table to eliminate data redundency 
-- It is multi-step process that puts data into tabler form removing the duplicate data from its relational table 
-- On the screan we just saw the table is decomposed into two smaller table
-- Is it really necessary to normalize the table that is present on the database 
-- Every table in the database has to be in the normal form 

-- Normalization is used mainly for two purpose 
-- a. It is used to eliminate repeated data.(having repeated data in the system not only makes the process slow but cost trouble during later tranaction)
-- b. To ensure the data dependency makes some logic sense (Usually the data is stored in db with certain logic)(Huge dataset wihtout any logic are completely waste)

-- Problem (Data Anomalies)
-- If a table not properly normalize has data redundency then it not eat the extra memory space but it also make difficult to handle and update the db

-- 1. Insertion Anomalies
-- Ex - New postion in company dushyant is selected but the department is yet allowted for him in that case if you want to update his info into db you need to department info as NULL 
-- Similarly if we have to insert data of thousand of employees who are in similar situation that the department info will repeated for all those thousand employees
-- This scenario is of example of insertion Anomalies


-- 2. Updation Anomalies
-- What if dushyant leave the company or is no longer head of marketing department in that case all the employee record will have to updated.
-- If by mistake we miss any record it will lead to data inconsistency
-- This is udation anomalies 

-- 3. Deletion Anomalies
-- In an employee table two different information akept together that is employee information , department information
-- Hence the end of financial year if employee record were deleted we will also loose the deparment information 
-- This is deletion anomalies 


-- These were some problem were occured while manging the data 
-- To eliminate all these anomalies Normalisation came into existence
-- There are many normal form which are still under development 




-- First normal form (1NF)
-- In first normal form we tackle the problem of atomisity 
-- Means a single cell cannot multiple values 
-- Example 

-- StudentID	StudentName	Subjects
-- 1	Alice	Math, Physics
-- 2	Bob	    Chemistry, Math


-- ✅ Converted to 1NF (atomic values):

-- StudentID	StudentName	Subject
-- 1	Alice	Math
-- 1	Alice	Physics
-- 2	Bob		Chemistry
-- 2	Bob		Math


-- Now table has achieve the atomicity


-- Second Normal Form


