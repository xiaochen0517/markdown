[TOC]

# Linux运维——服务管理

## 一、服务分类

### 1、RPM包安装的服务

#### 1.1独立的服务

这些服务是通过RPM包安装的，可以被服务管理命令识别。

- 查看

```
chkconfig --list
```

1. 启动管理
   1. 使用`/etc/init.d/`目录中的启动脚本启动服务
   
      1. ```
         /etc/init.d/[服务名] start
         ```
   
   1. 使用`service`命令启动服务
   
      1. ```
         service [服务名] start|stop|restart|...
         ```
   
2. 自启动管理

   1. 使用`chkconfig`服务自启动管理命令

      1. ```
         chkconfig [--level 运行级别] [服务名] [on|off]
         --level 设定在那个运行级别中开机自启动
         # 可以省略--level选项默认设置为2345
         ```

   2. 修改`/etc/rc.d/rc.local`设置服务自启动

      1. 将上方`/etc/init.d/`启动方式命令添加到此文件中即可实现开机启动

   3. 使用`ntsysv`命令实现命令行图形化方式开启

#### 1.2基于xinetd的服务（了解即可）

> 此服务在新版本中默认不安装，需要手动安装

```
yum -y install xinetd
chkconfig --list
```

1. 服务的启动

   1. 使用telnet服务来举例，telnet服务是用来进程系统远程管理的，端口是23。在telnet的远程管理中数据在网络中是明文传输，非常不安全。所以在生产服务器中是不建议启动telnet服务的。

   2. ```
      vim /etc/xinet.d/telnet
      
      将 disable=yes 修改为 disable=no
      # 重启xinetd服务
      service xinetd restart
      ```

2. 服务自启动

   1. 使用`chkconfig`命令管理自启动
		1. ```
         chkconfig [服务名] on|off
         ```

      2. 不可以添加运行级别号

   2. 使用`ntsysv`命令管理自启动

#### 1.3独立服务的启动脚本源码

```
vim /etc/init.d/httpd

#!/bin/bash
#
# httpd        Startup script for the Apache HTTP Server
#
# chkconfig: - 85 15
# description: The Apache HTTP Server is an efficient and extensible  \
#              server implementing the current HTTP standards.
# processname: httpd
# config: /etc/httpd/conf/httpd.conf
# config: /etc/sysconfig/httpd
# pidfile: /var/run/httpd/httpd.pid
#
### BEGIN INIT INFO
# Provides: httpd
# Required-Start: $local_fs $remote_fs $network $named
# Required-Stop: $local_fs $remote_fs $network
# Should-Start: distcache
# Short-Description: start and stop Apache HTTP Server
# Description: The Apache HTTP Server is an extensible server 
#  implementing the current HTTP standards.
### END INIT INFO

# Source function library.
. /etc/rc.d/init.d/functions
# Source function library.
. /etc/rc.d/init.d/functions

if [ -f /etc/sysconfig/httpd ]; then
        . /etc/sysconfig/httpd
fi

# Start httpd in the C locale by default.
HTTPD_LANG=${HTTPD_LANG-"C"}

# This will prevent initlog from swallowing up a pass-phrase prompt if
# mod_ssl needs a pass-phrase from the user.
INITLOG_ARGS=""

# Set HTTPD=/usr/sbin/httpd.worker in /etc/sysconfig/httpd to use a server
# with the thread-based "worker" MPM; BE WARNED that some modules may not
# work correctly with a thread-based MPM; notably PHP will refuse to start.

# Path to the apachectl script, server binary, and short-form for messages.
apachectl=/usr/sbin/apachectl
httpd=${HTTPD-/usr/sbin/httpd}
prog=httpd
pidfile=${PIDFILE-/var/run/httpd/httpd.pid}
lockfile=${LOCKFILE-/var/lock/subsys/httpd}
pidfile=${PIDFILE-/var/run/httpd/httpd.pid}
lockfile=${LOCKFILE-/var/lock/subsys/httpd}
RETVAL=0
STOP_TIMEOUT=${STOP_TIMEOUT-10}

# The semantics of these two functions differ from the way apachectl does
# things -- attempting to start while running is a failure, and shutdown
# when not running is also a failure.  So we just do it the way init scripts
# are expected to behave here.
start() {
        echo -n $"Starting $prog: "
        LANG=$HTTPD_LANG daemon --pidfile=${pidfile} $httpd $OPTIONS
        RETVAL=$?
        echo
        [ $RETVAL = 0 ] && touch ${lockfile}
        return $RETVAL
}

# When stopping httpd, a delay (of default 10 second) is required
# before SIGKILLing the httpd parent; this gives enough time for the
# httpd parent to SIGKILL any errant children.
stop() {
        status -p ${pidfile} $httpd > /dev/null
        if [[ $? = 0 ]]; then
      status -p ${pidfile} $httpd > /dev/null
        if [[ $? = 0 ]]; then
                echo -n $"Stopping $prog: "
                killproc -p ${pidfile} -d ${STOP_TIMEOUT} $httpd
        else
                echo -n $"Stopping $prog: "
                success
        fi
        RETVAL=$?
        echo
        [ $RETVAL = 0 ] && rm -f ${lockfile} ${pidfile}
}

reload() {
    echo -n $"Reloading $prog: "
    if ! LANG=$HTTPD_LANG $httpd $OPTIONS -t >&/dev/null; then
        RETVAL=6
        echo $"not reloading due to configuration syntax error"
        failure $"not reloading $httpd due to configuration syntax error"
    else
        # Force LSB behaviour from killproc
        LSB=1 killproc -p ${pidfile} $httpd -HUP
        RETVAL=$?
        if [ $RETVAL -eq 7 ]; then
             RETVAL=$?
        if [ $RETVAL -eq 7 ]; then
            failure $"httpd shutdown"
        fi
    fi
    echo
}

# See how we were called.
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  status)
        status -p ${pidfile} $httpd
        RETVAL=$?
        ;;
  restart)
        stop
        start
        ;;
        start
        ;;
  condrestart|try-restart)
        if status -p ${pidfile} $httpd >&/dev/null; then
                stop
                start
        fi
        ;;
  force-reload|reload)
        reload
        ;;
  graceful|help|configtest|fullstatus)
        $apachectl $@
        RETVAL=$?
        ;;
  *)
        echo $"Usage: $prog {start|stop|restart|condrestart|try-restart|force-reload|reload|status|fullstatus|graceful|help|configtest}"
        RETVAL=2
esac

exit $RETVAL
```

### 2、源码包安装的服务

#### 2.1启动管理

```
[安装路径]/bin/apachectl start|stop|restart|...
```

#### 2.2自启动管理

将启动命令添加到`/etc/rc.local`文件中

#### 2.3让源码包可以被服务管理命令识别

使用`service`命令控制源码包安装的服务

```
# 将安装目录的启动脚本软连接到init.d文件夹中
ln -s [apache安装目录]/bin/apachectl /etc/init.d/apache
# 使用服务管理命令
service apache restart
```

使源码包服务可以被`chkconfig`命令管理自启动

- 格式

```
# chkconfig: [运行级别] [启动顺序] [关闭顺序]
# discription: xxxx
```

- 实例

``` 
vim /etc/init.d/apache

#!/bin/sh
#
# chkconfig: 35 86 76
#
# discription: source package apache
```

- 将服务加入`chkconfig`中

```
chkconfig --add [服务名]
```

> `chkconfig`配置完成后`ntsysv`也可以使用

## 二、Linux中常见服务的作用

| 服务名称     | 功能                                                         | 建议 |
| ------------ | ------------------------------------------------------------ | ---- |
| acpid        | 电源管理接口。笔记本建议开启，可以监听内核层的相关电源事件   | 开启 |
| anacron      | 系统的定时任务程序。cron的一个子系统，如果定时任务错过了执行事件，可以通过anacron继续唤醒执行 | 关闭 |
| alsasound    | Alsa声卡启动。如果使用alsa声卡则开启                         | 关闭 |
| apmd         | 电源管理模块。如果支持acpid，就不需要apmd，可以关闭          | 关闭 |
| atd          | 指定系统在特点事件执行某个任务，只能执行一次。如果需要则开启，但我们一般使用crond来进行循环定时任务 | 关闭 |
| auitd        | 审核子系统，如果开启了此服务，SELinux的审核信息会写入 /var/log/audit/audit.log 文件，如果不开启，审核信息会记录在syslog中 | 开启 |
| autofs       | 让服务器可以自动挂载网络中的其他服务器的共享数据，一般用来自动挂载 NFS 服务。 | 关闭 |
| avahi-daemon | Avahi 是 zeroconf 协议的实现。它可以在没有 DNS 服务的局域网中发现基于 zeroconf 协议的设备和服务。 | 关闭 |

















