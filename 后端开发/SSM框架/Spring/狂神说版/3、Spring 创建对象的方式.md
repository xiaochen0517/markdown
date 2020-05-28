# Spring 创建对象的方式

- Spring 默认使用空参构造创建对象

- 使用有参构造

  - 下标赋值

    - ```xml
      <bean id="user" class="com.lxc.pojo.User">
          <constructor-arg index="0" value="张三"/>
          <constructor-arg index="1" value="34"/>
      </bean>
      ```

  - 类型赋值

    - ```xml
      <bean id="user" class="com.lxc.pojo.User">
          <constructor-arg type="java.lang.String" value="张三"/>
          <constructor-arg type="int" value="34"/>
      </bean>
      ```

  - 名称赋值

    - ```xml
      <bean id="user" class="com.lxc.pojo.User">
          <constructor-arg name="name" value="张三"/>
          <constructor-arg name="age" value="34"/>
      </bean>
      ```

  - 引用bean赋值

    - ```xml
      <bean id="user" class="com.lxc.pojo.User">
          <constructor-arg ref="age"/>
          <constructor-arg ref="name"/>
      </bean>
      
      <bean id="name" class="java.lang.String">
          <constructor-arg name="original" value="张三"/>
      </bean>
      
      <bean id="age"  class="java.lang.Integer">
          <constructor-arg name="value" value="34"/>
      </bean>
      ```

> 在配置文件加载时，配置文件中的所有的bean就已经被实例化了