SET autocommit = 0;

START TRANSACTION

UPDATE `account` SET `money`=`money`-100 WHERE `name`='a'
UPDATE `account` SET `money`=`money`+100 WHERE `name`='b'

COMMIT;

ROLLBACK;

SET autocommit = 1;