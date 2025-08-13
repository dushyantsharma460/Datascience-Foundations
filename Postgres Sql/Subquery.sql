SELECT * FROM employees; 

-- I want the query salary is greater than average salary 
SELECT first_name, last_name, salary FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT * FROM employees;

-- Now i want the salary is based on the department average 
SELECT first_name, last_name, salary FROM employees e
WHERE salary > (
	SELECT AVG(salary) FROM employees where department = e.department
);
