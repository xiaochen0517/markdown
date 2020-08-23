# JVM直接内存

## 一、定义

Direct Memory

- 常见于`NIO`操作时，用于数据缓冲区
- 分配回收成本较高，但读写性能高
- 不受`JVM`内存回收管理

**图示**

![](photo\JVM直接内存.png)

## 二、示例

```java
package com.mochen.test;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

/**
 * 功能：
 *
 * @author MoChen
 * Date  2020/2/6
 * @version 0.1
 */
public class Test11 {

    static final String FROM = "F:\\下载文件\\Firefox\\android-studio.zip";
    static final String TO = "F:\\android-studio.zip";
    static final int _1Mb = 1024 * 1024;
    static final int _10Mb = 1024 * 1024 * 10;

    public static void main(String[] args) {
        //文件大小：721MB
        io(); // io 用时：5379.0736ms
        directBuffer(); // directBuffer 用时：3114.0023ms
    }

    private static void directBuffer() {
        long start = System.nanoTime();
        try {
            FileChannel from = new FileInputStream(FROM).getChannel();
            FileChannel to = new FileOutputStream(TO).getChannel();
            ByteBuffer bb = ByteBuffer.allocateDirect(_1Mb);
            while (true) {
                int len = from.read(bb);
                if (len == -1) {
                    break;
                }
                bb.flip();
                to.write(bb);
                bb.clear();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        long end = System.nanoTime();
        System.out.println("directBuffer 用时：" + (end - start) / 1000_000.0);
    }

    private static void io() {
        long start = System.nanoTime();
        try {
            FileInputStream from = new FileInputStream(FROM);
            FileOutputStream to = new FileOutputStream(TO);
            byte[] buf = new byte[_1Mb];
            while (true) {
                int len = from.read(buf);
                if (len == -1) {
                    break;
                }
                to.write(buf, 0, len);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        long end = System.nanoTime();
        System.out.println("io 用时：" + (end - start) / 1000_000.0);
    }

}
```

## 三、内存溢出

```java
    // Cannot reserve 104857600 bytes of direct buffer memory (allocated: 2097160192, limit: 2116026368)
    public static void main(String[] args) {
        List<ByteBuffer> list = new ArrayList<>();
        int i = 0;
        try{
            while (true){
                ByteBuffer byteBuffer = ByteBuffer.allocateDirect(1024*1024*100);
                list.add(byteBuffer);
                i ++;
            }
        }finally {
            System.out.println(i); // 20
        }
    }
```

## 四、分配和回收原理

- 使用了`Unsafe`对象完成直接内存的分配回收，并且回收需要主动调用`freeMemory`方法

- `ByteBuffer`的实现类内部，使用了`Cleaner`（虚引用）来检测`ByteBuffer`对象，一旦`ByteBuffer`对象被垃圾回收，那么就会由`ReferenceHandler`线程通过Cleaner的clean方法调用`freeMemory`来释放直接内存