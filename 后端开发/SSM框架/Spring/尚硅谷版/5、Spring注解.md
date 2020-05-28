## Spring注解

#### 配置自动扫描

- 添加命名空间

  - ```xml
    <beans xmlns="http://www.springframework.org/schema/beans"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xmlns:context="http://www.springframework.org/schema/context"
           xsi:schemaLocation="http://www.springframework.org/schema/beans
            https://www.springframework.org/schema/beans/spring-beans.xsd
            http://www.springframework.org/schema/context
            https://www.springframework.org/schema/context/spring-context.xsd">
    ```

- 配置自动扫描

  - ```xml
    <context:component-scan base-package="com.lxc.service"></context:component-scan>
    ```

  - 

#### 作用分类

- 用于创建对象

  - 和xml中\<bean\>标签实现的功能相同
  - @Component：
    - 用于把当前对象写入spring容器中
    - 属性：
      - value：用于指定bean的id，当不写值，默认为类名，首字母小写
  - @Controller：表现层
  - @Service：业务层
  - @Repository：持久层

- 用于注入数据

  - \<bean\>中的\<property\>标签作用相同
  - @Autowired
    - 自动按照类型注入，只要容器中唯一的一个bean对象类型要注入的变量类型匹配，就可以注入成功
    - 如果发现两个相同类型的值，则对比beanid和变量名，如果匹配，注入成功，不匹配则报错
  - @Qualifier
    - 在按照类中注入的基础之上再按照名称注入。它在给类成员注入时不能单独使用，但是在给方法参数注入时可以
    - 属性
      - value：用于指定注解的id
  - @Resource
    - 直接按照bean的id注入
    - 属性
      - name
  - @Value：
    - 用于注入基本类型和string类型的数据
    - 属性
      - value：用于指定数据的值，可以使用spring中的SpEL（也就是spring的el表达式）

  - 特点
    - 使用注解注入数据时，set方法就不是必须的了
    - 集合类型的数据只可以使用xml来注入

- 用于改变作用范围

  - \<bean\>中scope属性相同
  - @Scope
    - 作用：用于指定bean的作用范围
    - 属性
      - value：指定范围的取值。常用取值：singleton prototype

- 用于改变生命周期

  - \<bean\>中init-method和destroy-method相同
  - PreDestroy：
    - 用于指定销毁方法
  - postConstruct
    - 用于指定初始化方法

#### 使用注解代替bean.xml文件

- @Configuration
  - 指定当前类是一个配置类
  - 当配置类作为AnnotationConfigApplicationContext对象创建的参数时，该注解可以不写
- @ComponentScan
  - 用于通过注解指定spring在创建容器时要扫描的包
  - 属性
    - value：和basePackages的作用是一样的，都是用于指定创建容器时要扫描的包。
- @Bean
  - 用于把当前方法的返回值作为bean对象存入spring的ioc容器中
  - 属性
    - name：用于指定bean的id，默认值为当前方法名称
  - 注：
    - 当使用注解配置方法时，如果方法有参数，spring框架会去容器中查找有没有可用的bean对象
    - 查找的方式和Autowired注解是一样的
- @Import
  - 用于导入其他的配置类
  - 属性
    - value：用于指定其他配置类的字节码，导入子配置类
- @PropertySource
  - 用于指定properties文件的位置
  - 属性
    - value：指定文件的名称和路径

