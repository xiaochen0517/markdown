# Android开发——JNI

## 一、什么是JNI

JNI全称为java native interface（java本地开发接口）

作用：相当于桥梁的作用，是一种协议

通过JNI就可以让java调用C语言

![](photo\JNI原理示意图.png).

**Android系统架构：**

![](photo\安卓系统架构.png).

## 二、JNI基础应用

### 2.1JNI数据类型对照表

| Java类型 | JNI别名  | 本地类型       |
| -------- | -------- | -------------- |
| boolean  | jboolean | unsigned char  |
| byte     | jbyte    | signed char    |
| char     | jchar    | unsigned short |
| short    | jshort   | short          |
| int      | jint     | int            |
| long     | jlong    | long long      |
| float    | jfloat   | float          |
| double   | jdouble  | double         |

### 2.2C++调用Java方法

#### 2.2.1Java中调用

**语法：**

```java
权限修饰符 native 返回值类型 方法名();
```

**示例：**

```java
public native String stringFromJNI();
```

#### 2.2.2C++中实现

**语法：**

- `JNIEnv`：`JNI`工具类
- `jobject`：调用此方法的`Java`类实例

```c++
extern "c" JNIEXPORT 返回类型（使用JNI类型） JNICALL Java_全类名_方法名（类名方法名之间使用下划线分隔）(JNIEnv *env, jobject thiz){}
```

**示例：**

```c++
extern "C" JNIEXPORT jstring JNICALL
Java_com_lxc_jnitest1_MainActivity_helloC(JNIEnv *env, jobject thiz) {
    return env->NewStringUTF("hello word");
}
```

#### 2.2.3运行结果

<img src="photo\JNI基础应用运行结果.png" style="zoom:75%;" />

### 2.3C++调用Java方法

- 使用Java方法调用C++函数，在C++函数中调用Java方法

#### 2.3.1创建Java方法

```java
    /**
     * 运行Test1Method();
     */
    public native void runTest1();

    /**
     * 运行Test2Method();
     */
    public native void runTest2();

    public void Test1Method(){
        Log.d(TAG, "test1 is runing");
    }

    public int Test2Method(int a, int b){
        return a+b;
    }
```

#### 2.3.2生成头文件

- 在`jdk10`之后`javah`命令已经被删除
- 进入所在类目录中使用命令：`javac -h c 类名.java`

![](photo\JNI生成头文件报错.png)

> 此错误是因为javac在编译时找不到`android.util.Log`包导致的
>
> 解决：将代码中的相关代码注释掉，重新编译成功后再打开注释

- 注释代码，再次编译
- 此时，会生成对应`java`文件的`class`字节码文件和c目录下的头文件

![](photo\JNI生成头文件后目录结构.png).

- 将头文件移到`cpp`文件夹中，并删除编译的`class`文件

![](photo\JNI移动头文件到指定目录.png).

#### 2.3.3编写C++代码

- 在cpp文件中引入生成的头文件
- 实现`runTest1`和`runTest2`的方法
- 调用`Java`方法具体步骤
  - 获取`Java`字节码
    - 使用`env->FindClass();`方法
    - 参数：需要调用的方法所在类的全限定类名，其中`.`用`/`代替
  - 获取要执行的方法
    - 使用`env->GetMethodID();`
    - 参数一：第一步获取的`Java`类字节码
    - 参数二：方法名
    - 参数三：签名——[详情](jkdf)
  - 实例化对象
    - 使用`env->AllocObject():`
    - 参数：第一步获取的`Java`类字节码
  - 执行方法
    - 使用`env->CallxxxxMethod();`方法，根据要调用的方法的返回值所定
    - 参数一：实例化对象
    - 参数二：获取到的方法`jmethodID`



**完整C++源码：**

```c++
#include <jni.h>
#include "com_lxc_jnitest1_JNITest.h"
#include <string>
#include <android/log.h>

using namespace std;

const string TAG = "hello.cpp";

extern "C" JNIEXPORT void JNICALL
Java_com_lxc_jnitest1_JNITest_runTest1(JNIEnv *env, jobject) {
    //获取字节码
    jclass jclazz = env->FindClass("com/lxc/jnitest1/JNITest");
    //获取方法
    jmethodID  jmethodId = env->GetMethodID(jclazz, "Test1Method", "()V");
    //实例化对象
    jobject  jobj = env->AllocObject(jclazz);
    //执行方法
    env->CallVoidMethod(jobj, jmethodId);
};

extern "C" JNIEXPORT void JNICALL
Java_com_lxc_jnitest1_JNITest_runTest2 (JNIEnv* env, jobject){
    //获取字节码
    jclass jclazz = env->FindClass("com/lxc/jnitest1/JNITest");
    //获取方法
    jmethodID  jmethodId = env->GetMethodID(jclazz, "Test2Method", "(II)I");
    //实例化对象
    jobject  jobj = env->AllocObject(jclazz);
    //执行方法
    jint value = env->CallIntMethod(jobj, jmethodId, 18, 20);
    //打印
    __android_log_write(ANDROID_LOG_DEBUG, TAG.c_str(), ("value is "+to_string(value)).c_str());
};
```

#### 2.3.4调用静态方法

```c++
extern "C" JNIEXPORT void JNICALL
Java_com_lxc_jnitest1_JNITest_runTest3(JNIEnv * env, jobject){
    //获取字节码
    jclass jclazz = env->FindClass("com/lxc/jnitest1/JNITest");
    //获取静态方法
    jmethodID jmethodId = env->GetStaticMethodID(jclazz, "Test3Method", "(Ljava/lang/String;)V");
    //执行静态方法
    env->CallStaticVoidMethod(jclazz, jmethodId, env->NewStringUTF("hello world"));
};
```

