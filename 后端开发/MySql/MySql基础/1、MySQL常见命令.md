# MySQL常见命令

## 1、数据库连接

- 语法

```mysql
mysql -u[用户名] -p[密码] # 直接使用明文密码登录
mysql -u[用户名] -p # 隐藏密码登录
```

## 2、修改用户密码

- 语法

```mysql
update mysql.user set authentication_string=password('123456') where user='root' and Host = 'localHost';
```

## 3、刷新权限

- 语法

```mysql
flush privileges;
```

## 4、查看数据库

- 语法

```mysql
show databases;
```

## 5、使用数据库

- 语法

```mysql
use [数据库名];
```

## 6、查看数据库中的表

- 语法

```mysql
show tables;
```

## 7、查看表信息

- 语法

```mysql
describe [表名];
desc [表名]; # 缩写
```

## 8、断开连接

- 语法

```mysql
quit
exit
```

  ## 9、查看创建语句

- 查看创建数据库的语句

```mysql
SHOW CREATE DATABASE [数据库名];
```

- 查看创建表的语句

```mysql
SHOW CREATE TABLE [表名];
```

