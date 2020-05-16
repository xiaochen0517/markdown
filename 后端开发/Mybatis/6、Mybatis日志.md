# Mybatis日志

## 1、日志工厂

若数据库操作出现了异常，可以使用日志来排错

- Mybatis配置日志工厂

![image-20200516110141780](photo\1、Mybatis日志（1）.png)

- SLF4J
- LOG4J（重点）
- LOG4J2
- JDK_LOGGING
- COMMONS_LOGGING
- STDOUT_LOGGING（重点）
- NO_LOGGING：无日志

## 2、使用STDOUT_LOGGING日志

配置文件

```xml
<settings>
    <setting name="logImpl" value="STDOUT_LOGGING"/>
</settings>
```

打印数据

![image-20200516111614003](photo\2、Mybatis日志（2）.png)

## 3、使用LOG4J

### 3.1、概述

- Log4j是Apache的一个开源项目
- 可以控制日志信息输送的目的地
- 可以控制每一条日志的输出格式
- 定义日志信息的级别，更加细致地控制日志的生成过程
- 通过一个配置文件灵活地进行配置，不需要修改应用的代码

### 3.2、使用

#### 3.2.1、导入jar包

```xml
<!-- https://mvnrepository.com/artifact/log4j/log4j -->
<dependency>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
    <version>1.2.17</version>
</dependency>
```

#### 3.2.2、编写配置文件

新建文件log4j.properties

```properties
### 配置根 ###
log4j.rootLogger = debug,console,file

### 配置输出到控制台 ###
log4j.appender.console = org.apache.log4j.ConsoleAppender
log4j.appender.console.Target = System.out
log4j.appender.console.layout = org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern =  %d{ABSOLUTE} %5p %c{1}:%L - %m%n

### 配置输出到文件 ###
log4j.appender.file = org.apache.log4j.RollingFileAppender
log4j.appender.file.MaxFileSize = 1MB
log4j.appender.file.MaxBackupIndex = 10
log4j.appender.file.File = logs/log.log
log4j.appender.file.Append = true
log4j.appender.file.Threshold = DEBUG
log4j.appender.file.layout = org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern = %-d{yyyy-MM-dd HH:mm:ss}  [ %t:%r ] - [ %p ]  %m%n
```

#### 3.2.3、Mybatis配置文件

```xml
    <typeAliases>
        <package name="com.lxc.pojo"/>
    </typeAliases>
```

#### 3.2.4、运行结果

部分日志

![image-20200516121549756](E:\PerFile\notes\markdown\后端开发\Mybatis\photo\3、Mybatis日志（3）.png)