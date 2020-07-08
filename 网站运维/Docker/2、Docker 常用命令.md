# Docker 常用命令

## 1、帮助命令

```shell
docker version # 显示版本信息
docker info # 显示docker系统信息，包括镜像和容器的数量
docker [command] --help # 显示命令帮助
```

## 2、镜像命令

- `docker images` ：查看本机上的镜像
- `docker search [keyword]` ：在 `docker hub` 中搜索镜像
- `docker pull [image name]` ：从 `docker hub` 上下载镜像
- `docker rmi -f [image id]` ：删除指定镜像

## 3、容器命令

### 3.1、启动容器

```shell
docker run [parameter] [image name] 启动容器
exit 从容器中退出
```

参数说明

```shell
--naem="[name]" 设置容器名
-d 后台运行
-it 使用交互方式运行，进入容器查看内容
-p 指定容器的端口
	-p [主机端口:容器端口] 将主机端口容器端口映射
	-p [容器端口] 
-P 随机指定端口
```

eg

```shell
docker pull centos
docker run -it centos /bin/bash
ls
exit
```

### 3.2、退出容器

```shell
exit # 关闭并退出容器
ctrl+p+q # 容器不停止退出
```

### 3.3、删除容器

```shell
docker rm [container id]
docker rm -f $(docker ps -aq) # 删除所有容器
```

### 3.4、启动停止容器

```shell
docker start [container id] # 启动
docker restart [container id] # 重启
docker stop [container id] # 停止
docker kill [container id] # 强制关闭
```



