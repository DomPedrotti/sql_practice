-- use the employees database
use employees;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
SELECT `first_name`,`last_name` 
FROM `employees`
WHERE `first_name` IN ('Irena', 'Vidya', 'Maya');

-- Find all employees whose last name starts with 'E' — 7,330 rows.
SELECT `first_name`, `last_name`
FROM `employees`
WHERE `last_name` like 'E%';

-- Find all employees hired in the 90s — 135,214 rows.
SELECT * 
FROM employees
WHERE year(hire_date) BETWEEN 1990 AND 1999;

-- Find all employees born on Christmas — 842 rows.
SELECT * 
FROM employees
WHERE (month(birth_date) = 12) AND (day(`birth_date`) = 25);

-- Find all employees with a 'q' in their last name — 1,873 rows.
SELECT * 
FROM employees
WHERE `last_name` LIKE '%q%';

-- Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
SELECT `first_name`,`last_name` 
FROM `employees`
WHERE `first_name` = 'Irena' or `first_name` = 'Vidya' or `first_name` = 'Maya';

-- Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
SELECT `first_name`,`last_name`, `gender` 
FROM `employees`
WHERE `gender` = 'M' AND (`first_name` = 'Irena' OR `first_name` = 'Vidya' OR `first_name` = 'Maya');

-- Find all employees whose last name starts or ends with 'E' — 30,723 rows.
SELECT `first_name`, `last_name`
FROM `employees`
WHERE `last_name` like 'e%' or `last_name` like '%e';

-- Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
SELECT `first_name`, `last_name`
FROM `employees`
WHERE `last_name` like 'e%e';

-- Find all employees hired in the 90s and born on Christmas — 362 rows.
SELECT * 
FROM employees
WHERE 
	year(hire_date) BETWEEN 1990 AND 1999 
	AND (month(birth_date) = 12) 
	AND (day(`birth_date`) = 25)
;
-- Find all employees with a 'q' in their last name but not 'qu' — 547 rows.
SELECT * 
FROM `employees`
WHERE `last_name` like '%q%' and `last_name` NOT LIKE '%qu%'