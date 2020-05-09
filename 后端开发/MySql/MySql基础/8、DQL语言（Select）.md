# DQL语言（Select）

**Data Query Language：数据查询语言**

> 数据库中最核心最重要的语言，同时使用频率也是最高的。

- 语法

```mysql
SELECT[ALL|DISTINCT|DISTINCTROW|TOP]
{*|talbe.*|[table.]field1[AS alias1][,[table.]field2[AS alias2][,…]]}
FROM tableexpression[,…][IN externaldatabase]
[WHERE…]
[GROUP BY…]
[HAVING…]
[ORDER BY…]
[WITH OWNERACCESS OPTION]
```

## 1、指定查询字段

### 1.1、查询所有字段

- 语法

```mysql
SELECT * FROM [表名];
```

### 1.2、查询指定字段

- 语法

```mysql
SELECT [字段名1], [字段名2], ... FROM [表名]
```

> 可以在查询的字段名后使用as关键字创建别名，例：`[字段名] AS [别名]`，as关键字也可以省略。

## 2、数据处理

### 2.1、查询结果拼接字符串

- 语法

```mysql
SELECT CONCAT([要添加的字符串], [字段名]), ... FROM [表名]
```

### 2.2、数据去重

- 语法

```mysql
SELECT DISTINCT [字段名], ... FROM [表名]
```

### 2.3、查询函数

```mysql
SELECT VERSION();
```

### 2.4、表达式查询

```mysql
SELECT 100-50;
```

### 2.5、查询变量

```mysql
SELECT @@auto_increment_increment;
```

### 2.6、批量操作查询的数据

- 语法

```mysql
SELECT [字段名][表达式] FROM [表名];
```

## 4、联表查询

| 操作       | 描述                                       |
| ---------- | ------------------------------------------ |
| Inner join | 如果表中至少有一个匹配，就返回行           |
| left join  | 会从左表中返回所有的值，即使右表中没有匹配 |
| right join | 会从右表中返回所有的值，即使左表中没有匹配 |

- 语法

```mysql
SELECT [字段名], ... FROM [表名] [连接方式] JOIN [连接的表] ON [条件] WHERE [条件]
```

> 自连接：一张表自己和自己连接

## 5、分页和排序

### 5.1、排序

- 语法

```mysql
... ORDER BY [字段名] [ASC/DESC]
```

> ASC：升序
>
> DESC：降序

### 5.2、分页

- 语法

```mysql
... LIMIT [起始条数],[结束条数];
```



