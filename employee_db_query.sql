-- Query 1)What is the Gender breakdown of employees in the Company?

SELECT gender, COUNT(*) FROM employees
GROUP BY gender;

-- Query 2)What is the race/ethinicity breakdown of employees in the company?


SELECT race, COUNT(*) AS Total FROM employees
GROUP BY race
ORDER BY Total desc;


-- Query 3)Age distribution of employess in the Company?

SELECT
	CASE WHEN age>=18 AND age<=24 THEN '18-24'
		 WHEN age>=25 AND age<=34 THEN '25-34'
	     WHEN age>=35 AND age<=44 THEN '35-44'
		 WHEN age>=45 AND age<=54 THEN '45-54'
		 WHEN age>=55 AND age<=64 THEN '55-64'
		 ELSE '65+'
	 END AS age_group, gender,
	 COUNT(*) AS Count
FROM employees
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- Query 4)How many employees work at headquaters versus remote locations?


SELECT location,gender, COUNT(*) AS Count
FROM employees
GROUP BY location,gender
ORDER BY location,gender;

-- Query 5)How does the gender distribution vary across departments and job titles?


SELECT department, gender, COUNT(*) AS COUNT
FROM employees
GROUP BY 1,2
ORDER BY 1;

-- Query 6)What is the Job titles across the company?

SELECT jobtitle, COUNT(*) AS EMP_COUNT
FROM employees
GROUP BY jobtitle
ORDER BY EMP_COUNT DESC;

-- Query 7)What is the distribution of employees across locations by city and state?


SELECT location_state, COUNT(*) AS COUNT
FROM employees
GROUP BY 1
ORDER BY count DESC;

-- Query 8) How many employees from each birthyear in the organisation?

SELECT YEAR(birthdate) AS extracted_year,COUNT(*) AS emp_count
FROM employees
GROUP BY extracted_year
ORDER BY extracted_year desc;



