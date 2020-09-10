# Spring Cloud 入门

## 1、概述

### 1.1、什么是 `Spring Cloud` 

`Spring Cloud` 是一系列框架的有序集合。它利用 `Spring Boot` 的开发便利性巧妙地简化了分布式系统基础设施的开发，如服务发现注册、配置中心、消息总线、负载均衡、断路器、数据监控等，都可以用 `Spring Boot` 的开发风格做到一键启动和部署。 `Spring Cloud` 并没有重复制造轮子，它只是将各家公司开发的比较成熟、经得起实际考验的服务框架组合起来，通过 `Spring Boot` 风格进行再封装屏蔽掉了复杂的配置和实现原理，最终给开发者留出了一套简单易懂、易部署和易维护的分布式系统开发工具包。

**解决方案：**

- `Spring Cloud NetFlix` 一站式解决方案
  - `API` 网关，`zuul` 组件
  - `Feign` 基于 `HttpClinet` 同步阻塞， 通信
  - `Eureka` 服务注册发现
  - `Hystrix` 熔断机制
- `Apache Dubbo Zookeeper` 半自动
  - `Dubbo` 通信框架
  - `Zookeeper` 服务注册发现
- `Spring Cloud Alibaba` 一站式解决方案，配置比 `NetFlix` 更简单易用

**服务网格：** `Server Mesh` 

- `istio` 

**结构：**

- `API` 网关，路由
- 通信
- 服务注册发现
- 熔断机制

![](Photo\上传图片 微服务架构图.svg)

### 1.2、`Spring Cloud` 和 `Spring Boot` 的关系

- `Spring Boot` 专注于快速方便的开发单个个体的微服务
- `Spring Cloud` 是关注全局的微服务协调整理治理框架，它将 `Spring Boot` 开发的一个个单体微服务整合并管理起来，为各个微服务之前提供：配置管理，服务发现，断路器，路由，微代理，事件总线，全局锁，决策竞选，分布式会话登集成服务。
- `Spring Boot` 可以离开 `Spring Cloud` 独立使用，开发项目，但 `Spring Cloud` 离不开 `Spring Boot` ，属于依赖关系。
- `Spring Boot` 专注于快速、方便的开发单个个体微服务， `Spring cloud` 关注全局的服务治理框架

### 1.3、`Dubbo` 和 `Spring Cloud` 技术选型

#### 1.3.1、分布式+服务治理 `Dubbo` 

目前成熟的互联网架构：应用服务化拆分+消息中间件

#### 1.3.2、`Dubbo` 和 `Spring Cloud` 对比

|              | `Dubbo`         | `Spring`                       |
| ------------ | --------------- | ------------------------------ |
| 服务注册中心 | `Zookeeper`     | `Spring Cloud Netflix Eureka`  |
| 服务调用方式 | `RPC`           | `REST API`                     |
| 服务监控     | `Dubbo-monitor` | `Spring Boot Admin`            |
| 断路器       | 不完善          | `Spring Cloud Netflix Hystrix` |
| 服务网关     | 无              | `Spring Cloud Netflix Zuul`    |
| 分布式配置   | 无              | `Spring Cloud Config`          |
| 服务跟踪     | 无              | `Spring Cloud Sleuth`          |
| 消息总线     | 无              | `Spring Cloud Bus`             |
| 数据流       | 无              | `Spring Cloud Stream`          |
| 批量任务     | 无              | `Spring Cloud Task`            |

最大区别： `Spring Cloud` 抛弃了 `Dubbo` 的 `RPC` 通信，采用基于 `HTTP` 的 `REST` 方式

严格来说，这两种方式各有优劣。虽然从一定程度上来说，后者牺牲了服务调用的性能，但是也避免了上面提到的原生 `RPC` 带来的问题。而且 `REST` 相比 `RPC` 更加的灵活，服务提供方和调用方的依赖只依靠一纸契约，不存在代码级别的强依赖，这在强调快速演化的的微服务环境下，显得更加的合适。

`Dubbo` 定位是一款 `RPC` 框架， `Spring Cloud` 目标是微服务架构下的一站式解决方案。

### 1.4、`Spring Cloud` 可以做到那些

- 分布式，版本控制配置
- 服务注册与发现
- 路由
- 服务到服务的调用
- 负载均衡配置
- 断路器
- 分布式消息管理

### 1.5、版本

`Spring Cloud` 是一个有众多子项目组成的一个大型综合项目，每个子项目有不同的发行节奏，都维护着自己的发布版本号。 `Spring Cloud` 通过一个资源清单 `BOM (Bill of Materials)` 来管理每个版本的子项目清单。为避免与子项目的发布号混淆，所以没有采用版本号的方式，而是通过命名的方式。

![image-20200822114926247](Photo\1、Spring Cloud 版本号（2）.png)

## 2、入门使用

### 2.1、技术选型

- [SpringCloud & SpringBoot 版本关系](https://start.spring.io/actuator/info) 

```json
{
    "git": {
        "branch": "58cb6bccc1be3cdbe108a4609797c53010545926",
        "commit": {
            "id": "58cb6bc",
            "time": "2020-08-21T06:52:21Z"
        }
    },
    "build": {
        "version": "0.0.1-SNAPSHOT",
        "artifact": "start-site",
        "versions": {
            "spring-boot": "2.3.3.RELEASE",
            "initializr": "0.9.2-SNAPSHOT"
        },
        "name": "start.spring.io website",
        "time": "2020-08-21T07:23:55.515Z",
        "group": "io.spring.start"
    },
    "bom-ranges": {
        "azure": {
            "2.0.10": "Spring Boot >=2.0.0.RELEASE and <2.1.0.RELEASE",
            "2.1.10": "Spring Boot >=2.1.0.RELEASE and <2.2.0.M1",
            "2.2.4": "Spring Boot >=2.2.0.M1 and <2.3.0.M1",
            "2.3.1": "Spring Boot >=2.3.0.M1"
        },
        "codecentric-spring-boot-admin": {
            "2.0.6": "Spring Boot >=2.0.0.M1 and <2.1.0.M1",
            "2.1.6": "Spring Boot >=2.1.0.M1 and <2.2.0.M1",
            "2.2.4": "Spring Boot >=2.2.0.M1 and <2.3.0.M1",
            "2.3.0": "Spring Boot >=2.3.0.M1 and <2.4.0-M1"
        },
        "solace-spring-boot": {
            "1.0.0": "Spring Boot >=2.2.0.RELEASE and <2.3.0.M1",
            "1.1.0": "Spring Boot >=2.3.0.M1"
        },
        "solace-spring-cloud": {
            "1.0.0": "Spring Boot >=2.2.0.RELEASE and <2.3.0.M1",
            "1.1.1": "Spring Boot >=2.3.0.M1"
        },
        "spring-cloud": {
            "Finchley.M2": "Spring Boot >=2.0.0.M3 and <2.0.0.M5",
            "Finchley.M3": "Spring Boot >=2.0.0.M5 and <=2.0.0.M5",
            "Finchley.M4": "Spring Boot >=2.0.0.M6 and <=2.0.0.M6",
            "Finchley.M5": "Spring Boot >=2.0.0.M7 and <=2.0.0.M7",
            "Finchley.M6": "Spring Boot >=2.0.0.RC1 and <=2.0.0.RC1",
            "Finchley.M7": "Spring Boot >=2.0.0.RC2 and <=2.0.0.RC2",
            "Finchley.M9": "Spring Boot >=2.0.0.RELEASE and <=2.0.0.RELEASE",
            "Finchley.RC1": "Spring Boot >=2.0.1.RELEASE and <2.0.2.RELEASE",
            "Finchley.RC2": "Spring Boot >=2.0.2.RELEASE and <2.0.3.RELEASE",
            "Finchley.SR4": "Spring Boot >=2.0.3.RELEASE and <2.0.999.BUILD-SNAPSHOT",
            "Finchley.BUILD-SNAPSHOT": "Spring Boot >=2.0.999.BUILD-SNAPSHOT and <2.1.0.M3",
            "Greenwich.M1": "Spring Boot >=2.1.0.M3 and <2.1.0.RELEASE",
            "Greenwich.SR6": "Spring Boot >=2.1.0.RELEASE and <2.1.17.BUILD-SNAPSHOT",
            "Greenwich.BUILD-SNAPSHOT": "Spring Boot >=2.1.17.BUILD-SNAPSHOT and <2.2.0.M4",
            "Hoxton.SR7": "Spring Boot >=2.2.0.M4 and <2.3.4.BUILD-SNAPSHOT",
            "Hoxton.BUILD-SNAPSHOT": "Spring Boot >=2.3.4.BUILD-SNAPSHOT and <2.4.0.M1",
            "2020.0.0-SNAPSHOT": "Spring Boot >=2.4.0.M1"
        },
        "spring-cloud-alibaba": {
            "2.2.1.RELEASE": "Spring Boot >=2.2.0.RELEASE and <2.3.0.M1"
        },
        "spring-cloud-services": {
            "2.0.3.RELEASE": "Spring Boot >=2.0.0.RELEASE and <2.1.0.RELEASE",
            "2.1.7.RELEASE": "Spring Boot >=2.1.0.RELEASE and <2.2.0.RELEASE",
            "2.2.3.RELEASE": "Spring Boot >=2.2.0.RELEASE and <2.3.0.M1"
        },
        "spring-statemachine": {
            "2.0.0.M4": "Spring Boot >=2.0.0.RC1 and <=2.0.0.RC1",
            "2.0.0.M5": "Spring Boot >=2.0.0.RC2 and <=2.0.0.RC2",
            "2.0.1.RELEASE": "Spring Boot >=2.0.0.RELEASE"
        },
        "vaadin": {
            "10.0.17": "Spring Boot >=2.0.0.M1 and <2.1.0.M1",
            "14.3.3": "Spring Boot >=2.1.0.M1 and <2.4.0-M1"
        },
        "wavefront": {
            "2.0.0": "Spring Boot >=2.1.0.RELEASE"
        }
    },
    "dependency-ranges": {
        "okta": {
            "1.2.1": "Spring Boot >=2.1.2.RELEASE and <2.2.0.M1",
            "1.4.0": "Spring Boot >=2.2.0.M1 and <2.4.0-M1"
        },
        "mybatis": {
            "2.0.1": "Spring Boot >=2.0.0.RELEASE and <2.1.0.RELEASE",
            "2.1.3": "Spring Boot >=2.1.0.RELEASE and <2.4.0-M1"
        },
        "geode": {
            "1.2.9.RELEASE": "Spring Boot >=2.2.0.M5 and <2.3.0.M1",
            "1.3.3.RELEASE": "Spring Boot >=2.3.0.M1 and <2.4.0-M1",
            "1.4.0-M2": "Spring Boot >=2.4.0-M1"
        },
        "camel": {
            "2.22.4": "Spring Boot >=2.0.0.M1 and <2.1.0.M1",
            "2.25.2": "Spring Boot >=2.1.0.M1 and <2.2.0.M1",
            "3.3.0": "Spring Boot >=2.2.0.M1 and <2.3.0.M1",
            "3.4.3": "Spring Boot >=2.3.0.M1 and <2.4.0-M1"
        },
        "open-service-broker": {
            "2.1.3.RELEASE": "Spring Boot >=2.0.0.RELEASE and <2.1.0.M1",
            "3.0.4.RELEASE": "Spring Boot >=2.1.0.M1 and <2.2.0.M1",
            "3.1.1.RELEASE": "Spring Boot >=2.2.0.M1 and <2.4.0-M1"
        }
    }
}
```

官网版本推荐

![image-20200822153839477](Photo\2、Spring Cloud 与 Spring Boot 版本（2）.png)

### 2.2、停更替换升级

![image-20200822161548975](Photo\3、Spring Cloud 停更框架替换升级（2）.png)

### 2.3、`pom` 配置

#### 2.3.1、配置文件内容

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.lxc.springcloud2</groupId>
    <artifactId>springcloud-2</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>pom</packaging>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
        <junit.version>4.12</junit.version>
        <lombok.version>1.18.12</lombok.version>
        <log4j.version>1.2.17</log4j.version>
        <mysql.version>8.0.21</mysql.version>
        <druid.version>1.1.16</druid.version>
        <mybatis.spring.boot.version>2.1.1</mybatis.spring.boot.version>
    </properties>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-project-info-reports-plugin</artifactId>
                <version>3.0.0</version>
            </dependency>
            <!--spring boot 2.2.2-->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>2.3.2.RELEASE</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--spring cloud Hoxton.SR1-->
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>Hoxton.SR7</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <dependency>
                <groupId>com.alibaba.cloud</groupId>
                <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                <version>2.1.0.RELEASE</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--mysql-->
            <dependency>
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>${mysql.version}</version>
                <scope>runtime</scope>
            </dependency>
            <!-- druid-->
            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>druid</artifactId>
                <version>${druid.version}</version>
            </dependency>
            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>druid-spring-boot-starter</artifactId>
                <version>${druid.version}</version>
            </dependency>
            <!--mybatis-spring-->
            <dependency>
                <groupId>org.mybatis.spring.boot</groupId>
                <artifactId>mybatis-spring-boot-starter</artifactId>
                <version>${mybatis.spring.boot.version}</version>
            </dependency>
            <!--junit-->
            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>${junit.version}</version>
            </dependency>
            <!--log4j-->
            <dependency>
                <groupId>log4j</groupId>
                <artifactId>log4j</artifactId>
                <version>${log4j.version}</version>
            </dependency>
            <!--lombok-->
            <dependency>
                <groupId>org.projectlombok</groupId>
                <artifactId>lombok</artifactId>
                <version>${lombok.version}</version>
            </dependency>
        </dependencies>

    </dependencyManagement>

</project>
```

#### 2.3.2、`dependencyManagement` 和 `dependencies` 的区别

`dependencyManagement` ：

`Maven` 使用此元素提供一种管理依赖版本号的方式，通常会在一个组织或者项目的最顶层的父 `POM` 中看到此元素。

使用此元素在父项目中指定版本号后，在子项目中引入指定的 `jar` 包时就不需要指定版本号。

在更新版本号时，只需要修改父项目中的 `dependencyManagement` 元素中的版本号即可。

#### 2.3.3、跳过 `Test` 

在侧边栏的 `Maven` 管理器中选中 `Toggle 'Skip Tests' Mode` 按钮，跳过 `test` 

![image-20200822175049518](Photo\4、Maven 跳过 test（2）.png).

### 2.4、创建微服务模块

**步骤： ** 

1. 创建 `Module` 
2. 配置 `POM` 
3. 配置 `YML` 
4. 主启动
5. 业务类

#### 2.4.1、创建 `module` 

- 新建 `Module` 

![image-20200822182827586](Photo\5、新建module 1（2）.png)

- 新建 `Maven` 项目

#### 2.4.2、配置 `POM` 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>springcloud-2</artifactId>
        <groupId>com.lxc.springcloud2</groupId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>cloud-provider-payment8001</artifactId>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
        </dependency>
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid-spring-boot-starter</artifactId>
        </dependency>
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
        <dependency>
            <groupId>log4j</groupId>
            <artifactId>log4j</artifactId>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

</project>
```

#### 2.4.3、配置 `YML` 

- 在 `resources` 目录下新建 `application.yaml` 文件

```yaml
server:
  port: 8001


spring:
  application:
    name: cloud-payment-service
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/db01?useUnicode=true&useSSL=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai
    username: root
    password: xxx


mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.lxc.springcloud.pojo
```

#### 2.4.4、主启动

- 新建类 `com.lxc.springcloud.PaymentMain8001` 

```java
@SpringBootApplication
public class PaymentMain8001 {
    public static void main(String[] args) {
        SpringApplication.run(PaymentMain8001.class, args);
    }
}
```

#### 2.4.5、业务类

![image-20200823092314059](Photo\6、订单管理模块业务类结构图（2）.png).

- `PaymentController` 

```java
@RestController
@RequestMapping("/payment")
@Slf4j
public class PaymentController {

    @Resource
    private PaymentService paymentService;

    @PostMapping("/add")
    public CommonResult add(Payment payment){
        int result = paymentService.add(payment);
        log.info("插入结果{}", result);
        if (result > 0){
            return new CommonResult(200, "插入成功", result);
        }else{
            return new CommonResult(410, "插入失败");
        }
    }

    @GetMapping("/find/{id}")
    public CommonResult findPaymentById(@PathVariable("id") Long id){
        Payment payment = paymentService.findPaymentById(id);
        log.info("查询结果{}", payment);
        if (payment != null){
            return new CommonResult(200, "查询成功", payment);
        }else{
            return new CommonResult(410, "查询失败 ID:" + id);
        }
    }

}
```

#### 2.4.6、测试

- 查询

![image-20200823092527530](Photo\7、订单管理模块订单查询（2）.png).

- 新建订单

![image-20200823092633893](Photo\8、订单管理模块订单插入（2）.png).

### 2.5、配置热部署

#### 2.5.1、添加 `JAR` 包

在订单模块的 `pom.xml` 文件中添加 `devtools` 的 `jar` 包。

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <scope>runtime</scope>
    <optional>true</optional>
</dependency>
```

> 注意：不要添加在父项目的 `pom.xml` 文件中

#### 2.5.2、添加插件

在父项目的主 `pom.xml` 文件中添加插件

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <configuration>
                <fork>true</fork>
                <addResources>true</addResources>
            </configuration>
        </plugin>
    </plugins>
</build>
```

#### 2.5.3、启用自动构建

打开 `File -> Settings -> Build,Execution,Deployment -> Compiler` 选中以下项。

![image-20200823094404867](Photo\9、热部署打开自动构建 1（2）.png)

快捷键 `Ctrl+Alt+Shift+/` 打开 `Maintenance` 选择 `Registry` 

![image-20200823094604895](E:\PerFile\notes\markdown\后端开发\微服务\Spring Cloud\Photo\10、热部署打开自动构建 2（2）.png).

选中指定项

![image-20200823094759374](Photo\11、热部署打开自动构建 3（2）.png)

> 最后，重启 `IDEA` 即可。

### 2.6、模块间通信

#### 2.6.1、消费者模块 `Controller` 

```java
@RequestMapping("/order")
@RestController
public class OrderController {

    private static final String URL = "http://localhost:8001";

    @Resource
    private RestTemplate restTemplate;

    @GetMapping("/add")
    public CommonResult<Payment> add(Payment payment){
        return restTemplate.postForObject(URL+"/payment/add", payment,CommonResult.class);
    }

    @GetMapping("/find/{id}")
    public CommonResult<Payment> find(@PathVariable("id") Long id){
        return restTemplate.getForObject(URL+"/payment/find/"+id, CommonResult.class);
    }

}
```

#### 2.6.2、测试时数据库 `serial` 字段为 `null` 

在订单管理模块 `Controller` 中添加 `@RequestBody` 注解接收对象

```java
@PostMapping("/add")
public CommonResult add(@RequestBody Payment payment){
    int result = paymentService.add(payment);
    log.info("插入结果{}", result);
    if (result > 0){
        return new CommonResult(200, "插入成功", result);
    }else{
        return new CommonResult(410, "插入失败");
    }
}
```

#### 2.6.3、测试

- 插入

![image-20200823104906029](Photo\12、消费者模块调用插入测试（2）.png).

- 查询

![image-20200823105004317](Photo\13、消费者模块调用查询测试（2）.png).

### 2.7、工程重构

在之前编写的两个模块中，都使用到了两个相同的 `pojo` 类，可以使用引入 `jar` 包的方式避免重复造轮子。

#### 2.7.1、新建模块

新建模块 `cloud-api-commons` 

**导包：** 

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-devtools</artifactId>
        <scope>runtime</scope>
        <optional>true</optional>
    </dependency>
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
        <optional>true</optional>
    </dependency>
    <dependency>
        <groupId>cn.hutool</groupId>
        <artifactId>hutool-all</artifactId>
        <version>5.4.0</version>
    </dependency>
</dependencies>
```

#### 2.7.2、配置模块

- 将旧模块中的 `pojo` 实体类移动到新创建的模块中。

![image-20200823111855757](Photo\14、工程重构目录结构（2）.png).

- 将旧模块中的 `pojo` 实体类删除
- 将新创建的模块打包
  - 点击侧边栏 `Maven` 
  - 选中 `cloud-api-commons` 模块
  - 点击 `clean` 
  - 点击 `install` 
- 将模块引入
  - 编写两个旧模块 `cloud-consumer-order80 & cloud-provider-payment8001` 的 `pom.xml` 

```xml
<dependency>
    <groupId>com.lxc.springcloud</groupId>
    <artifactId>cloud-api-commons</artifactId>
    <version>${project.version}</version>
</dependency>
```

