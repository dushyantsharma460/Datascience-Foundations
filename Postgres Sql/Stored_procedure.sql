SELECT * FROM employees;
SELECT first_name FROM employees;

-- Changing the delimiter
-- Creating stored procedures 
-- Stored procedures is like a function

-- Delimiter can be anything like %%,&&,##,@@



-- Im mysql

-- delimiter //
-- create procedure list_employees()

-- begin
-- 	SELECT * FROM employees;
-- 	SELECT first_name FROM employees;
-- end //

-- delimiter ;

-- call list_employees;



-- Funtion in psql
CREATE OR REPLACE FUNCTION list_employees()
RETURNS TABLE (
    employee_id INT,
    first_name VARCHAR,
    last_name VARCHAR,
    department VARCHAR,
    hire_date DATE,
    salary NUMERIC,
    is_active BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT employee_id, first_name, last_name, department, hire_date, salary, is_active
    FROM employees;
END;
$$;

SELECT * FROM list_employees();

DROP FUNCTION list_employees();

CREATE OR REPLACE FUNCTION list_employees()
RETURNS TABLE (
    employee_id INT,
    first_name VARCHAR,
    last_name VARCHAR,
    department VARCHAR,
    hire_date DATE,
    salary NUMERIC,
    is_active BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT e.employee_id, e.first_name, e.last_name, e.department, 
           e.hire_date, e.salary, e.is_active
    FROM employees e;
END;
$$;

-- Run
SELECT * FROM list_employees();


-- In psql 

-- Procedure

-- Syntax 1 ->
CREATE OR REPLACE PROCEDURE list_employees_pro()
LANGUAGE plpgsql
AS $$
BEGIN
    -- First result set
    RAISE NOTICE 'All Employees:';
    PERFORM * FROM employees; -- only logs, doesn't return
    
    -- Second result set
    RAISE NOTICE 'First Names:';
    PERFORM first_name FROM employees;
END;
$$;

CALL list_employees_pro();

-- Procedure not show the data in psql while mysql it show data 
-- In psql we call it and it only show success call


-- We can also extract and costmize data in procedure (By using raise)

CREATE OR REPLACE PROCEDURE list_employees_proc()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT first_name, last_name, salary FROM employees LOOP
        RAISE NOTICE '% % %', rec.first_name, rec.last_name, rec.salary;
    END LOOP;
END;
$$;

CALL list_employees_proc();

DROP PROCEDURE list_employees_proc();


-- New Syntax

CREATE OR REPLACE PROCEDURE get_one_employee(
    OUT fname text, 
    OUT lname text, 
    OUT sal numeric
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT first_name, last_name, salary
    INTO fname, lname, sal
    FROM employees
    WHERE employee_id = 4;
END;
$$;

CALL get_one_employee(NULL, NULL, NULL);

DROP PROCEDURE get_one_employee;


-- If you want to extract all row you not need to use out and use funtion 
CREATE OR REPLACE FUNCTION get_all_employees()
RETURNS TABLE (
    fname text,
    lname text,
    sal numeric
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT first_name::text, last_name::text, salary
    FROM employees;
END;
$$;

SELECT * FROM get_all_employees();


-- Note 
-- in PostgreSQL, a PROCEDURE cannot return multiple rows like MySQL does.

-- In MySQL,
-- CALL my_procedure(); can produce multiple result sets from SELECT statements.

-- In PostgreSQL,
-- CALL my_procedure(); can only output scalar values via OUT parameters (so one row maximum).
-- If you write SELECT inside it, you either have to store it in variables or discard it — it won’t be sent to the client.

-- If you want more than one row in PostgreSQL:

-- Use a FUNCTION with RETURNS TABLE(...) + RETURN QUERY

-- Call it with SELECT * FROM my_function();

-- So your MySQL “multi-row” procedures will need to be converted to functions in PostgreSQL.


-- Use of procedure in psql 

-- Since PostgreSQL 11, procedures exist mainly for cases where you need to run server-side logic that does not return data (or returns at most one row via OUT parameters).
-- 1. Transaction control inside server code (COMMIT; ROLLBACK;)
-- 2. Running administrative tasks (Data cleanup, bulk inserts, index maintenance, backups, etc.) Ex ->	
CREATE PROCEDURE clean_old_logs()
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM logs WHERE log_date < NOW() - INTERVAL '30 days';
    COMMIT;
END;
$$;

-- 3. Calling from external applications (Secure data)
-- Useful when an application needs to trigger a set of database changes without returning a result set.
-- Often used in automation scripts.



-- Procedure with parameter

-- You can also use argument in store preocedure
-- In mysql 

-- DELIMITER //
-- CREATE PROCEDURE get_employee_by_id(IN emp_id INT)
-- BEGIN
-- SELECT * FROM employees WHERE id = emp_id;
-- END //DELIMITER ;


-- In psql
-- Funtion 
DROP FUNCTION IF EXISTS get_employee_by_id(integer);

CREATE OR REPLACE FUNCTION get_employee_by_id(emp_id INT)
RETURNS TABLE (
    employee_id INT,
    first_name VARCHAR,
    last_name VARCHAR,
    department VARCHAR,
    hire_date DATE,
    salary NUMERIC,
    is_active BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT e.employee_id, e.first_name, e.last_name, e.department,
           e.hire_date, e.salary, e.is_active
    FROM employees e
    WHERE e.employee_id = emp_id;
END;
$$;

-- Run it
SELECT * FROM get_employee_by_id(3);


-- In psql (Procedure)
CREATE OR REPLACE PROCEDURE get_employee_by_id(
    IN emp_id INT,
    OUT employee_id INT,
    OUT first_name VARCHAR,
    OUT last_name VARCHAR,
    OUT department VARCHAR,
    OUT hire_date DATE,
    OUT salary NUMERIC,
    OUT is_active BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT e.employee_id, e.first_name, e.last_name, e.department,
           e.hire_date, e.salary, e.is_active
    INTO employee_id, first_name, last_name, department,
         hire_date, salary, is_active
    FROM employees e
    WHERE e.employee_id = emp_id
    LIMIT 1;
END;
$$;


CALL get_employee_by_id(3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


DROP PROCEDURE IF EXISTS get_employee_by_id(INT);



