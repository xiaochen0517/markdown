USE study;

CREATE TABLE IF NOT EXISTS `student`(
	`id` INT(4) NOT NULL AUTO_INCREMENT COMMENT 'id',
	`name` VARCHAR(10) NOT NULL DEFAULT '匿名' COMMENT '姓名',
	`pwd` VARCHAR(20) NOT NULL DEFAULT '123456' COMMENT '密码',
	`gender` VARCHAR(2) NOT NULL DEFAULT '男' COMMENT '性别',
	`birthday` DATETIME DEFAULT NULL COMMENT '生日',
	`address` VARCHAR(20) DEFAULT NULL COMMENT '地址',
	`email` VARCHAR(20) DEFAULT NULL COMMENT '邮箱',
	PRIMARY KEY(`id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8;

DESC `student`;

SHOW CREATE DATABASE study;
SHOW CREATE TABLE student;

-- 修改表名
ALTER TABLE `teacher` RENAME AS `teacher1`;

-- 添加字段
ALTER TABLE `teacher1` ADD `age` INT(11);

ALTER TABLE `teacher1` MODIFY `age` VARCHAR(11);

ALTER TABLE `teacher1` CHANGE `age` `age1` INT(11);

ALTER TABLE `teacher1` DROP `age1`;

DROP TABLE IF EXISTS `teacher1`;




