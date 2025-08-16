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



-- Conclustion
-- 👉 1NF, 2NF, and 3NF all help reduce anomalies step by step, but the main NF that removes Insertion, Updation, and Deletion anomalies is 3NF (Third Normal Form).
-- 1NF → Removes repetition & multi-valued attributes (but anomalies still exist).
-- 2NF → Removes partial dependency (helps reduce anomalies but not fully).
-- 3NF → Removes transitive dependency → this is what eliminates Insertion, Update, and Deletion anomalies effectively.



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


-- What is Partial Dependency?

-- A partial dependency happens when a non-prime attribute (a column that is not part of any candidate key) depends only on part of a composite primary key, not on the whole key.

-- A candidate key is a minimal set of one or more columns that can uniquely identify each row in a table.

-- Candidate Key
-- A Candidate Key is a minimal set of attributes (columns) that can uniquely identify a row in a table.
-- Minimal → no extra column should be there.

-- A table can have many candidate keys.
-- From candidate keys, one is chosen as the Primary Key.

-- Example 1: Student Table
-- StudentID	Email				Phone			Name
-- 1			a@gmail.com			98765			Rahul
-- 2			b@gmail.com			91234			Sneha

-- 👉 This problem comes only when the primary key is composite (made of 2 or more columns).


-- Composite primary Key 

-- A composite primary key is a primary key made up of two or more columns in a table.

-- 👉 It is used when a single column cannot uniquely identify a row, but a combination of multiple columns can.

-- Example
-- CREATE TABLE Enrollments (
--     student_id INT,
--     course_id INT,
--     enrollment_date DATE,
--     PRIMARY KEY (student_id, course_id)
-- );




-- For a table prime attribute can be like employee_id and department_id
-- And non prime attribute are like to be office location 


-- To understand the second normal form let consider the example 
-- Example 1:-

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



-- Example 2:-

-- Step 1: Start with a Table (Unnormalized or 1NF → 2NF issue)

-- Suppose we have a table Student_Course:

-- student_id	student_name	course_id	course_name		professor_id	professor_name
-- 1			Raj				C101		DBMS			P01				Dr. Sharma
-- 1			Raj				C102		Accounts		P02				Dr. Mehta
-- 2			Priya			C101		DBMS			P01				Dr. Sharma
-- 3			Aman			C103		Economics		P03				Dr. Verma

-- Step 2: Primary Key

-- Here, one student can take many courses → composite primary key = (student_id, course_id).

-- Step 3: Check for Partial Dependency (2NF rule)

-- 👉 2NF says: No non-key attribute should depend on part of a composite key.
-- student_name depends only on student_id (part of the composite key). ❌
-- course_name, professor_id, professor_name depend only on course_id. ❌
-- So, the table is in 1NF but NOT in 2NF.

-- Step 4: Break into 2NF
-- We split the table into separate tables:

-- Table 1: Students
-- student_id	student_name
-- 1			Raj
-- 2			Priya
-- 3			Aman

-- Table 2: Courses
-- course_id	course_name		professor_id
-- C101			DBMS			P01
-- C102			Accounts		P02
-- C103			Economics		P03

-- Table 3: Professors
-- professor_id		professor_name
-- P01				Dr. Sharma
-- P02				Dr. Mehta
-- P03				Dr. Verma

-- Table 4: Student_Course (Mapping Table)
-- student_id	course_id
-- 1			C101
-- 1			C102
-- 2			C101
-- 3			C103

-- ✅ Now:

-- No column depends on only part of a composite key.
-- Data is stored without redundancy.
-- Table is in 2NF.



-- Third Normal Form 
-- Third Normal Form is a normal form that is used in normalizing the table to reduce the duplication of data and ensure referential intigrity
-- Following condition has to be met by the table to be in third normal form
-- 1. Table has to be in second normal form 
-- 2. No non prime attribute is transitively dependent on any non prime attributes which depend on another non prime attributes.

-- Explaination
-- No non-key attribute depends on another non-key attribute (no transitive dependency).
-- 👉 In short: Every non-key column should depend only on the primary key, not on other non-key columns.

-- Let take Ex-
-- If C is dependent on B and interm B is dependent on A and transitively C is dependent on A
-- This should not happen in third normal form 
-- All non prime attribute must depend on prime attribute 
-- These are the two neccessary condition that needs to attain
-- 3NF is design to eliminate undesirable data anormilies 
-- To reduce a need for restructuring over time

-- Example 1:-


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


-- Example 2:-

-- 🔹 Step 1: Original Table (Unnormalized)
-- order_id		customer_id		customer_name	customer_city	product_id	product_name	supplier_id		supplier_name
-- 101			C01				Raj				Delhi			P01			Laptop			S01				Dell
-- 102			C02				Priya			Mumbai			P02			Mobile			S02				Samsung
-- 103			C01				Raj				Delhi			P02			Mobile			S02				Samsung
-- 104			C03				Aman			Jaipur			P03			Printer			S01				Dell

-- Composite Primary Key here = (order_id, product_id)
-- (because one order can have many products).


-- 🔹 Step 2: Convert to 2NF

-- 👉 Rule of 2NF: Remove partial dependency (non-key column depends only on part of composite key).
-- Partial Dependencies here:

-- customer_name and customer_city depend only on customer_id.
-- product_name, supplier_id, supplier_name depend only on product_id.

-- So we split into separate tables:

-- Customers Table
-- customer_id		customer_name	customer_city
-- C01				Raj				Delhi
-- C02				Priya			Mumbai
-- C03				Aman			Jaipur

-- Products Table
-- product_id		product_name	supplier_id		supplier_name
-- P01				Laptop			S01				Dell
-- P02				Mobile			S02				Samsung
-- P03				Printer			S01				Dell

-- Orders Table
-- order_id		customer_id
-- 101			C01
-- 102			C02
-- 103			C01
-- 104			C03

-- Order_Details Table
-- order_id		product_id
-- 101			P01
-- 102			P02
-- 103			P02
-- 104			P03

-- ✅ Now the design is in 2NF.


-- 🔹 Step 3: Convert to 3NF

-- 👉 Rule of 3NF: Remove transitive dependency (non-key depends on another non-key).

-- Transitive Dependency:
-- In the Products table:
-- supplier_name depends on supplier_id,
-- but supplier_id itself depends on product_id.
-- So, supplier_name is indirectly dependent on product_id → ❌ violates 3NF.

-- Final 3NF Tables

-- Custome
-- customer_id		customer_name	customer_city
-- C01				Raj				Delhi
-- C02				Priya			Mumbai
-- C03				Aman			Jaipur

-- Products
-- product_id		product_name	supplier_id
-- P01				Laptop			S01
-- P02				Mobile			S02
-- P03				Printer			S01

-- Suppliers
-- supplier_id		supplier_name
-- S01				Dell
-- S02				Samsung

-- Orders
-- order_id		customer_id
-- 101			C01
-- 102			C02
-- 103			C01
-- 104			C03

-- Order_Details
-- order_id		product_id
-- 101			P01
-- 102			P02
-- 103			P02
-- 104			P03

-- ✅ Now the database is in 3NF:

-- No partial dependency.
-- No transitive dependency.
-- Data redundancy removed.



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


-- 🔹 Rule of BCNF

-- A table is in BCNF if:
-- It is already in 3NF.
-- For every functional dependency (X → Y), the determinant X must be a superkey.

-- A superkey is a set of one or more attributes (columns) in a table that can uniquely identify each row (tuple) in that table.

-- 👉 In short: No non-superkey should determine another column.


-- 🔹 Our 3NF Tables Recap

-- Customers
-- | customer_id | customer_name | customer_city |

-- Products
-- | product_id | product_name | supplier_id |

-- Suppliers
-- | supplier_id | supplier_name |

-- Orders
-- | order_id | customer_id |

-- Order_Details
-- | order_id | product_id |


-- 🔹 Checking for BCNF

-- Customers table
-- customer_id → customer_name, customer_city ✅
-- (customer_id is the primary key → superkey → OK)

-- Orders table
-- order_id → customer_id ✅
-- (order_id is the primary key → OK)


-- Order_Details table
-- Composite key (order_id, product_id) is primary → no issues ✅

-- Suppliers table
-- supplier_id → supplier_name ✅
-- (supplier_id is the key → OK)


-- Products table
-- product_id → product_name, supplier_id ✅ (product_id is primary key → OK)
-- BUT ⚠️ Business rule: one supplier supplies exactly one product type → means supplier_id → product_id also holds.
-- Here supplier_id is not a superkey (because primary key is product_id).


-- 👉 This violates BCNF.

-- 🔹 Converting Products Table into BCNF


-- We split Products into two relations:

-- Products
-- product_id	product_name
-- P01			Laptop
-- P02			Mobile
-- P03			Printer

-- Product_Suppliers
-- product_id	supplier_id
-- P01			S01
-- P02			S02
-- P03			S01


-- ✅ Final BCNF Design

-- Customers(customer_id, customer_name, customer_city)
-- Suppliers(supplier_id, supplier_name)
-- Products(product_id, product_name)
-- Product_Suppliers(product_id, supplier_id)
-- Orders(order_id, customer_id)
-- Order_Details(order_id, product_id)

-- 👉 Now:
-- All tables are free of partial dependency (2NF)
-- All tables are free of transitive dependency (3NF)
-- And every determinant is a superkey (BCNF) ✅



--  Query optimization & execution plans
-- 🔹 Step 1: What is an Execution Plan?

-- PostgreSQL does not just run your SQL directly.
-- It first creates a plan → decides how to fetch rows (scan whole table, use index, join strategy, etc.).

-- We can see this plan using:

-- EXPLAIN → shows the plan (estimated).
-- EXPLAIN ANALYZE → shows the real execution (actual time + rows).


--🔹 Step 2: Basic Example
EXPLAIN SELECT * FROM marks WHERE subject = 'Math';


-- 📌 Example output (without index):

-- Seq Scan on marks  (cost=0.00..25.00 rows=5 width=40)
--   Filter: (subject = 'Math')


-- 👉 PostgreSQL is doing a Sequential Scan (checks every row).
-- cost=0.00..25.00 = estimated cost range
-- rows=5 = estimated rows returned
-- Filter = condition applied



-- 🔹 Step 3: Actual Execution
EXPLAIN ANALYZE SELECT * FROM marks WHERE subject = 'Math';


-- 📌 Example output:

-- Seq Scan on marks  (cost=0.00..25.00 rows=5 width=40)
--   Filter: (subject = 'Math')
--   Rows Removed by Filter: 15
-- Planning Time: 0.05 ms
-- Execution Time: 0.12 ms


-- 👉 Now it shows real time and how many rows were actually scanned.


-- 🔹 Step 4: Optimization with Index

-- 👉 Problem: Sequential scan is slow for large tables.
-- 👉 Solution: Add index.

CREATE INDEX idx_marks_subject ON marks(subject);


-- Now check again:

EXPLAIN ANALYZE SELECT * FROM marks WHERE subject = 'Math';


-- 📌 Example output after index:

-- Index Scan using idx_marks_subject on marks  (cost=0.15..8.30 rows=5 width=40)
--   Index Cond: (subject = 'Math')
-- Planning Time: 0.06 ms
-- Execution Time: 0.03 ms


-- 👉 Much faster because it used Index Scan.


-- 🔹 Step 5: Joins Execution Plan
EXPLAIN ANALYZE
SELECT s.name, m.subject, m.score
FROM students s
JOIN marks m ON s.id = m.student_id
WHERE m.score > 80;


-- 📌 Example output:

-- Hash Join  (cost=... rows=... width=...)
--   Hash Cond: (m.student_id = s.id)
--   -> Seq Scan on marks m
--   -> Hash on students s


-- 👉 PostgreSQL used a Hash Join because it’s efficient for this dataset.


-- 🔹 Step 6: Aggregation Execution Plan
EXPLAIN ANALYZE
SELECT subject, AVG(score)
FROM marks
GROUP BY subject;


-- 📌 Example output:

-- HashAggregate  (cost=... rows=3 width=...)
--   Group Key: subject
--   -> Seq Scan on marks


-- 👉 Shows PostgreSQL is using HashAggregate (efficient grouping).


-- 🔹 Step 7: Keeping Optimizer Smart

-- Update statistics so PostgreSQL knows the table size & distribution:

ANALYZE students;
ANALYZE marks;


-- ✅ Summary Roadmap

-- 1. Use EXPLAIN → estimated plan
-- 2. Use EXPLAIN ANALYZE → real plan with timing
-- 3. Add indexes on frequently searched/joined columns
-- 4. Use joins/subqueries carefully (planner picks best)
-- 5. Run ANALYZE to refresh stats



-- 🔹 ANALYZE students; or ANALYZE marks;

-- This is not for query debugging — it’s for the query planner’s brain 🧠.
-- PostgreSQL query optimizer makes decisions (Seq Scan, Index Scan, Hash Join, etc.) based on statistics.
-- These statistics live in pg_statistic and pg_stats system tables.
-- Over time, when you INSERT, UPDATE, or DELETE a lot, those stats can get out of date.

-- 👉 ANALYZE refreshes them.
