# MySQL常用函数

## 1、基本函数

### 1.1、数学运算

```mysql
ABS(num)：绝对值
SEILING(num)：向上取整
FLOOR(num)：向下取整
RAND()：返回0~1之间的随机数
SIGN()：判断一个数的符号
```

### 1.2、字符串函数

```mysql
CHAR_LENGTH(str)：返回字符串长度
CONCAT(str1, str2, ...)：拼接字符串
INSERT(str, pos, len, newstr)：查询替换
LOWER(str)：转小写
UPPER(str)：转大写
INSTR(str1, str2)：str2在str1中首次出现的位置
REPLACE(str, from_str, to_str)：将str中的from_str替换为to_str
SUBSTR(str, pos, lenl)：截取指定字符串
REVERSE(str)：翻转字符串
```

### 1.3、时间和日期函数

```mysql
CURRENT_DATE()：获取当前日期
CURDATE()：获取当前日期
NOW()：获取当前时间
LOCALTIME()：获取本地时间
SYSDATE()：获取系统时间
```

### 1.4、系统信息

```mysql
SYSTEM_USER()：当前用户
USER()：同上
VERSION()：版本
```

## 2、聚合函数

```mysql
COUNT()：计数
SUM()：求和
AVG()：平均值
MAX()：最大值
MIN()：最小值
```

