CREATE DATABASE jdbcStudy CHARACTER SET utf8 COLLATE utf8_general_ci;

USE jdbcStudy;

CREATE TABLE `users`(
id INT PRIMARY KEY,
NAME VARCHAR(40),
PASSWORD VARCHAR(40),
email VARCHAR(60),
birthday DATE
);

INSERT INTO `users`(id,NAME,PASSWORD,email,birthday)
VALUES(1,'zhansan','123456','zs@sina.com','1980-12-04'),
(2,'lisi','123456','lisi@sina.com','1981-12-04'),
(3,'wangwu','123456','wangwu@sina.com','1979-12-04')


ALTER TABLE `users` MODIFY `id` INT(11) AUTO_INCREMENT;


CREATE TABLE IF NOT EXISTS `user`(
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(20) NOT NULL UNIQUE,
    `password` VARCHAR(30) NOT NULL,
    `tel` VARCHAR(11),
    `email` VARCHAR(20),
    PRIMARY KEY (`id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8;

SHOW CREATE TABLE `user`;


-- 插入数据
INSERT INTO `user` (`username`, `password`) VALUES ('lxc5', '123456');

-- 删除数据
DELETE FROM `user` WHERE `id` = 1;

-- 修改数据
UPDATE `user` SET `password` = '1234' WHERE `id` = 3;
UPDATE `user` SET `birthday` = '2020-01-01 00:00';

-- 查询数据
SELECT * FROM `user` WHERE `password` LIKE '%345%';

-- 修改表
ALTER TABLE `user` ADD `birthday` VARCHAR(10) NOT NULL DEFAULT 'a';

ALTER TABLE `user` MODIFY `birthday` VARCHAR(20) NOT NULL DEFAULT '2020-01-01 00:00';

ALTER TABLE `user` MODIFY `birthday` DATETIME NOT NULL DEFAULT '2020-01-01 00:00';

ALTER TABLE `user` RENAME TO `users`;

ALTER TABLE `users` DROP `email`;