CREATE USER mochen IDENTIFIED BY '123456';

SELECT * FROM mysql.`user`;

GRANT ALL PRIVILEGES ON `school`.* TO 'mochen'@'localhost';

SHOW GRANTS FOR 'mochen'@'localhost';

REVOKE ALL PRIVILEGES ON *.* FROM 'mochen'@'localhost';

source E:/1.sql;
