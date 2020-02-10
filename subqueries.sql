use employees;

-- Find all the employees with the same hire date as employee 101010 using a sub-query. 69 Rows
SELECT * FROM employees
WHERE hire_date in (
	SELECT hire_date FROM employees
	WHERE emp_no = 101010
	);
-- Find all the titles held by all employees with the first name Aamod. 314 total titles, 6 unique titles
SELECT title, count(*) FROM employees
LEFT JOIN titles
using(emp_no)
WHERE first_name like 'aamod'
GROUP BY title;
-- How many people in the employees table are no longer working for the company?
SELECT emp_no 
FROM employees 
WHERE emp_no IN (
SELECT emp_no FROM dept_emp
WHERE to_date < now());

-- Find all the current department managers that are female.
/* 
+------------+------------+
| first_name | last_name  |
+------------+------------+
| Isamu      | Legleitner |
| Karsten    | Sigstam    |
| Leon       | DasSarma   |
| Hilary     | Kambil     |
+------------+------------+ */
SELECT first_name, last_name FROM employees
WHERE emp_no IN(
	SELECT emp_no FROM `dept_manager`
	WHERE to_date > now()
	)
AND gender like 'f';

-- Find all the employees that currently have a higher than average salary. 154543 rows in total. Here is what the first 5 rows will look like:
/* 
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Georgi     | Facello   | 88958  |
| Bezalel    | Simmel    | 72527  |
| Chirstian  | Koblick   | 74057  |
| Kyoichi    | Maliniak  | 94692  |
| Tzvetan    | Zielinski | 88070  |
+------------+-----------+--------+ */
SELECT * 
FROM employees
JOIN salaries
USING(emp_no)
WHERE to_date > now() AND salary > (
	SELECT avg(salary) FROM salaries)
;
-- How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this? 78 salaries
SELECT *
FROM salaries
where salary > (
	SELECT max(salary) - STD(salary) FROM salaries) 
AND to_date > now()

