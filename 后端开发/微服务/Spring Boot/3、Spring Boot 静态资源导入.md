# Spring Boot 静态资源导入

## 1、使用 `WebJars` 

### 1.1、导入 `jar` 包

[WebJars官网](https://www.webjars.org/)

```xml
<dependency>
    <groupId>org.webjars</groupId>
    <artifactId>jquery</artifactId>
    <version>3.5.1</version>
</dependency>
```

### 1.2、查看目录

![image-20200718104102253](photo\5、jquery Jar包目录（3）.png).

### 1.3、访问测试

![image-20200718105400416](photo\6、WebJars访问测试（3）.png).

### 2、使用 `resources` 目录

### 2.1、目录结构

![image-20200718110224686](photo\7、resources目录结构（3）.png).

### 2.2、目录优先级

从大到小

- `resources`
- `static`
- `public`

### 2.3、测试

![image-20200718110450003](photo\8、resources访问测试（3）.png).

## 3、首页图标定制

### 3.1、配置首页

在配置静态文件时，可以使用根目录加文件名的形式访问到 `resources` 中的静态文件，同时也可以添加 `index.html` 来配置一个首页。

### 3.2、图标

图标目录

![image-20200718154702518](photo\9、小图标目录（3）.png).

`html` 代码

```html
<link rel="icon" href="/faviconn.ico" type="image/x-icon"/>
<link rel="bookmark" href="/faviconn.ico" type="image/x-icon"/>
```

