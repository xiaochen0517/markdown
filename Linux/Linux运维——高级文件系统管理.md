[TOC]

# Linux运维——高级文件系统管理

## 一、磁盘配额

### 1、磁盘配额的概念

- 控制用户或用户组使用磁盘空间以及文件个数的功能

### 2、磁盘配额条件

- 内核必须支持磁盘配额

```
grep CONFIG_QUOTA /boot/config-3.10.0-1062.12.1.el7.x86_64
```

- 系统中必须默认安装了quota工具，Linux默认是安装的

```
rpm -qa | grep quota
```

- 安装

```
yum install quota
```

要支持磁盘配额的分区必须开启磁盘配额功能，这个功能需要手动开启。

### 3、概念

1. 用户配额和组配额
2. 磁盘容量限制和文件个数限制
3. 软限制和硬限制
4. 宽限时间

如果用户的空间占用数处于软限制和硬限制之间，系统会在用户登录时警告用户磁盘将满，这个时间就是宽限时间，默认为7天。如果达到宽限时间，用户的磁盘占用量还超过软限制，那么软限制就会升级为硬限制。

### 4、磁盘配额示例

#### 4.1分区

- 将一个 5 GB 的分区挂载到/disk目录中

#### 4.2建立用户和用户组

```
groupadd test
useradd -G test user1
useradd -G test user2
useradd -G test user3
passwd user1
passwd user2
passwd user3
```

#### 4.3在分区中开启磁盘配额

```
mount -o remount,usrquota,grpquota /disk
# 重新挂载/disk分区，并加入用户和用户组的磁盘配额功能
```

- 永久生效需要修改`/etc/fstab`文件

```
[UUID号] [要挂载到的目录] [文件系统格式] defaults,usrquota,grpquota  0 0
```

#### 4.4建立磁盘配额文件

```
quotacheck [选项] [分区名]
-u, --user 检查用户文件
-g, --group 检查小组文件
-c, --create-files 创建新的配额文件
-b, --backup 创建旧配额文件的备份
-f, --force 强制检查，即使取消了配额
-i, --interactive 交互模式
-n, --use-first-dquot 使用第一个拷贝的复制结构
-v, --verbose 打印更多的信息
-d, --debug 打印更多信息
-m, --no-remount 不以只读方式重新安装文件系统
-M, --try-remonut 尝试以只读方式重新挂载文件系统，即使失败也要继续
-R, --exclude-root 检查所有文件系统时排除root用户
-F, --format=formatname 检查特定格式的配额文件
-a, --all 检查所有文件系统
-h, --help 帮助信息
-V, --version 版本信息
```

> 使用此功能需要关闭`selinux`

```
# 获取当前状态
getenforce
# 暂时关闭
setenforce 0
# 开启
setenforce 1
# 永久关闭需要修改/etc/selinux/config文件
SELINUX=disabled
```

- 建立磁盘配额文件

```
quotacheck -avu
```

#### 4.5设置用户配额限制

```
edquota [选项] [用户名或组名]
-u [用户名] 设定用户配额
-g [组名] 设定组配额
-t 设定宽限时间
-p 复制配额限制。如果已经设定好某个用户的配额限制，其他用户的配额限制如果和这个用户相同，那么可以直接复制配额限制，而不用都手工配置
```

- 设置`user1`的配额

```
edquota -u user1
```

```
Disk quotas for user user1 (uid 1000):
Filesystem    blocks     soft     hard    inodes    soft    hard
/dev/sdb1        0      40000    50000       0        8       10
```

#### 4.6启动和关闭配额

**启动配额：**

```
quotaon [选项] [分区名]
-a 依据/etc/mtab文件启动所有的配额分区。如果不加-a需要指定分区名
-u 启动用户配额
-g 启动组配额
-v 显示启动过程的信息
```

- 开启

```
quotaon -vu /disk/
```

**关闭配额：**

```
quotaoff [选项] [分区名]
命令选项与quotaon相同
```

- 关闭

```
quotaoff -vu /disk/
```

#### 4.7磁盘配额查询

- 使用`quota`查询用户或用户组的配额：

```
quota [选项] [用户名或组名]
-u [用户名] 查询用户的配额
-g [组名] 查询组的配额
-v 显示详细信息
-s 以习惯单位显示容量大小，如M，G
```

```
quota -uvs user1
```

- 使用`repquota`查询文件系统配额

```
repquota [选项] [分区名]
-a 依据/etc/mtab文件查询配额，不加-a选项时需要加分区名
-u 查询用户配额
-g 查询组配额
-v 显示详细信息
-s 以习惯单位显示容量大小
```

```
repquota -auvs
```

#### 4.8测试

```
dd if=/dev/zero of=/disk/test bs=1M count=60
```

```
sdb1: warning, user block quota exceeded.
sdb1: write failed, user block limit reached.
dd: 写入"/disk/testfile" 出错: 超出磁盘限额
记录了49+0 的读入
记录了48+0 的写出
51195904字节(51 MB)已复制，0.147113 秒，348 MB/秒
```

#### 4.9非交互设定用户磁盘配额

```
setquota -u 用户名 容量软限制 容量硬限制 个数软限制 个数硬限制 分区名
```

## 二、LVM 逻辑卷管理

### 1、简介

LVM 是 Logical Volume Manager 的简称，中文为逻辑卷管理

![](E:\PerFile\notes\markdown\Linux\photo\LVM逻辑卷管理器示意图.png)

————















