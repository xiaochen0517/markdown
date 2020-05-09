[TOC]

# Android Studio安装及配置大全

## 前言

- 此教程十分新手，有经验的同志可以自行选择跳过一些内容
- 技术有限，若发现错误，请与我联系
- 在操作过程中若发现问题，可与我联系QQ：2827075398

## 一、下载

### 1.1使用百度搜索`android studio`

- [点此直接进入官网](https://developer.android.google.cn/studio/)

![](photo\Android Studio安装及配置大全\001.百度搜索AndroidStudio.png)

> 注意网址

### 1.2点击`DOWNLOAD ANDROID STUDIO`

![](photo\Android Studio安装及配置大全\002.AndroidStudio官网.png)

### 2.2同意许可协议

![](photo\Android Studio安装及配置大全\003.AndroidStudio下载许可协议.png)

## 二、安装

### 2.1开始安装

- 直接`Next>`

![](photo\Android Studio安装及配置大全\004.安装1.png)

### 2.2选择安装路径

- C盘为默认安装路径，C盘空间不足可以修改到D盘
- 默认`Next>`

![](photo\Android Studio安装及配置大全\005.安装2.png)

### 2.3完成安装

- 选中`Start Android Studio`为点击`Finish`后自动打开，反之则需要手动打开

![](photo\Android Studio安装及配置大全\006.安装3.png)

> 注：在默认情况下`Android Studio`是不会创建桌面图标的，可以在开始菜单中找到`Android Studio`右键单击->更多->打开文件位置，在打开的文件浏览器中右键单击`Android Studio`选择发送到->桌面快捷方式即可。

## 三、初始配置

### 3.1首次启动

#### 3.1.1导入设置

- 选中`Do not import settings`点击`OK`即可

![](photo\Android Studio安装及配置大全\007.首次启动导入设置.png).

- 点击后稍作等待

![](photo\Android Studio安装及配置大全\008.启动图.png).

#### 3.2无法找到`Android SDK`

- 此提示的内容为无法找到`Android SDK`
- 直接点击`Cancel`取消，将会在之后手动下载

![](photo\Android Studio安装及配置大全\009首次启动无法找到sdk.png).

#### 3.3进入首次运行引导程序

- 点击`Next`

![](photo\Android Studio安装及配置大全\010.首次启动引导程序.png)

#### 3.4自定义安装

- 点击自定义->`Next`

![](photo\Android Studio安装及配置大全\011.自定义安装引导.png)

#### 3.5主题设置

- `Android Studio`有两种主题`Darcula`（暗色）和`Light`（亮色），可自行选择

![](photo\Android Studio安装及配置大全\012.主题设置.png)

#### 3.6安装SDK

- 除去默认选中的SDK选项外，`Performance`为硬件加速，`Android Virtual Device`即`avd`（安卓模拟器）此项暂时不选，后续会进行下载。

![](photo\Android Studio安装及配置大全\013.SDK安装设置.png)

#### 3.7安卓模拟器内存大小设置

- 此项可直接使用默认大小`Use recommended`，内存大于8G推荐设置2G，内存小于8G推荐设置1G。

![](photo\Android Studio安装及配置大全\014.AVD虚拟内存设置.png)

#### 3.8下载开始前检查

- 按步骤操作可直接略过

![](photo\Android Studio安装及配置大全\015.开始安装前检查.png)

#### 3.9SDK安装完成

![](photo\Android Studio安装及配置大全\016.SDK安装完成.png)

#### 3.10开始菜单

- 至此，首次运行的所有设置均已完成。

![](photo\Android Studio安装及配置大全\017.开始菜单.png)

### 3.2新建项目

#### 3.2.1`Start a new Android Studio project`

- 选中`Empty Activity`->`Next`

![](photo\Android Studio安装及配置大全\018.创建项目1.png)

#### 3.2.2修改项目属性

- 项目名，可自行修改
- 包名，本质为目录，目录名之间用`.`分隔
- 项目所在路径，可自行修改
- 使用语言，修改为`java`
- 其余默认点击`Next`

![](photo\Android Studio安装及配置大全\019.创建项目2.png)

### 3.3下载配置`AVD`（安卓模拟器）

- 开始菜单中：`Configure`->`AVD Manager`
- 项目中：窗口右上角

![](photo\Android Studio安装及配置大全\028.项目中打开avd.png).

#### 3.3.1开始创建

![](photo\Android Studio安装及配置大全\020.创建avd1.png)

#### 3.3.2选择屏幕大小

- 若没有特殊需求可以直接跳过

![](photo\Android Studio安装及配置大全\021.创建avd2.png)

#### 3.3.3选择安卓版本

- 注意观察列表中的`Target`列，为安卓版本号，右侧显示的信息显示不准确（估计是有BUG），
- 点击对应的`Download`下载

![](photo\Android Studio安装及配置大全\022.选择安卓版本下载.png)

- 同意许可协议

![](photo\Android Studio安装及配置大全\023.同意许可协议.png)

- 下载完成点击`Finish`后对应版本`Download`即会消失
- 选中指定版本，点击`Next`

![](photo\Android Studio安装及配置大全\025.下载完成.png)

#### 3.3.4AVD配置

- 无特殊要求直接`Finish`

![](photo\Android Studio安装及配置大全\026.配置完成.png)

#### 3.3.5完成配置

![](photo\Android Studio安装及配置大全\027.avd下载完成.png)

### 3.4项目界面介绍

![](photo\Android Studio安装及配置大全\029.项目界面介绍.png)

## 四、个人配置

### 4.1设置编辑器字体大小

- 在开始菜单中点击`Configure`->`Settings`
- 在打开项目后左上角`File`->`Settings`

- `Settings`->`Editor`->`Font`->`Size`

![](photo\Android Studio安装及配置大全\401.调整编辑器字体大小.png)

### 4.2编辑快捷键（光标跳转到行末）

- 修改光标快速跳转到行末
- 打开：`File`->`Settings`->`Keymap`
- 在搜索框中搜索`end`
- 在`Move Caret to Line End`条目上右键，点击`Add Keyboard Shortcut`

![](photo\Android Studio安装及配置大全\402.修改快捷键.png)

- 建议设置为`Ctrl+;`

![](photo\Android Studio安装及配置大全\403.修改快捷键1.png).

### 4.3取消大小写敏感

- 打开`Settings`
- `Editor`->`General`->`Code Completion`
- 取消选中`Match case`即可

![](photo\Android Studio安装及配置大全\404.取消大小写敏感.png)

### 4.4修改`Gradle`缓存文件位置

博客地址：https://www.jianshu.com/p/b3351e3c10f3

### 4.5修改AVD下载路径

博客地址：https://blog.csdn.net/u010940300/article/details/43909509