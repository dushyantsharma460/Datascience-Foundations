SELECT * FROM employees;

-- I want to group the department engineering, marketing and use aggregate funtion
SELECT department, count(*) AS total_employees
FROM employees
GROUP BY department;	


-- You can also group by two column 
SELECT department, is_active, avg(salary) AS total_employees
FROM employees
GROUP BY department, is_active;

SELECT * FROM employees;


-- Above example can't be able to understand second group by use 
-- Ex:-
-- | department | is\_active | salary |
-- | ---------- | ---------- | ------ |
-- | Sales      | 1          | 50000  |
-- | Sales      | 1          | 60000  |
-- | Sales      | 0          | 30000  |
-- | HR         | 1          | 40000  |
-- | HR         | 0          | 35000  |


-- Res:-
-- | department | is\_active | avg(salary) |
-- | ---------- | ---------- | ----------- |
-- | Sales      | 1          | 55000       |
-- | Sales      | 0          | 30000       |
-- | HR         | 1          | 40000       |
-- | HR         | 0          | 35000       |


-- Having Clause 

-- For condition filtering in grouping we use having 
SELECT department, is_active, AVG(salary) AS total_employees
FROM employees
GROUP BY department, is_active
HAVING AVG(salary) > 63000;


-- Departments with more than 5 employees
SELECT department, COUNT(*) AS total
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;


-- Roll up (average of average)
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY ROLLUP(department);

SELECT department, SUM(salary) AS total_employees
FROM employees
GROUP BY ROLLUP(department);

-- Sum come at last
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY ROLLUP(department)
ORDER BY department NULLS LAST;

-- Double group by roll up
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY ROLLUP(department, is_active)
ORDER BY department NULLS LAST;

