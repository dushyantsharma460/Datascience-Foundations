-- When UNION Works

-- 1. Same number of columns in all SELECT statements.
-- 2. Compatible data types in corresponding columns.
-- 3. Columns will be matched by position, not by name.


-- Example 
SELECT student_id FROM marks
UNION
SELECT id FROM students;


-- Now we tries to understand with different example

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    hire_date DATE,
    salary NUMERIC(10, 2),
    is_active BOOLEAN
);

INSERT INTO employees 
(first_name, last_name, department, hire_date, salary, is_active) 
VALUES
('Alice', 'Johnson', 'Engineering', '2020-03-15', 75000.00, TRUE),
('Bob', 'Smith', 'Marketing', '2019-07-01', 68000.00, TRUE),
('Charlie', 'Davis', 'Finance', '2021-01-20', 72000.00, TRUE),
('Dana', 'Lee', 'Human Resources', '2018-11-05', 66000.00, FALSE),
('Evan', 'Taylor', 'Engineering', '2022-06-10', 80000.00, TRUE),
('Fiona', 'Clark', 'Sales', '2023-02-25', 62000.00, TRUE),
('George', 'Wright', 'IT Support', '2017-09-12', 59000.00, FALSE);


SELECT * FROM employees;



-- New table with same data size
CREATE TABLE emp_personal (
    personal_id SERIAL PRIMARY KEY,
    employee_id INT,
    date_of_birth DATE,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    marital_status VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

INSERT INTO emp_personal 
(employee_id, date_of_birth, phone_number, email, address, marital_status) 
VALUES
(1, '1990-05-21', '555-1234', 'alice.johnson@example.com', '123 Elm St, Springfield', 'Single'),
(2, '1987-09-14', '555-5678', 'bob.smith@example.com', '456 Oak St, Springfield', 'Married'),
(3, '1992-11-02', '555-8765', 'charlie.davis@example.com', '789 Pine St, Springfield', 'Single'),
(4, '1985-03-30', '555-2345', 'dana.lee@example.com', '321 Maple St, Springfield', 'Married'),
(5, '1995-08-10', '555-3456', 'evan.taylor@example.com', '654 Cedar St, Springfield', 'Single'),
(6, '1998-12-25', '555-9876', 'fiona.clark@example.com', '987 Birch St, Springfield', 'Single'),
(7, '1983-04-18', '555-1122', 'george.wright@example.com', '159 Walnut St, Springfield', 'Divorced');


SELECT * FROM employees;
SELECT * FROM emp_personal;


-- Union remove duplicate row
SELECT first_name, last_name FROM employees
UNION
SELECT email, address FROM emp_personal;

-- Giving jumble data 

SELECT first_name, last_name FROM employees
UNION
SELECT email, address FROM emp_personal
ORDER BY 1;  -- sorts by first column

-- Union don't work when the number of column is different
-- Union donlt work when the data type mismatch -> I use only string in my union so work proper


-- Union all (union all don't jumble the data) (Union all don't remove duplicate row)
SELECT first_name, last_name FROM employees
UNION ALL
SELECT email, address FROM emp_personal;


