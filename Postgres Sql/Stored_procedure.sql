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


-- In psql 

-- Procedure
DROP PROCEDURE list_employees_proc();

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


DROP PROCEDURE get_one_employee;
-- New Syntax

CREATE OR REPLACE PROCEDURE get_one_employee(OUT fname text, OUT lname text, OUT sal numeric)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT first_name, last_name, salary
    INTO fname, lname, sal
    FROM employees;
END;
$$;

CALL get_one_employee(NULL, NULL, NULL);


-- You can also use argument in store preocedure
-- In mysql 
-- DELIMITER //
-- CREATE PROCEDURE get_employee_by_id(IN emp_id INT)
-- BEGIN
-- SELECT * FROM employees WHERE id = emp_id;
-- END //DELIMITER ;

-- In psql
CREATE OR REPLACE FUNCTION get_employee_by_id(emp_id INT)
RETURNS TABLE(employee_id INT, first_name TEXT, last_name TEXT, salary NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM employees
    WHERE employee_id = emp_id;
END;
$$ LANGUAGE plpgsql;

-- Run it:
SELECT * FROM get_employee_by_id(3);


