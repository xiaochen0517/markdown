[TOC]

# JVM垃圾回收

## 一、如何判断对象可以回收

### 1、引用计数法

使用引用计数的方式判断对象是否需要回收

**缺点：**当两个对象循环引用时会导致引用计数法失效

![](photo\jvm对象循环调用.png).

> `jvm`没有使用此方法

### 2、可达性分析算法

确定根对象（不可以被回收的对象），对堆中的所有对象进行扫描，判断对象是否被根对象直接或间接引用，被引用则不可以被回收。

#### 2.1使用ecplise工具Memory Analyzer

- [下载地址](https://www.eclipse.org/mat/downloads.php)

#### 2.2示例代码

```java
List<Object> listos = new ArrayList<>();
listos.add("a");
listos.add("b");
System.out.println("1");
System.in.read();

listos = null;
System.out.println("2");
System.in.read();
System.out.println("end..........");
```

#### 2.3生成堆转储文件

- 查看java进程

```
jps
```

- 使用以下命令进行堆转储

```
jmap -dump:format=b,live,file=要储存的文件名 进程id
```

#### 2.4使用Memory Analyzer

- 使用`File`->`Open File`打开堆转储文件
- 打开`Java Basics`->`GC Roots`

![](photo\mat查看gc root方法.png)

#### 2.5结果图示

- 引用`ArrayList`对象时

![](photo\jvm1bin根对象.png).

- 将对象置空，垃圾回收后

![](photo\jvm2bin根对象.png).

### 3、引用方式

![](photo\jvm垃圾回收对象引用示意图.png)

#### 3.1强引用

当对象没有任何根对象`(GC Roots)`强引用时就可以被回收

#### 3.2软引用（SoftReference）

当对象只有软引用对象引用时，并且发生一次垃圾回收并且内存依旧不足的情况下再次进行垃圾回收，此时会回收该对象

当软引用对象引用的对象被垃圾回收后，软引用对象会进入引用队列，以便进行内存回收

#### 3.3弱引用（WeakReference）

当对象仅有弱引用对象引用时，在垃圾回收时会直接回收该对象，无论内存是否充足

当弱引用对象引用的对象被垃圾回收后，弱引用对象会进入引用队列，以便进行内存回收

#### 3.4虚引用（PhantomReference）

此引用方式必须配合引用队列使用

在创建ByteBuffer时会有一个虚引用对象Cleaner引用ByteBuffer，在没有根对象引用这个ByteBuffer对象时，ByteBuffer就可以被垃圾回收。但是在ByteBuffer对象被垃圾回收后，它使用的直接内存是没有被释放的，此时虚引用对象Cleaner就会进入引用队列。此时后台进程ReferenceHandler会检查引用队列，并执行Cleaner对象中的clean方法在其中调用`Unsafe.freeMemory`方法对直接内存进行释放操作

#### 3.5终结器引用（FinalReference）

在重写finallize方法的对象没有根对象强引用它时，在垃圾回收时，jvm会创建一个终结器引用对象，并将此终结器对象放入引用队列。此时会由后台线程FinalizerThread会使用终结器对象引用调用对象中的finallize方法，此时，对象就可以被垃圾回收。

#### 3.6示例（软引用）

```java
        List<SoftReference<byte[]>> list = new ArrayList<>();
        
        //创建引用队列
        ReferenceQueue<byte[]> referenceQueue = new ReferenceQueue<>();
        for (int i = 0; i < 5; i++) {
            //将引用队列与软引用关联
            SoftReference<byte[]> softReference = new SoftReference<>(new byte[_4M], referenceQueue);
            System.out.println(softReference.get());
            list.add(softReference);
            System.out.println(list.size());
        }

        //将引用队列中最先进入队列的软引用对象取出，并从list中移除
        Reference<? extends byte[]> poll = referenceQueue.poll();
        while (poll != null){
            list.remove(poll);
            poll = referenceQueue.poll();
        }

        System.out.println("over---------------");
        for (SoftReference<byte[]> sr : list){
            System.out.println(sr.get());
        }

        /**
         * 输出：
         * [B@1d81eb93
         * [B@7291c18f
         */
```

## 二、垃圾回收算法

### 1、标记清除

定义：Mark Sweep

- 图示

![](photo\jvm垃圾回收流程.png).

- 会导致存入较大的对象时因为碎片化程度较高，有可能导致内存溢出

### 2、标记整理

定义：Mark Compact

- 图示

![](photo\jvm标记整理垃圾回收流程.png).

- 标记整理时需要移动内存中对象的位置，所以对性能耗费较大

### 3、复制

定义：Copy

- 图示

![](photo\jvm复制垃圾回收流程.png).

- 由于此方式会将内存分为两个区，因此会占用双份的内存空间

## 三、分代垃圾回收

![](photo\jvm分代垃圾回收示意图.png)

在对象新创建时会加入伊甸园，当伊甸园的空间不足之后会触发一次Minor GC ，将伊甸园和from存活的对象使用Copy复制到幸存区To中，将存活的对象年龄加1并交换From和To。在触发Minor GC时会引发Stop the world，暂停其他用户的线程，等垃圾回收结束，用户线程才恢复运行。在对象寿命超过阈值时，会晋升至老年代，最大寿命是15（4 bit）。当老年代空间不足，会尝试触发Minor GC，如果之后空间仍然不足，会触发Full GC，STW的时间更长。

### 1、相关VM参数

| 含义                | 参数                                                         |
| ------------------- | ------------------------------------------------------------ |
| 堆初始大小          | `-Xms`                                                       |
| 堆最大大小          | `-Xms` 或 `-XX:MaxHeapSize=size`                             |
| 新生代大小          | `-Xmn` 或 (`-XX:NewSize=size + -XX:MaxNewSize=size`)         |
| 幸存区比例（动态）  | `-XX:InitialSurvivorRatio=ratio` 和 `-XX:+UseAdaptiveSizePolicy` |
| 幸存区比例          | `-XX:SurvivorRatio=ratio`                                    |
| 晋升阈值            | `-XX:MaxTenuringThreshold=threshold`                         |
| 晋升详情            | `-XX:+PrintTenuringDistribution`                             |
| GC详情              | `-XX:+PrintGCDetails -verbose:gc`                            |
| Full GC 前 Minor GC | `-XX:+ScavengeBeforeFullGC`                                  |

## 四、垃圾回收器

### 1、串行

- 单线程
- 堆内存较小，适合个人电脑

`-XX:+UseSerialGC = Serial + SerialOld`

![](photo\jvm串行垃圾回收器示例图.png).

### 2、吞吐量优先

- 多线程
- 堆内存较大，多核CPU
- 让单位时间内，STW的时间最短 0.2 0.2 = 0.4

`-XX:+UseParallelGC ~ -XX:+UseParallelOldGC`

`-XX:+UseAdaptiveSizePolicy`：新生代自适应大小调整策略

`-XX:GCTimeRatio=ratio`：默认值：99，公式：`1/(1+ratio)`会根据此公式动态调整堆大小

`-XX:MaxGCPauseMillis=ms`：默认值`200ms`，`GC`最大用时，会根据此值动态调整堆大小

`-XX:ParallelGCThreads=n`：控制线程数

![](photo\jvm吞吐量垃圾回收器示例图.png).

### 3、响应时间优先

- 多线程
- 堆内存较大，多核CPU
- 尽可能让单次STW的时间最短 0.1 0.1 0.1 0.1 0.1 = 0.5

`-XX:+UseConcMarkSweepGC ~ -XX:+UseParNewGC ~ SerialOld`

`-XX:ParallelGCThreads=n ~ -XX:ConcGCThreads=threads`：参数一：并行垃圾回收线程数，默认为CPU核数。参数二：并发垃圾回收线程数，一般为并行垃圾回收线程数的四分之一。

`-XX:CMSInitiatingOccupancyFraction=Percent`：当内存占用达到多少百分比时执行垃圾回收

`-XX:+CMSScavengeBeforeRemark`：在重新标记之前先进行一次新生代垃圾回收

![](photo\jvm响应时间优先垃圾回收器示例图.png)

