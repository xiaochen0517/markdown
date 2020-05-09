[TOC]

# Git概述及基础操作

# 一、Git基础

## 1.1Git介绍

- GIt是目前世界上最先进的分布式**版本控制系统**

## 1.2Git与Github

### 1.2.1两者区别

Git是一个分布式版本控制系统，简单地说它就是一个软件，用于记录一个或者若干文件内容变化，以便将来查阅特定版本修订情况的软件

Github（https://www.github.com）是一个为用户提供Git服务的网站，简单说就是一个可以存放代码的网盘。Github除了管理Git的web界面外，还提供了订阅、关注、讨论组、在线编辑器等丰富的功能。

## 二、Git使用

### 2.1本地仓库

#### 2.1.1工作流程

![](photo\git流程图.png).

#### 2.1.2本地仓库操作

- 首次安装进行全局配置
- 右键打开`Git Bash Here`

```python
git config --global user.name "用户名"
git config --global user.email "邮箱地址"
```

- 初始化仓库
- 进入指定目录

```
git init
```

- Git常见指令操作

```python
查看当前状态：git status
添加到缓存区：git add 文件名
添加所有文件到缓存区：git add --all
提交至版本库：git commit -m"注释内容"
```

#### 2.1.3版本回退

- 查看版本

````python
git log  # 显示所有log
git log --pretty=oneline  # 使用一行显示一条log
````

- 回退操作

```
git reset --hard 提交版本号
```

- 查看历史操作

```
git reflog
```

- 取消回退操作

````
git reset --hard 回退指定位置id号
````

### 2.2远程仓库

#### 2.2.1基于HTTPS协议

- 克隆远程仓库到本地

```
git clone 远程仓库地址
```

- 将本地仓库的修改同步到远程仓库

```python
git push  # 此命令会提示输入Github远程仓库的用户名密码
```

- 配置提交时的用户名密码（不用在每次提交时输入）

  - 打开仓库文件夹下的`.git`文件夹下的`config`文件

  - 修改`[remote "origin"]`下的`url`的内容，在`github.com`前添加用户名和密码

  - ```python
    [remote "origin"]
    	url = https://用户名:密码@github.com/xiaochen0517/test2.git
    	fetch = +refs/heads/*:refs/remotes/origin/*
    ```

- 拉取线上仓库

```python
git pull
```

#### 2.2.2基于SSH协议

- 生成公私钥对指令（需自行安装OpenSSH）

```python
ssh-keygen -t rsa -C "注册邮箱"
```

- 将公钥上传到Github
  - 生成位置`C:\Users\用户名\.ssh\id_rsa.pub`

- 将项目拉取后，提交时无需添加用户名密码

### 2.3分支管理

![](photo\git分支示意图.png)

#### 2.3.1分支相关指令

```
查看分支：git branch
创建分支：git branch 分支名
切换分支：git checkout 分支名
创建并切换分支：git checkout -b 分支名
删除分支：git branch -d 分支名
合并分支：git merge 被合并的分支名

关联远程分支：git push --set-upstream origin 分支名
```

### 2.4忽略文件

- 在需要忽略文件的目录新建一个名为`.gitignore`的文件
- 写法规则

```
/mtk/	过滤整个文件夹
*.zip	过滤所有.zip文件
/mtk/do.c	过滤某个具体文件
!index.html	不过滤某个具体文件
```

