## DDL：数据定义语言

#### 库和表的管理

- 库
  - 创建
  - 修改
  - 删除
- 表
  - 创建
  - 修改
  - 删除

#### 库的管理

- 语法

  - 创建库

  - ```mysql
    CREATE DATABASE 库名;
    # 库已存在报错解决
    CREATE DATABASE IF NOT EXISTS books;
    ```

  - 修改库

    - 修改库的字符集

    - ```mysql
      ALTER DATABASE 库名 CHARACTER SET 字符集;
      ```

  - 删除库

    - ```mysql
      DROP DATABASE 库名;
      # 库不存在报错解决
      DROP DATABASE IF EXISTS 库名;
      ```

#### 管理表

- 创建表

  - ```myql
    CREATE TABLE 表名(
    	列名 列的类型(长度) 约束
    	...
    )
    ```

- 修改表

  - 修改列名

    - ```mysql
      ALTER TABLE 表名 CHANGE COLUMN 列名 新列名 数据类型;
      ```

    - COLUMN可以删除

  - 修改列的类型或约束

    - ```mysql
      ALTER TABLE 表名 MODIFY COLUMN 列名 新类型;
      ```

    - 

  - 添加新列

    - ```mysql
      ALTER TABLE 表名 ADD COLUMN 列名 数据类型;
      ```

    - 

  - 删除列

    - ```mysql
      ALTER TABLE 表名 DROP COLUMN 列名;
      ```

  - 修改表名

    - ```mysql
      ALTER TABLE 表名 RENAME TO 新表名;
      ```

- 删除表

  - ```mysql
    DROP TABLE 表名;
    ```

- 复制表

  - 复制表的结构

    - ```mysql
      CREATE TABLE 新表名 LIKE 要复制的表名;
      ```

  - 复制表的结构和数据

    - ```mysql
      CREATE TABLE 新表名 
      SELECT * FROM 要复制的表名;
      ```

    - 在查询中添加筛选条件复制部分数据

#### 数据类型

- 数值型
  - 整数
    - Tinyint
    - Smallint
    - Mediumint
    - Int、integer
    - Bigint
    - 在类型后加UNSIGNED标识无符号整数
    - 使用ZEROFILL添加0填充，默认称为无符号整数
  - 小数
    - 定点数
      - dec、decimal
    - 浮点数
      - float
      - double
    - 指令有两个参数，参数一为整数位最大位数，参数二为小数为最大位数
  - 原则：所选类型越简单越好，能保存的数字的类型越小越好
- 字符型
  - 较短文本：char、varchar
    - char：固定长度字符
    - varchar：可变长度字符
    - binary、varbinary：类似char和varchar，包含二进制字符串
    - enum：枚举类型，要求插入的值必须属于列表中指定的值之一
    - set：与enum类似，可以保存0~64个成员，一次可以选取多个成员
  - 较长文本：text、blob（较长二进制数据）
- 日期型
  - date：年份日期
  - datetime：年份日期和时间
  - timestamp：时间戳
  - time：时间
  - year：年份

#### 常见约束

- 含义：一种限制，用于限制表中的数据，为了保证表中的数据的准确性和可靠性

- 分类
  - NOT NULL：非空
  - DEFAULT：默认值
  - PRIMARY KEY：主键，并且非空
  - qw：唯一，可为空
  - CHECK：检查约束，mysql不支持
  - FOREIGN KEY：外键
    - 要求在从表设置外键关系
    - 从表的外键列的类型和主表的关联的类型要求一致或者兼容，名称无要求
    - 主表的关联列必须是一个key（一般是主键或唯一）
    - 插入数据时，先插入主表，再插入从表
    - 删除数据时，先删除从表，再删除主表
- 添加约束的时机
  - 创建表时
  - 修改表时
- 约束的添加分类
  - 列级约束
    - 外键约束没有效果
  - 表级约束
    - 除非空、默认其余都支持
    - FOREIGN KEY(本表字段名) REFERENCES 表名(字段名)

#### 主键和唯一的对比
类型|主键|唯一
--|--|--
保证唯一性|√|√
是否允许为空|×|√
可以有多少null|最多一个|可以有对个
是否允许组合|√|√

#### 修改表时添加约束

- 添加列级约束

  - ```mysql
    ALTER TABLE 表名 MODIFY COLUMN 字段名 字段类型 新约束;
    ```

- 添加表级约束

  - ```mysql
    ALTER TABLE 表名 ADD 约束类型（字段名） 外键的引用
    ```