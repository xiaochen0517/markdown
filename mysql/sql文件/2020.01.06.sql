SELECT last_name,salary,email FROM employees;

select version();

SELECT last_name AS 姓, first_name AS 名 FROM employees;

SELECT DISTINCT department_id FROM employees;

SELECT CONCAT(last_name,"\'", first_name) as 姓名 FROM employees;

SELECT IFNULL(commission_pct, 0) FROM employees;

SELECT * FROM employees WHERE salary>12000;

SELECT * FROM employees WHERE salary>=10000 AND salary<=10000;

SELECT * FROM employees WHERE first_name LIKE '%a%';

SELECT * FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$';

SELECT * FROM employees WHERE salary BETWEEN 10000 AND 20000;

SELECT * FROM employees WHERE job_id IN('IT_PROG', 'AD_VP', 'AD_PRES');

SELECT * FROM employees WHERE commission_pct IS NULL;