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
-- A table is said to be in second normal form only when it fulfill the following condition.
-- 1. It has to be in first normal form 
-- 2. Table should not contain partial dependency

-- Partial Dependency means the proper subset of candidate key determine a non prime attribute.

-- Non Prime attribute -> Attribute that form a candidate key in a table are called prime attribute.
-- And the rest of the attribute of the relation are non prime 
-- For a table prime attribute can be like employee_id and department_id
-- And non prime attribute are like to be office location 


-- To understand the second normal form let consider the example 

-- | Employee\_ID | Department\_ID | Office\_Location |
-- | ------------ | -------------- | ---------------- |
-- | E1           | D1             | New York         |
-- | E2           | D1             | New York         |
-- | E3           | D2             | London           |

-- Assumption

-- Primary key = (Employee_ID, Department_ID) (composite key).
-- Problem → Office_Location depends only on Department_ID (partial dependency).



-- 2NF Conversion
-- Employee_Department Table

-- | Employee\_ID | Department\_ID |
-- | ------------ | -------------- |
-- | E1           | D1             |
-- | E2           | D1             |
-- | E3           | D2             |


-- Split the dependecny into two

-- Department Table

-- | Department\_ID | Office\_Location |
-- | -------------- | ---------------- |
-- | D1             | New York         |
-- | D2             | London           |


-- Third Normal Form 
-- Third Normal Form is a normal form that is used in normalizing the table to reduce the duplication of data and ensure referential intigrity
-- Following condition has to be met by the table to be in third normal form
-- 1. Table has to be in second normal form 
-- 2. No non prime attribute is transitively dependent on any non prime attributes which depend on another non prime attributes.

-- Let take Ex-
-- If C is dependent on B and interm B is dependent on A and transitively C is dependent on A
-- This should not happen in third normal form 
-- All non prime attribute must depend on prime attribute 
-- These are the two neccessary condition that needs to attain
-- 3NF is design to eliminate undesirable data anormilies 
-- To reduce a need for restructuring over time


-- | Employee\_ID | Department\_ID |
-- | ------------ | -------------- |
-- | E1           | D1             |
-- | E2           | D1             |
-- | E3           | D2             |


-- | Department\_ID | Office\_Location | Location\_Manager |
-- | -------------- | ---------------- | ----------------- |
-- | D1             | New York         | M1                |
-- | D2             | London           | M2                |

-- Location_Manager depends on Office_Location, which depends on Department_ID.
-- This is a transitive dependency, so it violates 3NF.


-- | Department\_ID | Office\_Location |
-- | -------------- | ---------------- |
-- | D1             | New York         |
-- | D2             | London           |

-- | Office\_Location | Location\_Manager |
-- | ---------------- | ----------------- |
-- | New York         | M1                |
-- | London           | M2                |


-- Boyce Codd Normal Form (BCNF or 3.5 Normal Form)
-- Higher version of third normal form 
-- Satisfied 3NF
-- In this Every Funtion Dependency A->B , then A has to be the super key of that particular table 

-- Super Key -> Group of single or multiple keys which identify the row in a table 
-- Ex-


-- CourseInstructor
-- +------------+-----------+-----------+
-- | course_id  | teacher   | room_no   |
-- +------------+-----------+-----------+
-- | C1         | T1        | R1        |
-- | C2         | T2        | R2        |
-- | C3         | T1        | R3        |
-- +------------+-----------+-----------+


-- Functional Dependencies (FDs)
-- course_id → teacher (each course has only one teacher)
-- teacher → room_no (each teacher teaches in exactly one room)


-- Why it’s in 3NF but not BCNF
-- Primary Key: course_id
-- teacher → room_no violates BCNF because teacher is not a superkey, but it determines another attribute.


-- Table 1: TeacherRoom
-- +-----------+-----------+
-- | teacher   | room_no   |
-- +-----------+-----------+
-- | T1        | R1        |
-- | T2        | R2        |
-- +-----------+-----------+


-- Table 2: CourseTeacher

-- +------------+-----------+
-- | course_id  | teacher   |
-- +------------+-----------+
-- | C1         | T1        |
-- | C2         | T2        |
-- | C3         | T1        |
-- +------------+-----------+


-- In TeacherRoom, teacher is the key.
-- In CourseTeacher, course_id is the key.
-- All determinants are candidate keys → satisfies BCNF.




-- Third Normal Form (3NF)
-- A table is in 3NF if:

-- It is in 2NF
-- No non-prime attribute depends on another non-prime attribute (i.e., no transitive dependency).
-- Exception: 3NF allows a functional dependency where the determinant is a candidate key or a superkey or a prime attribute.



-- Boyce–Codd Normal Form (BCNF)
-- A table is in BCNF if:

-- It is in 3NF
-- Every determinant must be a superkey (no exceptions).
-- Stricter than 3NF — even candidate keys must follow the rule.

-- Key Difference

-- 3NF: Allows dependency where a non-superkey determinant is a prime attribute.
-- BCNF: No such exception — if something determines other attributes, it must be a superkey.