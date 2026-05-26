-- Assignment Name:  SubQueries
-- Name : Hitesh Dhoke

CREATE DATABASE Dataset;

CREATE TABLE Employee_Dataset (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(10),
    salary INT
);

INSERT INTO Employee_Dataset (emp_id, name, department_id, salary) VALUES
(101, 'Abhisek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Piya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

CREATE TABLE Department_Dataset (
    department_id VARCHAR(5) PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO Department_Dataset (department_id, department_name, location) VALUES
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bangalore'),
('D05', 'IT', 'Hyderabad');

CREATE TABLE Sales_Dataset (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE
);

INSERT INTO Sales_Dataset (sale_id, emp_id, sale_amount, sale_date) VALUES
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-03'),
(206, 106, 10500, '2025-02-06'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-12'),
(209, 109, 3900, '2025-02-16'),
(210, 110, 7200, '2025-03-01');

SELECT * FROM Employee_Dataset;
SELECT * FROM Department_Dataset;
SELECT * FROM Sales_Dataset;
_______________________________________________________________________________________________________________________________________________________
--Basic Level

-- Q.1 Retrieve the names of employees who earn more than the average salary of all employees.
ANS:
SELECT name, salary
FROM Employee_Dataset
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee_Dataset
);
____________________________________________________________________________________________________________________________
-- Q.2 Find the employees who belong to the department with the highest average salary.
ANS:
SELECT name
FROM Employee_Dataset
WHERE department_id = (
    SELECT department_id
    FROM Employee_Dataset
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);
______________________________________________________________________________________________________________________________
-- Q.3 List all employees who have made at least one sale.
ANS:
SELECT DISTINCT e.name
FROM Employee_Dataset e
JOIN Sales_Dataset s
ON e.emp_id = s.emp_id;
______________________________________________________________________________________________________________________________
-- Q.4 Find the employee with the highest sale amount.
ANS:
SELECT e.name, s.sale_amount
FROM Employee_Dataset e
JOIN Sales_Dataset s
ON e.emp_id = s.emp_id
WHERE s.sale_amount = (
    SELECT MAX(sale_amount)
    FROM Sales_Dataset
);
_______________________________________________________________________________________________________________________________
-- Q.5 Retrieve the names of employees whose salaries are higher than Shubham’s salary.
ANS:
SELECT name
FROM Employee_Dataset
WHERE salary > (
    SELECT salary
    FROM Employee_Dataset
    WHERE name = 'Shubham'
);
____________________________________________________________________________________________________________________________________________
--Intermediate Level
-- Q.1 Find employees who work in the same department as Abhishek.
ANS:
SELECT name
FROM Employee_Dataset
WHERE department_id = (
    SELECT department_id
    FROM Employee_Dataset
    WHERE name = 'Abhisek'
)
AND name <> 'Abhisek';
___________________________________________________________________________________________________________________________________________
-- Q.2 List departments that have at least one employee earning more than ₹60,000.
ANS:
SELECT DISTINCT d.department_name
FROM Department_Dataset d
JOIN Employee_Dataset e
ON d.department_id = e.department_id
WHERE e.salary > 60000;
_____________________________________________________________________________________________________________________________________________
-- Q.3 Find the department name of the employee who made the highest sale.
ANS:

SELECT d.department_name
FROM Department_Dataset d
JOIN Employee_Dataset e
ON d.department_id = e.department_id
JOIN Sales_Dataset s
ON e.emp_id = s.emp_id
WHERE s.sale_amount = (
    SELECT MAX(sale_amount)
    FROM Sales_Dataset
);
__________________________________________________________________________________________________________________________________________
-- Q.4 Retrieve employees who have made sales greater than the average sale amount.
ANS:
SELECT e.name, s.sale_amount
FROM Employee_Dataset e
JOIN Sales_Dataset s
ON e.emp_id = s.emp_id
WHERE s.sale_amount > (
    SELECT AVG(sale_amount)
    FROM Sales_Dataset
);
___________________________________________________________________________________________________________________________________________
-- Q.5 Find the total sales made by employees who earn more than the average salary.
ANS:
SELECT SUM(s.sale_amount) AS total_sales
FROM Sales_Dataset s
JOIN Employee_Dataset e
ON s.emp_id = e.emp_id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM Employee_Dataset
);
_________________________________________________________________________________________________________________________________________
--Advanced Level
-- Q.1 Find employees who have not made any sales.
ANS:
SELECT name
FROM Employee_Dataset
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM Sales_Dataset
);
_____________________________________________________________________________________________________________________________________________
-- Q.2 List departments where the average salary is above ₹55,000.
ANS:
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM Department_Dataset d
JOIN Employee_Dataset e
ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 55000;
_____________________________________________________________________________________________________________________________________________
-- Q.3 Retrieve department names where the total sales exceed ₹10,000.
ANS: 
SELECT d.department_name, SUM(s.sale_amount) AS total_sales
FROM Department_Dataset d
JOIN Employee_Dataset e
ON d.department_id = e.department_id
JOIN Sales_Dataset s
ON e.emp_id = s.emp_id
GROUP BY d.department_name
HAVING SUM(s.sale_amount) > 10000;
_________________________________________________________________________________________________________________________________________
-- Q.4 Find the employee who has made the second-highest sale.
ANS:
SELECT e.name, s.sale_amount
FROM Employee_Dataset e
JOIN Sales_Dataset s
ON e.emp_id = s.emp_id
WHERE s.sale_amount = (
    SELECT MAX(sale_amount)
    FROM Sales_Dataset
    WHERE sale_amount < (
        SELECT MAX(sale_amount)
        FROM Sales_Dataset
    )
);
________________________________________________________________________________________________________________________________________
-- Q.5 Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
ANS: 
SELECT name
FROM Employee_Dataset
WHERE salary > (
    SELECT MAX(sale_amount)
    FROM Sales_Dataset
);

							*END*






























































