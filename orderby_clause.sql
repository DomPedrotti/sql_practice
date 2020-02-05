-- copy in the contents of your exercise from the previous lesson.
USE `employees` ;

-- Modify your first query to order by first name. The first result should be Irena Reutenauer and the last result should be Vidya Simmen.
SELECT `first_name`,`last_name` 
FROM `employees`
WHERE `first_name` IN ('Irena', 'Vidya', 'Maya')
ORDER BY `first_name`;

-- Update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig.
SELECT `first_name`,`last_name` 
FROM `employees`
WHERE `first_name` IN ('Irena', 'Vidya', 'Maya')
ORDER BY `first_name`, `last_name`;

-- Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.
SELECT `first_name`,`last_name` 
FROM `employees`
WHERE `first_name` IN ('Irena', 'Vidya', 'Maya')
ORDER BY `last_name`,`first_name`;

-- Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change!
SELECt *
FROM `employees`
WHERE `first_name` like '%e%'
ORDER BY `emp_no`
;
-- Now reverse the sort order for both queries.
SELECT `first_name`,`last_name` 
FROM `employees`
WHERE `first_name` IN ('Irena', 'Vidya', 'Maya')
ORDER BY `last_name` DESC,`first_name` DESC;

SELECT *
FROM `employees`
WHERE `first_name` like '%e%'
ORDER BY `emp_no` DESC;

-- Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. It should be Khun Bernini.
SELECT * 
FROM employees
WHERE 
	year(hire_date) BETWEEN 1990 AND 1999 
	AND (month(birth_date) = 12) 
	AND (day(`birth_date`) = 25)
ORDER BY `birth_date`, `hire_date` DESC;