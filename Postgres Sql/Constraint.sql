-- All Constraint NOT NULL, UNIQUE, DEFAULT, CHECK

CREATE TABLE employeestry (
    emp_id INT 
        NOT NULL 
        UNIQUE 
        PRIMARY KEY,
    
    emp_name VARCHAR(50) 
        NOT NULL,
    
    email VARCHAR(100) 
        CONSTRAINT uq_email UNIQUE,
    
    join_date DATE 
        DEFAULT (CURRENT_DATE),
    
    salary DECIMAL(10,2) 
        CONSTRAINT chk_salary CHECK (salary >= 0)
);

-- By giving name to contraint the error is according to the name -> Like chk_salary violeted

INSERT INTO employeestry (emp_id, emp_name, email, salary)
VALUES (1, 'Tori', 'tori@gmail.com', 100);

INSERT INTO employeestry (emp_id, emp_name, email, salary)
VALUES (2, 'Nori', 'nori@gmail.com', -100);