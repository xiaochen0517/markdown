# Spring Boot 常用功能

## 1、页面国际化

### 1.1、新建配置文件

- 在resources 目录下新建文件夹 `i18n` 
- 在文件夹 `i18n` 下新建文件 
  - `login.properties` 
  - `login_en_US.properties` 
  - `login_zh_CN.properties` 
- 在 `IDEA` 中文件夹会变为以下格式

![image-20200723115830646](photo\11、国际化目录结构（5）.png).

### 1.2、在 `thymeleaf` 中使用

- 使用 `#{}` 标签取出 `properties` 中的数据

```html
<h2 th:text="#{login.tip}"></h2>
```

### 1.3、编写解析器

- 新建类 `MyLocaleResolver` 继承 `LocaleResolver` 

```java
public class MyLocaleResolver implements LocaleResolver {
    @Override
    public Locale resolveLocale(HttpServletRequest request) {
        String lan = request.getParameter("lan");

        System.out.println(lan);

        Locale locale = Locale.getDefault();

        if (!StringUtils.isEmpty(lan)){
            String[] splitStr = lan.split("_");

            locale = new Locale(splitStr[0], splitStr[1]);
        }
        return locale;
    }

    @Override
    public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) {

    }
}
```

- 添加切换语言连接

```html
<a href="/test?lan=en_US">english</a>
<a href="/test?lan=zh_CN">中文</a>
```

