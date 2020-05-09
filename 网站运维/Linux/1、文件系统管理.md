[TOC]

# Linux运维——文件系统管理

## 一、硬盘结构

### 1、硬盘的逻辑结构

![](E:\PerFile\notes\markdown\Linux\photo\硬盘示意图.png)

每个扇区的大小是固定的，为`512Byte`。扇区也是磁盘的最小存储单位

硬盘的大小是使用“磁头数\*柱面\*扇区数\*每个扇区的大小”计算的，其中磁头数（Heads）表示硬盘总共有几个磁头，也可以理解成为硬盘有几个盘面，然后乘以二；柱面数（Cylinders）表示硬盘每一面盘片有几条磁道；扇区数（Sectors）表示每条磁道上有几个扇区；每个扇区的大小一般是`512Byte`

### 2、硬盘接口

- `IDE`硬盘接口（Integrated Drive Electronics，并口，即电子集成驱动器）也称作“`ATA`硬盘”或“`PATA`硬盘”，是早期机械硬盘的主要接口，`ATA133`硬盘的理论速度可以达到`133MB/s`（此速度为理论平均值），`IDE`硬盘接口

- `SATA`接口（`Serial ATA`，串口）是速度更高的硬盘标准，具备了更高的传输速度，并具备了更强的纠错能力。目前已经是`SATA`三代，理论传输速度达到了`600MB/s`（此速度为理论平均值）
- SCSI接口（Small Computer System Interface，小型计算机系统接口）广泛应用在服务器中，具有应用范围广、多任务、带宽大、CPU占用率低及支持热插拔等优点，理论传输速度达到了`320MB/s`

## 二、文件系统

### 1、Linux文件系统的特性

- super block（超级块）：记录整个文件的信息，包括block与inode的总量，已经使用的inode和block的数量，未使用的inode和block的数量，block与inode的大小，文件系统的挂载时间，最近一次写入的时间，最近一次的磁盘检验时间等。
- data block（数据块，也称作block）：用来实际保存数据，block的大小（1KB、2KB或4KB）和数量在格式化后就已经决定，不能改变，除非重新格式化。每个block只能保存一个文件的数据，要是文件数据大于一个block块，则占用多个block块。Windows中磁盘碎片整理工具的原理就是把一个文件占用的多个block块尽量整理到一起，这样可以加快读写速度。
- inode（i节点）：用来记录文件的权限（r、w、x），文件的所有者和所属组，文件的大小，文件的状态改变时间（ctime），文件的最近一次读取时间（atime），文件的最近一次修改时间（mtime），文件的数据真正保存的block编号每个文件需要占用一个inode。

### 2、Linux常见文件系统

- `ext`：linux中最早的文件系统，由于在性能和兼容性上具有很多缺陷，现在已经很少使用
- `ext2`：是ext文件系统的升级版本，Red Hat Linux 7.2版本以前的系统默认都是ext2文件系统。于1993年发布，支持最大16TB的分区和最大2TB的文件
- `ext3`：是ext2文件系统的升级版本，最大的区别就是带日志功能，以便在系统突然停止时提高文件系统的可靠性。支持最大16TB的分区和最大2TB的文件
- `ext4`：是ext3文件系统的升级版。ext4在性能、伸缩性和可靠性方面进行了大量改进。ext4新增的向下兼容ext3、最大1EB文件系统和16TB文件、无限数量子目录、Extents连续数据块概念、多块分配、延迟分配、持久预分配、快速FSCK、日志校验、无日志模式、在线碎片整理、inode增强、默认启用barrier等。
- `xfs`：XFS最早针对IRIX操作系统开发，是一个高性能的日志型文件系统，能够在断电以及操作系统奔溃的情况下保证文件系统数据的一致性。它是一个64位的文件系统，后台进行开源并且移植到了linux系统中，目前`CentOS7.x`将XFS+LVM作为默认的文件系统。

## 三、常用的硬盘管理命令

### 1、df命令

```
df -ahT
-a	显示特殊文件系统，这些文件系统几乎都是保存在内存中。
-h	单位不再只用KB，而是换算成习惯单位
-T	多出了文件系统类型一列
```

### 2、du命令

```
du [选项] [目录或文件名]
-a	显示每个子文件的磁盘占用量。默认只统计子目录的磁盘占用量
-h	使用习惯单位显示磁盘占用量，如KB，MB或GB
-s	统计总占用量，而不列出子目录和子文件的占用量
```

- `du`与`df`的区别：`du`是用于统计文件大小的，统计的文件大小是准确的；df是用于统计空间大小的，统计的剩余空间是准确的。
- `lsof|grep deleted`：查看被删除的文件，然后手动kill也是可以的

### 3、fsck文件系统修复命令

```
fsck -y /dev/sdb1
# 自动修复
```

### 4、显示磁盘状态dump2fs

```
[root@iZbp152a9hwil1iwfx1gc7Z ~]# dumpe2fs -h /dev/vda1
dumpe2fs 1.42.9 (28-Dec-2013)
Filesystem volume name:   <none>
Last mounted on:          /
Filesystem UUID:          b98386f1-e6a8-44e3-9ce1-a50e59d9a170
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery extent flex_bg sparse_super large_file huge_file uninit_bg dir_nlink extra_isize
Filesystem flags:         signed_directory_hash 
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              1310720
Block count:              5242624
Reserved block count:     262131
Free blocks:              4033665
Free inodes:              1182776
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      1022
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:       Thu Nov 29 11:34:09 2018
Last mount time:          Wed Feb 12 16:54:34 2020
Last write time:          Thu Feb 13 00:54:31 2020
Mount count:              22
Maximum mount count:      -1
Last checked:             Thu Nov 29 11:34:09 2018
Check interval:           0 (<none>)
Lifetime writes:          78 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
First orphan inode:       1192671
Default directory hash:   half_md4
Directory Hash Seed:      64c050c5-05fb-4ed0-9f92-f5abefc12cc4
Journal backup:           inode blocks
Journal features:         journal_incompat_revoke
Journal size:             128M
Journal length:           32768
Journal sequence:         0x001e0fae
Journal start:            1
```

### 5、查看文件的详细时间

```
stat 文件名
```

### 6、判断文件类型

```
file 文件名	# 判断文件类型
type 命令名	# 判断命令类型
```



## 四、fdisk命令手工分区

### 1、查看系统所有硬盘及分区

```
fdisk -l
```

### 2、开始磁盘分区

```
fdisk /dev/sdb	进行磁盘分区（分区还没有分区号）
```

- 命令帮助

| 命令 | 描述                                                      |
| ---- | --------------------------------------------------------- |
| a    | 设置可引导标记                                            |
| b    | 编辑bsd磁盘标签                                           |
| c    | 设置dos操作系统兼容标记                                   |
| d    | 删除一个分区                                              |
| l    | 显示已知的文件系统类型。82为Linux swap分区，83为Linux分区 |
| m    | 显示帮助菜单                                              |
| n    | 新建分区                                                  |
| o    | 建立空白dos分区表                                         |
| p    | 显示分区列表                                              |
| q    | 不保存退出                                                |
| s    | 新建空白sun磁盘标签                                       |
| t    | 改变一个分区的系统id                                      |
| u    | 改变显示记录单位                                          |
| v    | 验证分区表                                                |
| w    | 保存退出                                                  |
| x    | 附加功能                                                  |

- 有时会因为系统的分区表正忙，则会报错需要重新启动系统之后才能使新的分区表生效

### 3、格式化建立文件系统

```
mkfs -t ext4 /dev/sdb1
```

- mkfs命令非常简单易用，但是不可以调整分区的默认参数的。

```
mke3fs [选项] [分区设备文件名]
-t	指定格式化的文件系统
-b	指定block块的大小
-i	指定“字节/inode”的比例，也就是多少个字节分配一个inode
-j	建立带有ext3日志功能的文件系统
-L	给文件系统设置卷标名
```



### 4、挂载分区

```
mkdir 文件夹  # 创建文件夹
mount [目标分区文件] [需要挂载到的文件夹]  # 挂载分区
mount	# 查看所有已经挂载的分区和光盘
```

### 5、自动挂载

- 打开`/etc/fstab`
  - 第一列：设备文件名（建议使用UUID）
  - 第二列：挂载点
  - 第三列：文件系统
  - 第四列：挂载选项
    - 是否可以被备份：0不备份、1每天备份、2不定期备份
    - 是否检测磁盘fsck ：0不检测、1启动时检测、2启动后检测

- 查看分区的uuid

```
dumpe2fs [分区文件路径] | grep UUID
ls -l /dev/disk/by-uuid/
```

- 挂载错误修复
  - 报错后输入root用户密码进入系统
  - 使用`mount -o remount,rw /`命令重新挂载根目录
  - 打开`/etc/fstab`修改错误位置
  - 重新启动

## 五、parted命令分区

Linux系统中有两种常见的分区表MBR分区表（主引导记录分区表）和GPT分区表（GUID分区表），其中：

- MBR分区表：支持的最大分区为2TB；最多支持4个主分区，或3个主分区1个扩展分区
- GPT分区表：支持最大`18EB`的分区（`1EB=1024PB=1024*1024TB`）

### 1、parted交互模式

```
parted [需要分区的磁盘文件路径]
```

| 交互命令                               | 描述                                     |
| -------------------------------------- | ---------------------------------------- |
| `help [COMMAND]`                       | 显示所有的命令帮助                       |
| `mklabel, mktable LABEL-TYPE`          | 创建新的磁盘卷标（分区表）               |
| `mkpart PART-TYPE [FS-TYPE] START END` | 创建一个分区                             |
| `name NUMBER NAME`                     | 给分区命名                               |
| `print [devices|free|list,all|NUMBER]` | 显示分区表，活动设备，空闲空间，所有分区 |
| `quit`                                 | 退出                                     |
| `rescue START END`                     | 修复丢失的分区                           |
| `rm NUMBER`                            | 删除分区                                 |
| `select DEVICE`                        | 选择需要编辑的设备                       |
| `set NUMBER FLAG STATE`                | 改变分区标记                             |
| `toggle [NUMBER [FLAG]]`               | 切换分区表的状态                         |
| `unit UNIT`                            | 设置默认的单位                           |
| `version`                              | 显示版本                                 |

### 2、切换分区表

```
mklabel gpt
```

### 3、建立分区

```
mkpart
```

### 4、格式化挂载分区

- 使用bash中的mkfs命令将分区格式化为ext4文件系统

```
mkfs -t ext4 /dev/sdb1
```

- 挂载分区

```
mount /dev/sdb1 /disk1
```

## 六、分配swap分区

### 1、分区，修改为swap分区ID

- 查看swap分区信息

```
free -h
```

- 分区

```
fdisk /dev/sdb  # 新建分区并使用t命令修改分区格式为swap分区
```

### 2、格式化分区

```
mkswap /dev/sdb1
```

### 3、使用swap分区

```
swapon 分区设备文件名
```

- swap分区开机自动挂载

```
/dev/sdb1  swap  swap  defaults  0 0
```



















