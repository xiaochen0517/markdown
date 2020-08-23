# Spring 依赖注入

## 1、构造器注入

详见03、`Spring` 创建对象的方式

## 2、`set` 方法注入

- 测试类

```java
Address.java

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Address {
    private String address;
}

Student.java

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Student {
    private int id;
    private String name;
    private Address address;
    private String[] books;
    private List<String> likes;
    private Map<String, String> account;
    private Set<String> games;
    private Properties info;
    private String pointer;
}
```

### 2.1、基本类注入

```xml
<property name="id" value="121"/>
<property name="name" value="张三"/>
```

### 2.2、对象注入

```xml
<property name="address" ref="address"/>

​`````````````````
<bean id="address" class="com.lxc.popj.Address">
    <property name="address" value="中国山西"/>
</bean>
```

### 2.3、数组注入

```xml
<property name="books">
    <array>
        <value>Hello</value>
        <value>Fuck</value>
    </array>
</property>
```

### 2.4、`List` 注入

```xml
<property name="likes">
    <list>
        <value>You</value>
        <value>are</value>
        <value>Pig</value>
    </list>
</property>
```

### 2.5、`Map` 注入

```xml
<property name="account">
    <map>
        <entry key="fuck" value="123"/>
        <entry key="you" value="456"/>
    </map>
</property>
```

### 2.6、`Set` 注入

```xml
<property name="games">
    <set>
        <value>hello</value>
        <value>mother</value>
        <value>fucker</value>
    </set>
</property>
```

### 2.7、`props` 注入

```xml
<property name="info">
    <props>
        <prop key="you">h</prop>
        <prop key="oops">hhh</prop>
    </props>
</property>
```

### 2.8、空值注入

```xml
<property name="pointer">
    <null/>
</property>
```

## 3、命名空间注入

### 3.1、`p` 命名空间

- 导入约束

```xml
xmlns:p="http://www.springframework.org/schema/p"
```

- 使用 `p` 命名空间

```xml
<bean id="users" class="com.lxc.popj.Users" p:name="张三" p:age="30"/>
```

### 3.2、`c` 命名空间

- 导入约束

```xml
xmlns:c="http://www.springframework.org/schema/c"
```

- 使用 `c` 命名空间

```xml
<bean id="usersc" class="com.lxc.popj.Users" c:name="李四" c:age="25"/>
```



