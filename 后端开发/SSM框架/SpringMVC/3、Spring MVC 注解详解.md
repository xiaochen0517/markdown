# Spring MVC 注解详解

## 1、类相关

### 1.1、 `controller`  相关

#### 1.1.1、 `@Controller`

标记此类为 `Controller` 类，同时会将类交给 `spring` 管理。

#### 1.1.2、`@RestController`

标记此类为 `Controller` 类，同时会将类交给 `spring` 管理。

在返回字符串时，不会将字符串交给视图解析器，直接返回字符串到客户端。

### 1.2、 `RequestMapping` 相关

#### 1.2.1、 `@RequestMapping(value)`

用于映射路径名必填值为 `value` ，此注解在类和方法中皆可使用。

相关属性：

-  `value` ：映射路径
-  `method` ：访问此路径指定的方法
-  `params` ：请求中必须携带指定参数才接收请求
-  `header` ：请求中必须携带指定的请求头才接收请求
-  `consumes` ：指定处理请求的提交内容类型
-  `produces` ：指定返回的数据类型

> 若类上的注解为  `@RequestMapping("/a")` ，方法 `a` 上的注解为 `@RequestMapping("/b")` ，则若想访问 `a` 方法访问路径为 `XXX/a/b`

## 2、方法相关

### 2.1、 `@RequestParam` 

绑定单个请求参数值，用于将请求参数数据映射到方法的参数中。

相关属性：

-  `value` ：参数名
-  `required` ：是否必须有此值
-  `defaultValue` ：默认值，请求中没有指定参数时，会向默认值赋值到参数中

> 若有多个同名参数，可以使用数组或 `List` 获取。

### 2.2、 `@PathVariable` 

绑定 `URI` 模板变量值，用于将请求 `URI` 中的模板变量映射到指定参数中。

相关属性：

-  `value` ：`URI` 中的模板标签名

eg.

```java
@RequestMapping("/hello/a/{value}")
public String hello1(@PathVariable("value") String value1, Model model){
    model.addAttribute("msg", "this msg : "+value1);
    return "hello";
}
```

### 2.3、 `@ModelAttribute` 

`ModelAttribute` 可以应用在方法参数上或方法上，他的作用主要是当注解在方法参数上时会将注解的参数对象添加到 `Model` 中；当注解在请求处理方法 `Action` 上时会将该方法变成一个非请求处理的方法，但其它 `Action` 被调用时会首先调用该方法。

```java
@Controller
@RequestMapping(value="/test")
public class TestController {
    
    @ModelAttribute("str")
    public String getParam(@RequestParam String param) {
        return param;
    }
    
    @RequestMapping(value = "/helloWorld")
    public String helloWorld() {
       return "test/helloWorld";
    }
}

// 在访问路径 /test/helloWorld 时，getParam()方法会在helloWorld()方法前执行并获取到值。
```

### 2.4、 `@Responsebody ` 

表示该方法的返回结果直接写入 `HTTP Response Body` 中，效果同 `@RestController` 作用位置不同。

### 2.5、 `@RequestBody` 

该注解用于读取`Request`请求的`body`部分数据，使用系统默认配置的`HttpMessageConverter`进行解析，然后把相应的数据绑定到要返回的对象上。再把`HttpMessageConverter`返回的对象数据绑定到`controller`中方法的参数上。

- `GET`、`POST`方式提时，根据`request header Content-Type`的值来判断:
  - `application/x-www-form-urlencoded`， 这种情况的数据`@RequestParam`, `@ModelAttribute`、`@RequestBody`、都可以处理
  - `multipart/form-data`, 使用`@RequestBody`不能处理这种格式的数据
  - `application/json`, `application/xml`等，这些格式的数据必须使用`@RequestBody`来处理

- `PUT`方式提交时， 根据`request header Content-Type`的值来判断:
- `application/x-www-form-urlencoded`， 必须使用`@RequestBody`
  
- `multipart/form-data`, 不能处理
  
- 其他格式， 必须使用`@RequestBody`

> request的body部分的数据编码格式由header部分的Content-Type指定