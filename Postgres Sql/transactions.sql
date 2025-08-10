select * from students;

-- Check the status of commit (mysql -> SELECT @@autocommit;)

-- Open terminal 
-- Use command -> psql -U postgres -d mydb1
-- Now enter your password

-- Now this take you inside your database

-- Check status by this command 
--\echo :AUTOCOMMIT


-- You can also diable the autocommit 
-- In mysql -> SET autocommit = 0;

-- In psql -> \set AUTOCOMMIT off  -> In terminal

-- Autocommit ON → the two inserts are permanent immediately, only the updates are in a transaction.
-- Autocommit OFF → nothing is permanent until you commit; inserts and updates are grouped together.
-- You can check these thing using ROLLBACK


-- Clear your data by this commands
DELETE FROM students;
TRUNCATE TABLE students;

-- \set AUTOCOMMIT off   -- psql client setting

INSERT INTO students (id, name, age, email, admission_date)
VALUES (1, 'manu', 20, 'manu@gmail.com', '2022-09-13');  -- not committed yet

INSERT INTO students (id, name, age, email, admission_date)
VALUES (2, 'chintu', 21, 'chintu@gmail.com', '2023-08-05'); -- not committed yet

-- Without START TRANSACTION, each statement runs and commits automatically if autocommit is on.

START TRANSACTION;
UPDATE students SET age = age + 1 WHERE id = 2; -- not committed yet
UPDATE students SET age = age - 1 WHERE id = 1; -- not committed yet
ROLLBACK;

COMMIT; -- now all 4 statements are committed together

-- COMMIT; → save all the changes in that transaction.
-- ROLLBACK; → undo all the changes in that transaction.
-- ROLLBACK and COMMIT is use when autocommit is off or use when you use when START TRANSACTION; is use(autocommit = on)


-- Now conclusion
-- If you want that previous data and update data both will save use autocommit off;(For ROLLBACK)
-- Or you can use ROLLBACK when autocommit is on it is essential that you use START TRANSACTION



-- Transaction start

-- Autocommit ON (default in psql) → Every SQL statement is its own transaction unless you explicitly START TRANSACTION.
-- Autocommit OFF → After you commit or rollback, PostgreSQL automatically starts a new transaction for the next statement.

-- Need for COMMIT

-- Autocommit ON → Not needed — each statement commits automatically unless inside an explicit transaction.
-- Autocommit OFF → Needed — changes are not saved until you COMMIT.

-- Risk of partial updates

-- Autocommit ON → High — if a later statement fails, earlier committed statements remain.
-- Autocommit OFF → Low — all statements in the transaction succeed or you can rollback entirely.

-- Control

-- Autocommit ON → Less control unless you manually start transactions.
-- Autocommit OFF → More control, since nothing is saved until you decide.

-- Typical use

-- Autocommit ON → Quick commands, ad-hoc queries.
-- Autocommit OFF → Complex operations where atomicity is important.


