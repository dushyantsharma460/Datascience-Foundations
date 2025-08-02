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


-- Check all existing table (mysql -> show tables)
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE';


-- Drop table 
DROP TABLE alienforce;


-- Drop table conditional 
DROP TABLE IF EXISTS alienforce;


