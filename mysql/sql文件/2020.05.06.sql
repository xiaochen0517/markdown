-- dql语言

SELECT * FROM `student`;

SELECT `studentno` AS '名字', `studentname` AS '名字' FROM `student`;

SELECT `studentno` '名字', `studentname` '名字2' FROM `student`;

SELECT `studentno` '名字', CONCAT('名字：',`studentname`) '名字2' FROM `student`;

SELECT * FROM `result`;

SELECT `studentno` FROM `result`;

SELECT DISTINCT `studentno` FROM `result`;

SELECT VERSION();

SELECT @@auto_increment_increment;

SELECT * FROM `result` WHERE `studentresult` BETWEEN 95 AND 100;

SELECT * FROM `student` WHERE `studentname` LIKE '张%';

SELECT s.studentno, studentname,subjectno,studentresult
FROM student s
RIGHT JOIN result r
ON s.studentno = r.studentno;

SELECT s.studentno, studentname,subjectname,studentresult
FROM student s
RIGHT JOIN result r
ON s.studentno = r.studentno
LEFT JOIN `subject` b
ON r.subjectno = b.subjectno;

SELECT co.pid 主科目id, co.categoryid 子科目id, ct.categoryname 主科目, co.categoryname 子科目
FROM category co
INNER JOIN category ct
ON co.pid = ct.categoryid;

SELECT * FROM result ORDER BY studentresult DESC;