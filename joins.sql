-- Use the join_example_db. Select all the records from both the users and roles tables.
USE `join_example_db`;

SELECT * FROM roles;
SELECT * FROM users;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT * 
FROM roles
JOIN users
ON roles.id = users.`role_id`;

SELECT * 
FROM roles
LEFT JOIN users
ON roles.id = users.`role_id`;

SELECT * 
FROM roles
RIGHT JOIN users
ON roles.id = users.`role_id`;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name, COUNT(*)
FROM roles
RIGHT JOIN users
on roles.id = users.role_id
GROUP BY roles.id;

-- Use the employees database.
use employees;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
/* 
  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang */
SELECT `departments`.dept_name as Department_Name, concat(employees.first_name, ' ', employees.`last_name`) as Manager_Name
FROM departments
JOIN dept_manager
USING(dept_no)
JOIN `employees`
USING(emp_no)
WHERE to_date > now()
ORDER BY Department_Name;

-- Find the name of all departments currently managed by women.
/* 
Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil */
SELECT `departments`.dept_name as Department_Name, concat(employees.first_name, ' ', employees.`last_name`) as Manager_Name
FROM departments
JOIN dept_manager
USING(dept_no)
JOIN `employees`
USING(emp_no)
WHERE to_date > now() and employees.gender like 'f'
ORDER BY Department_Name;

-- Find the current titles of employees currently working in the Customer Service department.
/* 
Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241 */
SELECT titles.title, count(*)
FROM employees
join dept_emp
using(emp_no)
join departments
using(dept_no)
join titles
using(emp_no)
WHERE (departments.dept_name like 'customer service') and (titles.to_date > now())
GROUP BY titles.title;

-- Find the current salary of all current managers.
/* 
Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987 */

SELECT `departments`.dept_name as Department_Name, concat(employees.first_name, ' ', employees.`last_name`) as Manager_Name, salaries.salary as Salary
FROM departments
JOIN dept_manager
USING(dept_no)
JOIN `employees`
USING(emp_no)
JOIN salaries
using(`emp_no`)
WHERE dept_manager.to_date > now() and salaries.to_date > now()
ORDER BY Department_Name;

-- Find the number of employees in each department.
/* 
+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+ */
SELECT dept_no, dept_name, count(*) 
FROM departments
join `dept_emp`
using(dept_no)
join `employees`
using(emp_no)
WHERE to_date > now()
GROUP BY dept_no, dept_name;

-- Which department has the highest average salary?
/* 
+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+ */
SELECT dept_name, AVG(salaries.salary) as average_salary
FROM departments
JOIN dept_emp
USING(dept_no)
JOIN salaries
USING(emp_no)
WHERE salaries.to_date > now()
GROUP BY dept_name
ORDER BY average_salary DESC;

-- Who is the highest paid employee in the Marketing department?
/* 
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+ */
SELECT first_name, last_name
FROM employees
JOIN dept_emp
USING(emp_no)
JOIN departments
USING(dept_no)
join salaries
USING(emp_no)
where salaries.to_date > now() and dept_name like 'marketing'
ORDER BY salary DESC;

-- Which current department manager has the highest salary?
/* 
+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+ */
SELECT `departments`.dept_name as Department_Name, concat(employees.first_name, ' ', employees.`last_name`) as Manager_Name, salaries.salary as Salary
FROM departments
JOIN dept_manager
USING(dept_no)
JOIN `employees`
USING(emp_no)
JOIN salaries
using(`emp_no`)
WHERE dept_manager.to_date > now() and salaries.to_date > now()
ORDER BY Salary DESC;

-- Bonus Find the names of all current employees, their department name, and their current manager's name. 240,124 Rows
/* 
Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman */
-- Current Managers query
SELECT concat(`first_name`, ' ', `last_name`) as Employee_Name, `dept_name`as Department_Name, managers.Manager_Name
FROM `employees`
join dept_emp
using(emp_no)
join departments
using(dept_no)
join(
    SELECT `departments`.dept_name, concat(employees.first_name, ' ', employees.`last_name`) as Manager_Name
    FROM departments
    JOIN dept_manager
    USING(dept_no)
    INNER JOIN `employees`
    USING(emp_no)
    WHERE to_date > now()
    ORDER BY dept_name
) as managers
USING(dept_name)
where dept_emp.to_date > now()

-- Bonus Find the highest paid employee in each department.
SELECT first_name, last_name, dept_name, top_salaries.salary
FROM employees
join salaries
using(emp_no)
JOIN
(
    SELECT dept_name,max(salary) as salary
    from employees
    join salaries
    using(emp_no)
    join dept_emp
    using(emp_no)
    join departments
    using(dept_no)
    WHERE salaries.to_date > now()
    GROUP BY dept_name
) as top_salaries
using(salary);