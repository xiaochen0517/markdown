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

  - 

