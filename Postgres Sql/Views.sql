SELECT * FROM employees;

-- (365 + 365 + 365 + 366) ÷ 4 = 365.25 days
-- EPOCH is a unit that represents time in seconds
SELECT first_name, ROUND(EXTRACT(EPOCH FROM (NOW() - hire_date)) / (365.25 * 24 * 60 * 60), 2) AS years_worked FROM employees;

SELECT first_name, EXTRACT(YEAR FROM AGE(NOW(), hire_date)) AS years_worked FROM employees;
-- If i want to use working years of employees i will write this code every time.

-- To solve this problem sql give view for this (view is like virtual table)


-- Syntax to create view
CREATE VIEW dushyant AS
SELECT first_name, EXTRACT(YEAR FROM AGE(NOW(), hire_date)) AS years_worked 
FROM employees;

-- Now i will use this view like a table
SELECT * FROM dushyant;
-- I created view from employees table and view data is uptodate if i change data in employees it will reflect the change in my view also.

-- You can also select view conditional
SELECT * FROM dushyant WHERE years_worked > 5;

-- You can also update existing view
CREATE OR REPLACE VIEW dushyant AS
SELECT 
    first_name,
    last_name,
    ROUND(EXTRACT(EPOCH FROM (NOW() - hire_date)) / (365.25 * 24 * 60 * 60), 2) AS years_worked
FROM employees;

-- Above query giving error because we can't change the swquence of the view
CREATE OR REPLACE VIEW dushyant AS
SELECT 
    first_name,
    ROUND(EXTRACT(EPOCH FROM (NOW() - hire_date)) / (365.25 * 24 * 60 * 60), 2) AS years_worked,
    last_name
FROM employees;

DROP VIEW IF EXISTS public_speaker;

