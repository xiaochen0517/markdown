#### Mysql常见命令

- show databases;	显示所有数据库。
- use 库名;    打开指定数据库。
- show tables;    显示数据库中的表。
- show tables from 库名;    不更改打开的库，查看指定数据库中的表。
- select database();    查看当前所在的数据库。
- desc 表名;    查看指定表的结构。
- select version();    查看数据库版本
  - 在cmd中直接输入mysql --version，可以直接查看mysql版本。

#### Mysql语法规范

- 不区分大小写，但建议关键字大写，表名，列名小写。
- 每条命令最好用分号结尾。
- 每条命令根据需要可以缩进和换行。
- 注释
  - 单行注释：
    -  #开头
    - -- 后需加空格
  - 多行注释
    - /\*注释\*/

