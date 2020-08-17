# Spring Boot Thymeleaf

## 1、简单配置

### 1.1、导入 `maven` 依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
```

### 1.2、新建 `html` 模板

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h1>test</h1>
<div th:text="${msg}"></div>
</body>
</html>
```

> 必须在 `html` 中配置约束 `xmlns:th="http://www.thymeleaf.org"` 才可以使用 `thymeleaf` 

### 1.3、创建 `controller` 

```java
@RequestMapping("/test")
public String test1(Model model){
    model.addAttribute("msg", "this is msg");
    return "test";
}
```

### 1.4、测试

![image-20200718181838224](photo\10、thymeleaf测试（4）.png).

## 2、相关标签

### 2.1、取值方式

- Simple expressions:
  - Variable Expressions: ${...}
  - Selection Variable Expressions: *{...}
  - Message Expressions: #{...}
  - Link URL Expressions: @{...}
  - Fragment Expressions: ~{...}
- Literals
  - Text literals: 'one text' , 'Another one!' ,…
  - Number literals: 0 , 34 , 3.0 , 12.3 ,…
  - Boolean literals: true , false
  - Null literal: null
  - Literal tokens: one , sometext , main ,…
- Text operations:
  - String concatenation: +
  - Literal substitutions: |The name is ${name}|
- Arithmetic operations:
  - Binary operators: + , - , * , / , %
  - Minus sign (unary operator): -
- Boolean operations:
  - Binary operators: and , or
  - Boolean negation (unary operator): ! , not
- Comparisons and equality:
  - Comparators: > , < , >= , <= ( gt , lt , ge , le )
  - Equality operators: == , != ( eq , ne )
- Conditional operators:
  - If-then: (if) ? (then)
  - If-then-else: (if) ? (then) : (else)
  - Default: (value) ?: (defaultvalue)
- Special tokens:
  - No-Operation: _

### 2.2、标签

| Order | Feature                         | Attributes                                    |
| ----- | ------------------------------- | --------------------------------------------- |
| 1     | Fragment inclusion              | th:insert<br/>th:replace                      |
| 2     | Fragment iteration              | th:each                                       |
| 3     | Conditional evaluation          | th:if<br/>th:unless<br/>th:switch<br/>th:case |
| 4     | Local variable definition       | th:object<br/>th:with                         |
| 5     | General attribute modification  | th:attr<br/>th:attrprepend<br/>th:attrappend  |
| 6     | Specific attribute modification | th:value<br/>th:href<br/>th:src               |
| 7     | Text (tag body modification)    | th:text<br/>th:utext                          |
| 8     | Fragment specification          | th:fragment                                   |
| 9     | Fragment removal                | th:remove                                     |


