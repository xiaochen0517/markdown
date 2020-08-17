-- 函数部分

-- 数学函数

SELECT ABS(122);

SELECT USER();

SELECT subjectname, AVG(studentresult) avg
FROM result r
INNER JOIN `subject` s
ON r.subjectno = s.subjectno
GROUP BY r.subjectno
HAVING avg>80;


CREATE TABLE 	`account` (
	`id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
	`name` VARCHAR(10) NOT NULL,
	`money` int (10),
	PRIMARY KEY (`id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO `account` (`name`, `money`) VALUES ('a', 1000),('b', 1000);


SET autocommit = 0;
START TRANSACTION UPDATE `account` SET `money`=money-100 WHERE `name`='a'

UPDATE `account` SET `money`=money+100 WHERE `name`='b'

COMMIT;
ROLLBACK;

SET autocommit = 1;