# Spring Boot 任务

## 1、概述

在 `Spring Boot` 中任务分为三种异步任务、定时任务和邮件任务。

- **异步任务** 在实际的开发过程中使用的是非常广泛的,特别是在邮件发送,数据处理的过程中,不希望影响后面的进程,我们都会采用异步任务
- **定时任务** 在项目中需要特定的时间进行一些特定的任务，此时就需要定时任务。
- **邮件任务 ** 在 `spring boot` 项目中发送邮件

## 2、异步任务

### 2.1、开启异步任务

在 `Application` 类上添加注解 `@EnableAsync` 开启异步任务注解

```java
@EnableAsync
@SpringBootApplication
public class Task1Application {

    public static void main(String[] args) {
        SpringApplication.run(Task1Application.class, args);
    }

}
```

### 2.2、指定 `service` 方法

在需要开启异步任务的方法上添加 `@Async` 注解

```java
@Async
@Override
public String asyncTest() {
    try {
        Thread.sleep(2000);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    return "hello world";
}
```

## 3、定时任务

### 3.1、相关类及注解

- `TaskScheduler` 任务调度
- `TaskExecutor`  任务执行
- `@EnableScheduling` 开启定时任务功能
- `@Scheduled` 什么时候执行任务
- `Cron` 表达式 [参考文章](https://www.cnblogs.com/yanghj010/p/10875151.html) 

### 3.2、使用

```java
@Scheduled(cron = "0/5 * * * * ?") // 每 5 秒钟执行一次
@Override
public String test1() {
    System.out.println("定时任务执行！");
    return null;
}
```

![image-20200817160103811](photo\22、定时任务执行效果（10）.png).



## 4、邮件任务

### 4.1、导包

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-mail</artifactId>
</dependency>
```

### 4.2、发送邮件

#### 4.2.1、简单邮件发送

```java
@Test
void contextLoads() {
    SimpleMailMessage simpleMailMessage = new SimpleMailMessage();

    simpleMailMessage.setSubject("这是一个标题"); // 设置标题
    simpleMailMessage.setText("这是一段文字"); // 设置内容

    simpleMailMessage.setTo("2827075398@qq.com"); // 发送到的邮箱地址
    simpleMailMessage.setFrom("2827075398@qq.com"); // 发送者

    mailSender.send(simpleMailMessage); // 发送邮件
}
```

![image-20200817114359790](photo\20、简单邮件发送（10）.png).

#### 4.2.2、复杂邮件发送

```java
@Test
void contextLoads1() throws MessagingException {
    MimeMessage mimeMessage = mailSender.createMimeMessage();

    // 参数二 是否支持内联元素 附件 上传
    MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);

    helper.setSubject("这是一个标题");
    // 参数二为 true 时会将 text 中的内容作为 html 解析
    helper.setText("<p> 文字<span style=\"color: red;\">啦啦啦啦</span> </p>", true);

    // 发送文件名，要发送的文件
    helper.addAttachment("1.jpg", new File("F:\\图片文件\\表情包\\waifu.png"));
    helper.addAttachment("2.jpg", new File("F:\\图片文件\\表情包\\one.jpg"));

    helper.setTo("2827075398@qq.com");
    helper.setFrom("2827075398@qq.com");

    mailSender.send(mimeMessage);
}
```

![image-20200817114448801](photo\21、复杂邮件发送（10）.png).