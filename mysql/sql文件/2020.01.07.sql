use myemployees;

show tables;

SELECT * FROM employees ORDER BY salary DESC;

SELECT last_name,department_id,salary*12*(1+ ifnull(commission_pct, 0)) 年薪 
FROM employees 
ORDER BY 年薪 desc, last_name asc;

SELECT length("Hello world!");

SELECT trim('a' FROM "aaabbbaa") astr;

SELECT datediff(now(), '2000-05-17');

SELECT count(salary), department_id
FROM employees
GROUP BY department_id;