use myemployees;

SELECT * FROM employees
WHERE salary>(
	SELECT salary
    FROM employees
    WHERE last_name='Abel'
);

SELECT * 
FROM employees
WHERE department_id IN(
	SELECT DISTINCT department_id
    FROM departments
    WHERE location_id IN(1400, 1700)
);

SELECT *
FROM employees
WHERE salary=(
	SELECT max(salary)
    FROM employees
)AND employee_id=(
	SELECT min(employee_id)
    FROM employees
);

SELECT *
FROM employees
WHERE (employee_id,salary)=(
	SELECT min(employee_id), max(salary)
    FROM employees
);

SELECT d.*,(
	SELECT count(*)
    FROM employees e
    WHERE e.department_id=d.department_id
) 个数
FROM departments d;

SELECT ag_de.*, jb.grade_level
FROM (
	SELECT avg(salary) ag, department_id
	FROM employees
	GROUP BY department_id
) ag_de
INNER JOIN job_grades jb
ON ag_de.ag BETWEEN lowest_sal AND highest_sal;

SELECT department_name
FROM departments d
WHERE EXISTS(
	SELECT *
    FROM employees e
    WHERE e.department_id=d.department_id
);

SELECT department_name
FROM departments d
WHERE d.department_id in(
	SELECT e.department_id
    FROM employees e
);

SELECT * FROM employees LIMIT 0,5;