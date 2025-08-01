-- Create database
CREATE DATABASE student_db;


-- Query to show all present database in psql (mysql -> SHOW DATABASES;)
-- In terminal use (\l or \list) to show database
SELECT datname FROM pg_database WHERE datistemplate = false;

-- Alternate of use database in psql (mysql -> USE student_db;)
-- \c mydb

-- Query to show current working database
SELECT current_database();


-- Query to delete current database
DROP DATABASE student_db;


-- Query to create table 
CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL DEFAULT 'No Name',
	age INT,
	email VARCHAR(100) UNIQUE,
	admission_date DATE
);
-- Query Difference in postgres and mysql 
-- |IN mysql -> id INT AUTO_INCREMENT PRIMARY KEY| 
-- |IN mysql -> id SERIAL PRIMARY KEY| 



-- Selecting all data from table 
select * from students;


-- Query for Drop the specific table
create table temp(
   id int  Primary key
)

drop table temp;


-- Show all tables in psql database (mysql -> SHOW TABLES;)
-- cmd terminal -> \dt
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- Structure of specific table in psql  (mysql -> DESCRIBE students;)
-- terminal -> \d students
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'students';


