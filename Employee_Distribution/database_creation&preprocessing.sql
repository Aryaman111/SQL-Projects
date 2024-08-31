
DROP DATABASE IF EXISTS employee_distribution;
CREATE DATABASE IF NOT EXISTS Employee_Distribution;

USE Employee_Distribution;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees
(
id VARCHAR(30) PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
birthdate DATE,
gender VARCHAR(15),
race VARCHAR(50),
department VARCHAR(40),
jobtitle VARCHAR(40),
location VARCHAR(30),
hire_date DATE,
termdate DATE,
location_city VARCHAR (30),
location_state VARCHAR (30)
);


LOAD DATA INFILE 'D:/SQL/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, first_name, last_name, @birthdate, gender, race, department, jobtitle, location, @hire_date, @termdate, location_city, location_state)
SET birthdate = 
  CASE
    WHEN @birthdate = 'NULL' THEN NULL
    WHEN @birthdate REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}$' THEN STR_TO_DATE(@birthdate, '%m/%d/%Y')
    WHEN @birthdate REGEXP '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2,4}$' THEN STR_TO_DATE(@birthdate, '%m-%d-%Y')
    ELSE NULL
  END,
hire_date = 
  CASE
    WHEN @hire_date = 'NULL' THEN NULL
    WHEN @hire_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}$' THEN STR_TO_DATE(@hire_date, '%m/%d/%Y')
    WHEN @hire_date REGEXP '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2,4}$' THEN STR_TO_DATE(@hire_date, '%m-%d-%Y')
    ELSE NULL
  END,
termdate = 
  CASE
    WHEN @termdate = 'NULL' THEN NULL
    WHEN @termdate REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}$' THEN STR_TO_DATE(@termdate, '%m/%d/%Y')
    WHEN @termdate REGEXP '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2,4}$' THEN STR_TO_DATE(@termdate, '%m-%d-%Y')
    ELSE NULL
  END;
  
  
  -- data preprocessing --
  
ALTER TABLE employees
CHANGE id emp_id VARCHAR(20);

ALTER TABLE employees
DROP COLUMN termdate;

-- Checking datatypes

SELECT column_name,data_type, is_nullable, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'employees';

-- Adding age column

ALTER TABLE employees
ADD COLUMN age INT;

UPDATE employees
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

-- Checking for age 

SELECT 
MIN(age) as min, MAX(age) as max
From employees;

SELECT COUNT(*)
from employees
where age<18;

DELETE FROM employees
WHERE age < 18;





