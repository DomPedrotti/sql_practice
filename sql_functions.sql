-- Copy the order by exercise.
USE employees;

-- Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT concat(`first_name`,' ',`last_name`) as `full_name`
FROM `employees`
WHERE `first_name` like '%e%'
ORDER BY `emp_no`;

-- Convert the names produced in your last query to all uppercase.
SELECT upper(concat(`first_name`,' ',`last_name`)) as `full_name`
FROM `employees`
WHERE `first_name` like '%e%'
ORDER BY `emp_no`;

-- For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
SELECT 
	upper(concat(`first_name`,' ',`last_name`)) as `full_name`, 
	datediff(now(),hire_date)
FROM `employees`
WHERE `first_name` like '%e%'
ORDER BY `emp_no`;
 
-- Find the smallest and largest salary from the salaries table.
select *
from salaries
ORDER BY salary DESC
LIMIT 1;

select *
from salaries
ORDER BY salary ASC
LIMIT 1;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born.
SELECT LOWER(
	   		 CONCAT( 
			  		SUBSTR(`first_name`,1,1),
			  		SUBSTR(`last_name`, 1,4),
			  		'_',
			  		MONTH(`birth_date`),
			  		SUBSTR(YEAR(`birth_date`), 3)
			  		)
			 ) as username
FROM `employees`
