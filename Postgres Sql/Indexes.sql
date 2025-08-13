-- You can use Indexes for fast retrive

-- • Speed up queries that search, filter, or sort data.
-- • Improve performance for frequent lookups or joins.
-- • Enhance scalability of your database over time.

select * from employees where department = 'Engineering';
-- Before creating index it time to retrive data is nearly  100-150 ms

-- Syntax for creating an index
-- Internal implementation of index is from B TREE

-- Now create index for column department
CREATE INDEX idx on employees(department);
-- You can notice time different in big table 

-- Agar ya fast kar rha hai toh harr column pe index bna deta hai na...
-- Sideeffect -> it will fast the read operation but slow write operation


-- You can also create multi column index if your query has use mutiple columns like 
select * from employees where department = 'Engineering' AND is_active = True;

-- for this case we will use multi column indexing 
CREATE INDEX idx_eng_active on employees(department, is_active);

-- Drop your index by below query 
DROP INDEX idx_eng_active;

DROP INDEX IF EXISTS idx_eng_active;

-- Check which index is on your table
-- In mysql
-- SHOW INDEX FROM employees;

-- In psql 
SELECT indexname
FROM pg_indexes
WHERE tablename = 'employees';



-- When to use indexes 
-- • A column is often used in WHERE , JOIN , or ORDER BY clauses.
-- • You’re searching by unique fields like email , username , or ID .
-- • You’re filtering large tables for specific values regularly.
-- • You want to improve performance of lookups and joins.


-- When Not to Use Indexes
-- Avoid adding indexes when:
-- • The table is small (MySQL can scan it quickly anyway).
-- • The column is rarely used in searches or filtering.
-- • You’re indexing a column with very few unique values (like a gender field with just 'M' and 'F' ).
-- • You’re inserting or updating very frequently—indexes can slow down writes
-- because they also need to be updated.