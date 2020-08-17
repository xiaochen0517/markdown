# Spring Boot 配置文件

## 1、配置文件类型

### 1.1、 `application.properties` 

语法： `key=value` 

### 1.2、 `application.yml` 

语法： `key:[空格]value` 

## 2、 `YAML` 

### 2.1、什么是 `YAML` 

**YAML**（/ˈjæməl/，尾音类似*camel*骆驼）是一个可读性高，用来表达数据序列化的格式。 `YAML` 参考了其他多种语言，包括： `C语言` 、 `Python` 、 `Perl` ，并从 `XML` 、电子邮件的数据格式 `（RFC 2822）` 中获得灵感。 `Clark Evans` 在2001年首次发表了这种语言，另外 `Ingy döt Net` 与 `Oren Ben-Kiki` 也是这语言的共同设计者。当前已经有数种编程语言或脚本语言支持（或者说解析）这种语言。

### 2.2、相关数据类型

#### 2.2.1、普通键值对

语法

```shell
key:[空格]value
```

示例

```yaml
name: zhangsan
```

#### 2.2.2、对象

语法

```yaml
# 普通方式
object: 
[Tab]property: value
[Tab]property: value
# 行内形式
object: {property: value,property: value}
```

示例

```yaml
person:
  name: zhangsan
  age: 13

person: {name: zhangsan, age: 13}
```

#### 2.2.3、数组

语法

```yaml
key:
[Tab]- value
[Tab]- value
# 行内
key: [value,value]
```

示例

```yaml
food:
  - rice
  - noodles
  - dumpling

food: [rice,noodles,dumpling]
```

## 3、配置文件赋值

### 3.1、`ymal` 赋值

#### 3.1.1、新建类

`User.java` 

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Component
public class User {

    private String name;
    private int age;

}
```

`Person.java` 

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Component
@ConfigurationProperties(prefix = "person")
public class Person {

    private String name;
    private Integer age;
    private Boolean happy;
    private Date birthday;
    private Map<String, Object> map;
    private List<Object> lists;
    private User user;

}
```

#### 3.1.2、配置文件

```yaml
person:
  name: 张三
  age: 3
  happy: false
  birthday: 2020/7/10
  map: {one: 哈哈, two: 12, three: false}
  lists:
    - 哈哈
    - 12
    - true
  user:
    name: 李四
    age: 13
```

#### 3.1.3、测试结果

```shell
Person(name=张三, age=3, happy=false, birthday=Fri Jul 10 00:00:00 CST 2020, map={one=哈哈, two=12, three=false}, lists=[哈哈, 12, true], user=User(name=李四, age=13))
```

### 3.2、 `properties` 赋值

#### 3.2.1、 新建配置文件

`user.properties` 

```properties
name=张三
age=13
```

#### 3.2.2、在类中配置

`User.java` 

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Component
@PropertySource("classpath:user.properties") // 指定配置文件
public class User {

    @Value("${name}") // 使用SPEL表达式取出值
    private String name;
    @Value("${age}")
    private int age;

}
```

#### 3.2.3、测试

```shell
User(name=张三, age=13)
```

### 3.3、方式对比

|                      | @ConfigurationProperties | @Value   |
| -------------------- | ------------------------ | -------- |
| 功能                 | 批量注入配置文件中的属性 | 单独指定 |
| 松散绑定（松散语法） | 支持                     | 不支持   |
| SpEL                 | 不支持                   | 支持     |
| JSR303数据校验       | 支持                     | 不支持   |
| 复杂类型封装         | 支持                     | 不支持   |

-  `cp`  只需要配置一次即可， `value` 注解需要每一个字段都添加
- 松散绑定：若 `yaml` 中属性为 `last-name` ，与 `lastName` 是相同的。
-  `JSR303` 数据校验：在字段增加一层过滤器验证，可以保证数据的合法性
- 复杂类型封装， `yaml` 可以封装对象， `value` 注解不支持

### 3.4、 `JSR303` 数据校验

`Spring Boot` 中可以使用 `@Validated` 校验数据，若数据异常则会同意抛出异常，方便异常中心统一处理。

通俗来讲就是可以指定一个属性的值为指定格式或类型。

![](photo\4、JSR303校验注解（2）.png).

![](photo\4、JSR303校验注解附加（2）.png)'

测试

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Component
@ConfigurationProperties(prefix = "person")
@Validated
public class Person {

    @Email(message = "你这邮箱地址不对吖")
    private String name;
    private Integer age;
    private Boolean happy;
    private Date birthday;
    private Map<String, Object> map;
    private List<Object> lists;
    private User user;

}
```

结果

```shell
Property: person.name
Value: 张三
Origin: class path resource [application.yaml]:2:9
Reason: 你这邮箱地址不对吖
```

## 4、配置文件

### 4.1、配置文件路径

以下是可以放置配置文件的路径，优先级从高到低，高优先级配置文件会覆盖低优先级配置文件。

1. `file:./config/` 
2. `file:./config/*/` 
3. `file:./` 
4. `classpath:/config/` 
5. `classpath:/` 

### 4.2、多配置

在 `yaml` 中可以使用 `---` 分隔多个相同的配置

```yaml
server:
	port: 8081
---
server:
	port: 8082
```

指定多个配置名

```yaml
spring:
	profiles: name
```

激活指定配置名的配置

```yaml
spring:
	profiles:
		active: name
```

