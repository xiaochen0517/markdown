## DML语言

#### 数据库操作语言

- 插入：insert
- 修改：update
- 删除：delete

#### 插入语句（一）

- 语法

  - ```mysql
    INSERT INTO 表名(列名,...)
    VALUES
    (值,...),
    ...
    ```

- 示例

  - ```mysql
    INSERT INTO beauty (name,sex,borndate,phone,photo,boyfriend_id)
    VALUES ('小泽玛利亚','女','1980-1-1',12345678901,null,1);
    ```

- 如何插入null

  - 直接插入null
  - 省略列名

- 特点

  - 可以插入多行数据
  - 支持子查询

#### 插入语句（二）

- 语法

  - ```mysql
    INSERT INTO 表名
    SET 列名=值, 列名=值...
    ```

- 特点

  - 只可以插入单行数据

### 修改语句

#### 修改单表的数据

- 语法

  - ```mysql
    UPDATE 表名
    SET 列=新值,列=新值,...
    WHERE 筛选条件;
    ```


#### 修改多表的记录

- 语法

  - 92语法

  - ```mysql
    UPDATE 表1 别名,表2 别名
    SET 列=值,...
    WHERE 连接条件
    AND 筛选条件;
    ```

  - 99语法

  - ```mysql
    UPDATE 表1 别名
    连接类型 JOIN 表2 别名
    ON 连接条件
    SET 列=值
    WHERE 筛选条件;
    ```



### 删除语句

#### DELETE

- 语法

  - 单表删除

  - ```mysql
    DELETE FROM 表名 WHERE 筛选条件
    ```

  - 多表删除

    - 92语法

    - ```mysql
      DELETE 表1的别名,表2的别名
      FROM 表1 别名,表2 别名
      WHERE 连接条件
      AND 筛选条件;
      ```

    - 99语法

    - ```mysql
      DELETE 表1的别名,表2的别名
      FROM 表1 别名
      连接条件 JOIN 表2 别名
      WHERE 筛选条件;
      ```

#### TRUNCATE

- 语法

  - ```mysql
    TRUNCATE TABLE 表名;
    # 直接删除表中的所有数据
    ```

  - 不可以加where条件

  - 不可回滚