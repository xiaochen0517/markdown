## Java Web三层架构项目

#### 需求

- 用户信息的增删改查操作

#### 设计

- 技术选型：Servlet+JSP+MySQL+JDBCTempleat+Duird+BeanUtilS+Tomcat

- 数据库设计

  - ```mysql
    create database study1; # 创建数据库
    
    use study1; # 使用数据库
    
    create table user(
    	id int primary key auto_increment, # id主键
        name varchar(20) not null, # 姓名
        gender varchar(5), # 性别
        age int, # 年龄
        address varchar(32), # 地址
        qq varchar(20), # qq
        email varchar(50) # 邮箱
    );
    ```

- 开发：

  - 环境搭建
    - 创建数据库
    - 创建项目，导入jar包
  - 编码

- 测试

- 部署运维