[TOC]

# JVM Garbage First 垃圾回收器

定义：Garbage First

- 2004论文发布
- 2009 JDK 6u14 体验
- 2012 JDK 7u4 官方支持
- 2017 JDK 9 默认

使用场景：

- 同时注重吞吐量（Throughput）和低延迟（Low latency），默认的暂停目标是200 ms
- 超大堆内存，会将堆划分为多个大小相等的Region
- 整体上是标记+整理算法，两个区域之间是复制算法

相关JVM参数

`-XX:+UseG1GC`

`-XX:G1HeapRegionSize=size`：堆内存Region大小

`-XX:MaxGCPauseMillis=time`：暂停目标时间



![](photo\jvm垃圾回收器G1垃圾回收阶段流程图.png).

### 1、Young Collection

> 会发生 STW（Stop The World）

- 初始阶段，新生成的对象会进入伊甸园

![](photo\jvm垃圾回收器G1垃圾回收阶段1.png)

- 在发生垃圾回收时，伊旬园中的未被回收的对象会进入幸存区

![](photo\jvm垃圾回收器G1垃圾回收阶段2.png)

- 再次发生垃圾回收时，伊旬园中的未被回收的新对象会复制到一个新的幸存区（Region块），并将旧幸存区中达到指定阈值的对象复制到老年代，没有被回收且没有达到阈值的对象复制到新的幸存区

![](photo\jvm垃圾回收器G1垃圾回收阶段3.png)

### 2、Young Collection + CM

- 在 Young GC 会进行 GC Root 的初始标记
- 老年代占用堆空间比例达到阈值时，进行并发标记（不会 STW），由下面的 JVM 参数决定

```
-XX:InitiatingHeapOccupancyPercent=percent （默认为45%)
```

![](photo\jvm垃圾回收器G1垃圾回收阶段4.png)

### 3、Mixed Collection

会对伊甸园、幸存区、老年代进行全面的垃圾回收

- 最终标记（Remark）会发生 STW
- 拷贝存货（Evacuation）会发生 STW

```
-XX:MaxGCPauseMillis=ms
```

在此阶段伊甸园中的未被回收的对象会复制到幸存区中，同时幸存区中也会进行垃圾回收，将幸存区中未被回收的对象复制到新的幸存区中，寿命到达指定阈值的对象复制到老年代中。在回收老年代时也是同样使用复制算法，并根据设置的最大暂停时间，优先回收其中回收价值最高的部分老年代中的对象。

![](photo\jvm垃圾回收器G1垃圾回收阶段5.png)

### 4、Full GC

- Serial GC
  - 新生代内存不足发生的垃圾回收：Minor GC
  - 老年代内存不足发生的垃圾回收：Full GC
- Parallel GC
  - 新生代内存不足发生的垃圾回收：Minor GC
  - 老年代内存不足发生的垃圾回收：Full GC
- CMS
  - 新生代内存不足发生的垃圾回收：Minor GC
  - 到老年代所占空间达到设置的阈值时，会触发并发标记后混合回收，当并发垃圾回收失败时就会发生Full GC
- G1
  - 新生代内存不足发生的垃圾回收：Minor GC
  - 到老年代所占空间达到设置的阈值时，会触发并发标记后混合回收，此时，垃圾回收的速度小于垃圾产生的速度时，就会发生Full GC

### 5、Young Collection 跨带引用

- 新生代回收的跨代引用（老年代引用新生代）

- 在新生代中进行垃圾回收时，要找到根对象（GC Root）进行可达性分析，而部分新生代中对象的根对象（GC Root）时在老年代中的。而遍历老年代查找根对象效率较低，因此使用卡表（Card Table）将老年代细分为卡（Card）组成的卡表（Card Table），当老年代中的对象引用了新生代中的对象，则会把老年代中对应的卡（Card）标记为脏卡（Dirty Card）。此时，在老年代中的对象引用新生代中的对象后，进行垃圾回收时就不必遍历整个老年代，提升垃圾回收的效率。

- 在新生代对象中有一个Remembered Set，记录着老年代中引用此新生代对象的脏卡（Dirty Card），在进行垃圾回收时就可以通过Remembered Set找到对应的脏卡（Dirty Card），然后通过脏卡（Dirty Card）遍历根对象（GC Root）。

- 在对象引用变更时通过写后屏障（Post-Write Barrier）和脏卡队列（Dirty Card Queue）
- Remembered Set通过Concurrent Refinement Threads更新

![](photo\jvm垃圾回收器G1垃圾回收跨代引用.png)

### 6、Remark

在垃圾回收器进行并发标记阶段时，会在可以回收的对象上加入写屏障（Pre-Write Barrier），以防对象在标记后发生引用变化后依旧清除对象。

![](photo\jvm垃圾回收器G1垃圾回收阶段Remark写屏障.png).

![](photo\jvm垃圾回收器G1垃圾回收阶段Remark1.png).

当添加写屏障（Pre-Write Barrier）的对象发生引用变化之后，写屏障会将对象加入satb_mark_queue，在重新标记（Remark）时（会发生 STW）就会重新判断satb_mark_queue中的对象是否可以被清除。

![](photo\jvm垃圾回收器G1垃圾回收阶段Remark2.png).

### 7、JDK 8u20 字符串去重

- 优点：节省大量内存
- 缺点：略微多占用了cpu时间，新生代回收时间略微增加

```
-XX:UseStringDeduplication
```

```java
String s1 = new String("hello"); //char[]{'h', 'e', 'l', 'l', 'o'}
String s2 = new String("hello"); //char[]{'h', 'e', 'l', 'l', 'o'}
```

- 将所有新分配的字符串放入一个队列
- 当新生代回收时，G1并发检查是否有字符串重复
- 如果它们值一样，让它们引用同一个char[]

> 注意：此字符串去重与`String.intern()`不同，`String.intern()`关注的是字符串对象而字符串去重关注的是`char[]`在JVM内部，使用了不同的字符串表。

### 8、JDK 8u40 并发标记类卸载

所有对象都经过并发标记后，就知道哪些类不再被使用，当一个类加载器的所有类都不在使用，则卸载它所加载的所有类

```
-XX:+ClassUnloadingWithConcurrentMark // 默认启用
```

### 9、JDK 8u60 回收巨型对象

- 一个对象大于Regin的一半时，称之为巨型对象
- G1不会对巨型对象进行拷贝
- 回收时被优先考虑
- G1会跟踪老年代所有incoming引用，这样老年代incoming引用为0的巨型对象就可以在新生代垃圾回收时处理掉

![](photo\jvm垃圾回收器G1垃圾回收阶段巨型对象.png)

### 10、JDK 9 并发标记起始时间调整

- 并发标记必须在堆空间占满前完成，否则退化为Full GC
- JDK 9 之前需要使用`-XX:InitiatingHeapOccupancyPercent`
- JDK 9 可以动态调整
  - `-XX:InitiatingHeapOccupancyPercent` 用来设置初始值
  - 进行数据采样并动态调整
  - 总会添加一个安全的空档空间













