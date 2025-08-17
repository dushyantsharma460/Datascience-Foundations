-- CTE (Common table expression)

-- CTE is a temporary result set that you can define within a query to simplify complex SQL statement.

-- Syntax 
WITH cte_name (optional_column_list) AS (
	-- CTE query definition 
	SELECT ...
)
-- Main query referencing the CTE
SELECT ...
FROM cte_name
WHERE ...;


-- We will see example with the help of employee table
SELECT * FROM employees;

-- Now USe Case 1 :-
-- We want to calculate the average salary per department and then find all employees whose salary is above the average salary of their department.

-- You will do with many method but we first try with cte

-- CTE 
-- Cte like a single whole cmd



WITH dept_avg AS (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT e.employee_id, e.first_name, e.department, e.salary, a.avg_salary
FROM employees e
JOIN dept_avg a
  ON e.department = a.department
WHERE e.salary > a.avg_salary;


-- Using subquey

-- with join
SELECT e.employee_id, e.first_name, e.department, e.salary, d.avg_salary
FROM employees e
JOIN (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
) d
ON e.department = d.department
WHERE e.salary > d.avg_salary;


-- with where (without groupby)
SELECT e.employee_id, e.first_name, e.department, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
);


-- Window version

SELECT employee_id, first_name, department, salary, avg_salary
FROM (
    SELECT e.*,
           AVG(salary) OVER (PARTITION BY department) AS avg_salary
    FROM employees e
) 
WHERE salary > avg_salary;


-- CTE 
-- Use case 2-:
-- We want to find the highest paid employee in each department

WITH dept_max AS (
    SELECT department, MAX(salary) AS max_salary
    FROM employees
    GROUP BY department
)
SELECT e.employee_id, e.first_name, e.department, e.salary
FROM employees e
JOIN dept_max a
  ON e.department = a.department
 AND e.salary = a.max_salary;

