[TOC]

# Android Studio3.5JNI配置及使用

## 一、下载安装NDK以及CMake

### 1.1进入`SDK Manager`

- 主页右上角

![](photo\Android Studio3.5JNI配置及使用\101.sdkmanager主页进入.png)

- `File`->`Settings`->`Appearance & Behavior`->`System Settings`->`Android SDK`

### 1.2开始下载

- 选中上方`SDK Tools`和下方的`Show Package Details`多选框
- 选中需要下载的`NDK`版本以及`CMake`版本，点击右下角`Apply`即可

![](photo\Android Studio3.5JNI配置及使用\102.sdkmanager主页.png)

> 安装目录会在上方sdk目录中的ndk目录中

## 二、新建项目

### 1.1新建`Native C++`项目

![](photo\Android Studio3.5JNI配置及使用\001.新建项目1.png)

### 1.2修改项目信息

![](photo\Android Studio3.5JNI配置及使用\002.新建项目2.png)

### 1.3选择C++版本

- 无特殊要求直接默认即可

![](photo\Android Studio3.5JNI配置及使用\003.新建项目3.png)

### 1.4创建完成

- `cpp`目录即为`c++`代码目录

![](photo\Android Studio3.5JNI配置及使用\004.新建完成项目目录结构.png).

## 二、配置CMake

### 2.1`CMakeLists.txt`主配置文件

- 打开`app`目录下的`build.gradle`文件
- `path`：主配置文件相对路径
- `version`：版本号

```java
externalNativeBuild {
    cmake {
        path "src/main/cpp/CMakeLists.txt"
        version "3.10.2"
    }
}
```

### 2.2`CMakeLists.txt`详解

#### 2.2.1文件解析

```properties
# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.
# 声明CMake版本
cmake_minimum_required(VERSION 3.4.1)

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.

# 创建和命名库，将其设置为静态或共享，并提供到其源代码的相对路径。
# 您可以定义多个库，然后CMake为您构建它们。Gradle自动将共享库打包到你的APK中。

# 添加cpp文件到库中
add_library( # Sets the name of the library.
        native-lib

        # Sets the library as a shared library.
        SHARED

        # Provides a relative path to your source file(s).
        native-lib.cpp)

# Searches for a specified prebuilt library and stores the path as a
# variable. Because CMake includes system libraries in the search path by
# default, you only need to specify the name of the public NDK library
# you want to add. CMake verifies that the library exists before
# completing its build.

# 将log库储存为一个名为log-lib的变量
find_library( # Sets the name of the path variable.
        log-lib

        # Specifies the name of the NDK library that
        # you want CMake to locate.
        log)

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

# 在上方定义好的native-lib库中引入log库
target_link_libraries( # Specifies the target library.
        native-lib

        # Links the target library to the log library
        # included in the NDK.
        ${log-lib})
```

#### 2.2.2添加多个`.cpp`文件

```properties
add_library(
        native-lib
        SHARED
        native-lib.cpp
        one-lib.cpp
        two-lib.cpp)
```

#### 2.2.3生成多个`.so`库

- 在cpp目录下新建文件夹，并在新建的文件夹下新建`CMakeLists.txt`文件

![](photo\Android Studio3.5JNI配置及使用\201.生成多个so库目录新建1.png).

- 新建`.cpp`文件

![](E:\PerFile\notes\markdown\Blog\photo\Android Studio3.5JNI配置及使用\201.生成多个so库目录新建2.png)

- `one`目录下`CMakeLists.txt`文件内容

```pro
add_library(one-lib SHARED one-lib.cpp)
target_link_libraries(one-lib log)
```

- `two`目录下`CMakeLists.txt`文件内容

```pro
add_library(two-lib SHARED two-lib.cpp)
target_link_libraries(two-lib log)
```

- 在主配置文件下添加

```properties
add_subdirectory(one)
add_subdirectory(two)
```

> 参数传入的是指定包含`CMakeLists`文件的目录的相对路径

- 点击`Build`->`Make Project`
  - 打开`app`->`build`->`intermediates`->`cmake`->`debug`->`obj`中的任意文件夹

![](photo\Android Studio3.5JNI配置及使用\203.build后生成多个so库目录.png).

### 2.3详细配置参阅官方文档

[Google Docs](https://developer.android.google.cn/studio/projects/add-native-code)

[CMake](https://cmake.org/cmake/help/latest/manual/cmake-commands.7.html)