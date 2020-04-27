# Java随机数

## 一、如何生成随机数

### 1.1使用Random类

| Modifier and Type | Method and Description                                       |
| ----------------- | ------------------------------------------------------------ |
| `DoubleStream`    | `doubles()`  返回一个有效的无限流的伪随机 `double`值，每个值在零（包括）和一（独占）之间。 |
| `DoubleStream`    | `doubles(double randomNumberOrigin,  double randomNumberBound)`  返回一个有效的无限流伪 `double`值 `double`  ，每个值都符合给定的起始（包括）和绑定（排他）。 |
| `DoubleStream`    | `doubles(long streamSize)`  返回一个流，产生给定的 `streamSize`伪 `double`数值  `double` ，每个值在零（包括）和一（独占）之间。 |
| `DoubleStream`    | `doubles(long streamSize,  double randomNumberOrigin, double randomNumberBound)`  返回一个流，产生给定的 `streamSize`伪 `double`数值  `double` ，每个值符合给定的起始（包括）和绑定（排他）。 |
| `IntStream`       | `ints()`  返回一个有效的无限流的伪 `int`值。                 |
| `IntStream`       | `ints(int randomNumberOrigin,  int randomNumberBound)`  返回一个有效的无限流伪 `int`值 `int`  ，每个值都符合给定的起始（包括）和绑定（排他）。 |
| `IntStream`       | `ints(long streamSize)`  返回一个流，产生给定的 `streamSize`数 `int`值。 |
| `IntStream`       | `ints(long streamSize,  int randomNumberOrigin, int randomNumberBound)`  返回一个流，产生给定的 `streamSize`数  `int`值，每个符合给定的起始（包括）和绑定（排他）。 |
| `LongStream`      | `longs()`  返回一个有效的无限流的伪 `long`值。               |
| `LongStream`      | `longs(long streamSize)`  返回一个流，产生给定的 `streamSize`数 `long`值。 |
| `LongStream`      | `longs(long randomNumberOrigin,  long randomNumberBound)`  返回一个有效的无限流伪 `long`值 `long`  ，每个符合给定的起始（包括）和绑定（排他）。 |
| `LongStream`      | `longs(long streamSize,  long randomNumberOrigin, long randomNumberBound)`  返回一个流，产生给定的 `streamSize`数 `long`  ，每个符合给定的起始（包括）和绑定（排他）。 |
| `protected int`   | `next(int bits)`  生成下一个伪随机数。                       |
| `boolean`         | `nextBoolean()`  返回下一个伪随机数，从这个随机数发生器的序列中均匀分布 `boolean`值。 |
| `void`            | `nextBytes(byte[] bytes)`  生成随机字节并将它们放入用户提供的字节数组中。 |
| `double`          | `nextDouble()`  返回下一个伪随机数，从这个随机数发生器的序列中 `0.0`和 `1.0`之间的  `double`值 `0.0`分布。 |
| `float`           | `nextFloat()`  返回下一个伪随机数，从这个随机数发生器的序列中 `0.0`和 `1.0`之间的  `float`值 `0.0`分布。 |
| `double`          | `nextGaussian()`  从该随机数发生器的序列返回下一个伪随机数，高斯（“正”）分布 `double`值，平均值为  `0.0` ，标准差为 `1.0` 。 |
| `int`             | `nextInt()`  返回下一个伪随机数，从这个随机数发生器的序列中均匀分布 `int`值。 |
| `int`             | `nextInt(int bound)`  返回伪随机的，均匀分布 `int`值介于0（含）和指定值（不包括），从该随机数生成器的序列绘制。 |
| `long`            | `nextLong()`  返回下一个伪，均匀分布 `long`从这个随机数生成器的序列值。 |
| `void`            | `setSeed(long seed)`  使用单个 `long`种子设置该随机数生成器的种子。 |

### 1.2使用Math类的random方法

|More ActionsModifier and Type|Method and Description|
| --------------- | ------------------------------------------------------------ |
| `static double` | `random()`  返回值为 `double`值为正号，大于等于 `0.0` ，小于  `1.0` |

### 1.3使用System中的currentTimeMillis()方法

|More ActionsModifier and Type|Method and Description|
| ------------- | ----------------------------------------------------- |
| `static long` | `currentTimeMillis()`  返回当前时间（以毫秒为单位）。 |

## 二、生成指定范围的随机数

三种生成方式对比

```java
public class test2 {

    public static void main(String[] args) {
        long startTime = System.currentTimeMillis();
        for (int i = 0; i < 10000000; i ++){
            getRandom(1000, 9999);
        }
        long endTime = System.currentTimeMillis();
        System.out.println((endTime-startTime)+"ms");

        long startTime1 = System.currentTimeMillis();
        for (int i = 0; i < 10000000; i ++){
            getRandom1(1000, 9999);
        }
        long endTime1 = System.currentTimeMillis();
        System.out.println((endTime1-startTime1)+"ms");

        long startTime2 = System.currentTimeMillis();
        Random random = new Random();
        for (int i = 0; i < 10000000; i ++){
            getRandom2(random, 1000, 9999);
        }
        long endTime2 = System.currentTimeMillis();
        System.out.println((endTime2-startTime2)+"ms");
    }

    private static int getRandom(int a, int b){
        return ((int) (Math.random() * (b - a + 1)) + a);
    }

    private static int getRandom1(int a, int b) {
        return new Random().nextInt(b - a) + a;
    }

    private static int getRandom2(Random random, int a, int b){
        return random.nextInt(b - a + 1) + a;
    }
}
```

结果

```
218ms
660ms
119ms
```

- 由于第二种方法在多次生成随机数时会不断重复实例化Random类，造成较大的性能浪费

## 三、生成不重复的随机数

使用hashMap生成

```java
Object[] values = new Object[100];
Random random = new Random();
HashMap<Object, Object> hashMap = new HashMap<Object, Object>(50);
for(int i = 0;i < values.length;i++){
	int number = random.nextInt(100) + 1;
	hashMap.put(number, i);
}
values=hashMap.keySet().toArray();
System.out.println(hashMap.size());
// 打印数据
for(int i = 0;i < values.length;i++){
	System.out.print(values[i] + ",");
}
```

