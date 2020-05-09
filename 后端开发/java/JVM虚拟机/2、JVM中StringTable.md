# `JVM`中`StringTable`

## 三、特性

- 常量池中的字符串仅是符号，第一次用到时才变为对象
- 利用串池的机制，来避免重复创建字符串对象
- 字符串变量拼接的原理是`StringBuilder`（1.8）
- 字符串常量拼接的原理是编译器优化
- 可以使用intern方法，主动将串池中还没有的字符串对象放入串池

## 二、`JVM`编译期优化

- `StringTable`为`hashtable`结构，不能扩容

- ```java
  public static void main(String[] args) {
  	String s1 = "a";
  	String s2 = "b";
  	String s3 = "ab";
      //new StringBuilder().append("a").append("b").toString() new String("ab")
  	String s4 = s1 + s2;
  	String s5 = "a" + "b";
  }
  ```

- ```
  ldc #2 会把a符号变为"a"字符串对象
  ldc #3 会把b符号变为"b"字符串对象
  ldc #4 会把ab符号变为"ab"字符串对象
  ```

- 当执行`String s4 = s1 + s2;`时，相当于执行`new String("ab")`

- 当在执行`String s5 = "a" + "b";`时，编译器会自动优化，同`String s3 = "ab";`同样

## 三、字符串延迟加载

- `jvm`只有在执行到`string`创建的行时才会创建对象
- 创建好的相同字符串不会重复创建

```java
        String s1 = "1";//字符串对象：3153
        String s2 = "2";
        String s3 = "3";
        String s4 = "4";
        String s5 = "5";
        String s6 = "6";

        String s11 = "1";//字符串对象：3159
        String s21 = "2";
        String s31 = "3";
        String s41 = "4";
        String s51 = "5";
        String s61 = "6";//字符串对象：3159
```

## 四、`intern()`

- 作用：将指定字符串尝试放入`StringTable`
- 语法：`字符串对象.intern()`

- 示例：

```java
//在堆中创建一个string对象
String s = new String("a") + new String("b");
//将此string对象中的值尝试放入StringTable，并将串池中的对象返回,
String s1 = s.intern();
System.out.println(s1 == "ab"); // true
System.out.println(s == "ab"); // true
```

> 注意：当串池中没有`intern`尝试放入的字符串时，会将字符串放入串池，此时`s`也变为了串池中的对象

> 在1.6中会将`s`复制一份放入串池中，并不会改变`s`的位置

```java
//在串池中添加"ab"
String x = "ab";
//在堆中创建一个string对象
String s = new String("a") + new String("b");
//将此string对象中的值尝试放入StringTable，并将串池中的对象返回（并没有成功放入）
System.out.println(s1 == x); // true
System.out.println(s == x); // false
```

> 注意：当串池中已经存在`intern`尝试放入的字符串时，则不会将字符串放入串池，此时`s`还是堆中的对象，所以`s`不等于`x`

## 五、`StringTable`调优

- 使用`-XX:StringTableSize=大小`参数增加桶的数量使`StringTable`性能增加
- 实际使用：

```java
    public static void main(String[] args) {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(new File("f:\\test.txt"))));
            String line = null;
            long start = System.nanoTime();
            while (true) {
                line = reader.readLine();
                if (line == null) {
                    break;
                }
                line.intern();
            }
            System.out.println("cost:" + (System.nanoTime() - start) / 1000000);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

```

- 通过读取文件将文件中的每一行逐行加入到`StringTable`中,修改桶的大小来测试所需要的时间（文件为8145行）

| `StringTableSize` | Time   |
| ----------------- | ------ |
| 128               | 172 ms |
| 1024              | 116 ms |
| 4096              | 87 ms  |

> 入池去重，以及对性能的优化

- 源码

```java
    public static void main(String[] args) {
        try {
            List<String> list = new ArrayList<>();
            System.in.read();
            for (int i = 0; i < 30; i++) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(new File("f:\\test.txt"))));
                String line = null;
                long start = System.nanoTime();
                while (true) {
                    line = reader.readLine();
                    if (line == null) {
                        break;
                    }
                    //不入池
                    list.add(line);
                    //入池
                    //list.add(line.intern());
                }
                System.out.println("cost:" + (System.nanoTime() - start) / 1000000);
            }
            System.in.read();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
```

- 不入池

![](photo\StringTable未入池性能数据.png)

- 入池

![](photo\StringTable入池后性能数据.png)

> `string`对象大小从`6m`降到`500k`，byte数组从`16m`降到`1m`