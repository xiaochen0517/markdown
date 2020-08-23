# MySQL备份

# 1、命令行导出

```bash
mysqldump -h[地址] -u[用户名] -p [数据库名] [表名] > [导出路径]
```

- 示例

```bash
mysqldump -hlocalhost -uroot -p school > E:/1.sql
```

## 2、导入数据库

```mysql
source [文件路径];
```

```mysql
mysql -u[用户名] -p[密码] [数据库名] < [备份文件路径];
```

