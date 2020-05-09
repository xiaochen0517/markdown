# `JVM`内存结构

- 程序计数器
- 虚拟机栈
- 本地方法栈
- 堆
- 方法区

## 一、程序计数器

### 1.1定义

- `Program Counter Register` 程序计数器（寄存器）

### 1.2作用

- 在`java`程序执行前会将`java`文件编译为二进制字节码（`jvm`指令）
- 计数器的作用就是记住下一条`jvm`指令的执行地址（储存在寄存器中）

### 1.3特点

- 线程私有
- 不会存在内存溢出

## 二、虚拟机栈`（JVM Stacks）`

### 2.1虚拟机栈

- 每个线程运行时所需要的内存，称为虚拟机栈
- 栈的特点：先进后出，后进先出
- 每个栈是由多个栈帧`（Frame）`组成，对应每次方法调用时占用的内存
- 每个线程只能有一个活动栈帧，对应着当前正在执行的方法
- 使用虚拟机参数`-Xss【大小】`控制虚拟机栈的空间大小

### 2.2栈帧

- 每个方法运行时需要的内存
- 栈帧中包含的内容
  - 参数
  - 局部变量
  - 返回地址

### 2.3注意

- 垃圾回收不涉及栈内存
- 在方法中的局部变量没有脱离方法的作用范围，则它是线程安全的
- 若局部变量引用了对象，并脱离了方法的作用范围，则需要考虑线程安全

### 2.4栈内存溢出

- 栈帧过多导致栈内存溢出
- 栈帧过大导致栈内存溢出

### 2.5线程运行诊断

#### 2.5.1`cpu`占用过多

- 使用`top`命令定位进程号
- 使用`ps H -eo pid,tid,%cpu | grep 进程id`定位线程id
- 使用`jstack 进程id`
  - 将10进制线程id转换为16进制后定位问题代码行数

#### 2.5.2长时间运行得不到结果（线程死锁）

- 使用`top`命令定位进程号
- 使用`jstack 进程id`定位错误代码行数

## 三、本地方法栈`（Native Method Stacks）`

- 本地方法栈的功能和特点类似于虚拟机栈，均具有线程隔离的特点以及都能抛出`StackOverflowError`和`OutOfMemoryError`异常。

- 不同的是，本地方法栈服务的对象是`JVM`执行的`native`方法，而虚拟机栈服务的是`JVM`执行的`java`方法。对于`native`方法虚拟机规范并未给出强制规定，因此不同的虚拟机实可以进行自由实现，我们常用的`HotSpot`虚拟机选择合并了虚拟机栈和本地方法栈。

## 四、堆`（Heap）`

### 4.1定义

- 使用`new`关键字创建的对象都会使用堆内存

### 4.2特点

- 它是线程共享的，堆中的对象都要考虑线程安全问题
- 有垃圾回收机制

### 4.3堆内存溢出

- 代码

```java
int i = 0;
try {
	List<String> strs = new ArrayList<>();
	String a = "hahahaha";
	while (true){
		strs.add(a);
		a = a + a;
		i ++;
	}
}catch (Throwable e){
	e.printStackTrace();
	System.out.println(i);
}
```

- 错误：`java.lang.OutOfMemoryError: Java heap space`

- 使用`-Xmx【大小】`控制堆空间大小

### 4.4堆内存诊断

- `jps`工具
  - 查看当前系统中有哪些`java`进程
- `jmap`工具
  - 查看堆内存占用情况：`jmap -heap 进程id`
- `jconsole`工具
  - 图形界面的，多功能监测工具，可以连续监测

- `jvisualvm`工具
  - 在`jdk9`之后需要自行下载
  - [下载网址](http://visualvm.github.io/)

## 5.方法区`（Method Area）`

### 5.1组成

#### 5.1.1`1.6`版本

![](photo\jvm方法区1.6.png).

#### 5.1.2`1.8`版本

![](photo\jvm方法区1.8.png).

### 5.2方法区内存溢出

- 添加`jvm`参数：`-XX:MaxMetaspaceSize=10m`

- 源码

  - ```java
    int j = 0;
    try{
    	Test5 test5 = new Test5();
    	for(int i = 0; i < 10000; i ++, j++){
    		//ClassWriter 作用是生成类的二进制字节码
    		ClassWriter cw = new ClassWriter(0);
    		//版本号，访问修饰符，类名，包名，父类，接口
            cw.visit(Opcodes.V1_8,
                     Opcodes.ACC_PUBLIC,
                     "Class"+i,
                     null,
                     "java/lang/Object", 
                     null);
    		byte[] code = cw.toByteArray();
    		test5.defineClass("Class"+i, code, 0, code.length);
    	}
    }finally {
    	System.out.println(j);
    }
    ```

  - 需要配置`asm`的`jar`包

- 错误：`java.lang.OutOfMemoryError: Compressed class space`

### 5.3运行时常量池

- 常量池，就是一张表，虚拟机指令根据这张常量表找到要执行的类名、方法名、参数类型、字面量等信息
- 运行时常量池，常量池时*.class文件中的，当该类被加载，它的常量池信息就会放入运行时常量池，并把里面的符号地址变为真实的地址

































































