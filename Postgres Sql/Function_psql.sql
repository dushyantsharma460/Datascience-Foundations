-- Concat
SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) as name from employees;

-- I want to extract big length name
SELECT first_name, length(first_name) as len from employees;


-- Max length
SELECT MAX(LENGTH(first_name)) AS len FROM employees;

-- Max length name
SELECT first_name, LENGTH(first_name) AS len
FROM employees
WHERE LENGTH(first_name) = (
    SELECT MAX(LENGTH(first_name))
    FROM employees
);

-- Round off
SELECT ROUND(12.6789, 2);

-- Difference between two dates 
-- In mysql
-- SELECT DATEDIFF('2025-06-01', '2025-05-01');

-- In psql 
SELECT '2025-06-01'::date - '2025-05-01'::date AS days_diff;

-- In the form of month and days
SELECT AGE('2025-06-01', '2025-05-01');

-- EXTRACT() pulls out a specific part of a date, time, timestamp, or interval as a numeric value.

SELECT 
    first_name,
    EXTRACT(YEAR FROM AGE(NOW(), hire_date)) AS years_worked
FROM employees;

SELECT * FROM employees;


-- Char Length 
SELECT CHAR_LENGTH(' हिं दी');
SELECT CHAR_LENGTH('Hello Ji');


SELECT NOW();
SELECT DATE(NOW());


-- 1. COUNT(*)
-- Counts every row in the result set.
-- NULL values are included in the count.
-- Fastest way to get a row count.

SELECT COUNT(*) FROM employees;

-- If the table has 7 rows, the result will be 7, even if some columns are NULL.

-- 2. COUNT(column)
-- Counts only rows where that column is NOT NULL.
-- Skips rows where the column value is NULL.

SELECT COUNT(phone_number) FROM emp_personal;

-- If 2 employees have NULL phone numbers, they are not counted.
SELECT * FROM employees;
SELECT * FROM emp_personal;
