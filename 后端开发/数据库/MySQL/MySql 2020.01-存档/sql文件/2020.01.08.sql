USE myemployees;

SELECT last_name, department_name
FROM employees,departments
WHERE employees.department_id = departments.department_id;

SELECT e.last_name, e.job_id, j.job_title
FROM employees e, jobs j
WHERE e.job_id=j.job_id;

SELECT last_name, department_name, commission_pct
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND commission_pct IS NOT NULL;

SELECT count(*) 个数, city
FROM departments d, locations l
WHERE d.location_id=l.location_id
GROUP BY city;

SELECT job_title, count(*) 员工个数
FROM employees e, jobs j
WHERE e.job_id = j.job_id
GROUP BY job_title
ORDER BY 员工个数 ASC;

SELECT last_name, department_name,city
FROM employees e, departments d, locations l
WHERE e.department_id=d.department_id
AND d.location_id=l.location_id;

SELECT salary, grade_level
FROM employees e, job_grades jg
WHERE salary BETWEEN jg.lowest_sal AND jg.highest_sal;

SELECT e.employee_id, e.last_name, m.employee_id, m.last_name
FROM employees e, employees m
WHERE e.manager_id=m.employee_id;

SELECT salary, grade_level
FROM employees e
JOIN job_grades jg
ON salary BETWEEN jg.lowest_sal AND jg.highest_sal;