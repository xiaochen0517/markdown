# JNI中C++调用Java方法时获取jmethodID时需要传入的签名获取方法

- 在`Android Studio`中`build`项目
- 打开项目目录

![](photo\数据类型签名获取目录.png).

- 在此路径下打开`cmd`
- 执行命令：`javap -s 全限定类名`

![](photo\获取数据类型签名命令执行结果.png)

- 其中对应需要调用方法的`descriptor`后即是需要的签名