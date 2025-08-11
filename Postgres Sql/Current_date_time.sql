-- These were give the time of client side zone
-- Query to extract current date
SELECT CURRENT_DATE;

-- Query to extract current time
SELECT CURRENT_TIME;

-- Query to extract current time stamp mean both date and time
SELECT CURRENT_TIMESTAMP;
-- or
SELECT NOW();

-- Local time and Local timestamp (mysql server time) - (Server location time)
-- Like mysql base is in USA and local time give the time according to USA server 
SELECT LOCALTIME;
SELECT LOCALTIMESTAMP;


SELECT * FROM students;

-- Add new column of timestamp 

-- In mysql 
-- ALTER TABLE students
-- ADD COLUMN date_joined DATETIME DEFAULT CURRENT_TIMESTAMP;

-- In psql
ALTER TABLE students
ADD COLUMN date_joined TIMESTAMP DEFAULT NOW();

-- Insert data
INSERT INTO students (id, name, age, email, admission_date) 
VALUES (3, 'Gouri', 12, 'gouri@gmail.com', '2012-11-08');     -- will use NOW()


INSERT INTO students (id, name, age, email, admission_date, date_joined) 
VALUES (4, 'Yashi', 13, 'yashii@gmail.com', '2011-04-28', '2025-08-11 15:40:00');    -- will use provided date

INSERT INTO students (id, age, date_joined)
VALUES (5, 56, NOW())
