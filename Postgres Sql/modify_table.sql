-- Query for create a table
CREATE TABLE ben10 (
    alien_id SERIAL PRIMARY KEY,
    alien_name VARCHAR(100) NOT NULL,
    species VARCHAR(100),
    planet VARCHAR(100),
    first_appearance DATE,
    abilities TEXT
);


-- Rename the table (mysql -> RENAME TABLE ben10 TO alienforce;)
ALTER TABLE ben10 RENAME TO alienforce;


-- Check all existing table (mysql -> show tables;)
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE';


-- Drop table 
DROP TABLE alienforce;


-- Drop table conditional 
DROP TABLE IF EXISTS alienforce;


-- Describe table (in terminal -> \d alienforce)  (in mysql ->  DESCRIBE alienforce;  or DESC alienforce;)
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'alienforce';


-- Rename column of a table
ALTER TABLE alienforce RENAME COLUMN first_appearance to finding_date;


-- Query to delete column from table 
ALTER TABLE alienforce DROP COLUMN species;


-- Query to add new column (BOOL  or BOOLEAN)
ALTER TABLE alienforce ADD COLUMN is_ultimate BOOL DEFAULT TRUE;


-- Modify your DATATYPE and CONSTRAINT(ALTER TABLE alienforce MODIFY COLUMN alien_name VARCHAR(150) NOT NULL UNIQUE DEFAULT 'om';)
ALTER TABLE alienforce 
  ALTER COLUMN alien_name TYPE VARCHAR(50),
  ALTER COLUMN alien_name SET NOT NULL,
  ALTER COLUMN alien_name SET DEFAULT 'om';

ALTER TABLE alienforce 
  ADD CONSTRAINT unique_name UNIQUE (alien_name);
-- Difference in NOT NULL |  UNIQUE  |  PRIMARY KEY
-- NOT NULL IS COLUMN RELATED CONTRAINT
-- WHILE BOTH OF THIS ARE TABLE RELATED CONTRAINT
-- ADD CONSTRAINT pk PRIMARY KEY (alien_name);
-- ALTER TABLE alienforce ALTER COLUMN alien_name DROP NOT NULL;


-- Also set the order of column in mysql
-- ALTER TABLE alienforce MODIFY COLUMN alien_id SERIAL AFTER abilities;




