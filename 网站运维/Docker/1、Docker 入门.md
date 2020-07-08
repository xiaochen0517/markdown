# Docker 入门

## 1、 `Docker` 概述

### 1.1、什么是 `Docker` 

Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的镜像中，然后发布到任何流行的 Linux或Windows机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口

![image-20200706151038887](photo\1、Docker图标（1）.jpg).

### 1.2、相关地址

[官网](https://www.docker.com/)

[文档](https://docs.docker.com/)

[仓库](https://hub.docker.com/)

### 1.3、 `Docker` 基本组成

![](https://docs.docker.com/engine/images/architecture.svg)

**镜像**：An *image* is a read-only template with instructions for creating a Docker container.

**容器**：A container is a runnable instance of an image. You can create, start, stop, move, or delete a container using the Docker API or CLI. You can connect a container to one or more networks, attach storage to it, or even create a new image based on its current state.

**仓库**：Docker Hub is the world’s largest repository of container images with an array of content sources including container community developers, open source projects and independent software vendors (ISV) building and distributing their code in containers.

### 1.4、 `Docker` 与 `VM` 的区别

<img src="https://docs.docker.com/images/Container%402x.png" style="zoom:30%;" />



<img src="https://docs.docker.com/images/VM%402x.png" style="zoom:30%;" />

## 2、安装配置

### 2.1、安装 `Docker` 

#### 2.1.1、卸载旧版本

```shell
yum remove docker \
docker-client \
docker-client-latest \
docker-common \
docker-latest \
docker-latest-logrotate \
docker-logrotate \
docker-engine
```

#### 2.1.2、安装前置环境

```shell
yum install -y yum-utils
```

#### 2.1.3、设置镜像仓库

```shell
yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo
```

#### 2.1.4、安装 `Docker` 

```shell
# 创建yum缓存
yum makecache fast
# 安装 Docker
yum install docker-ce docker-ce-cli containerd.io
```

> ce：社区版
>
> ee：商业版

#### 2.1.5、验证安装

```shell
# 启动docker服务
systemctl start docker
# 查看docker版本
docker version
```

```shell
Client: Docker Engine - Community
 Version:           19.03.12
 API version:       1.40
 Go version:        go1.13.10
 Git commit:        48a66213fe
 Built:             Mon Jun 22 15:46:54 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.12
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.13.10
  Git commit:       48a66213fe
  Built:            Mon Jun 22 15:45:28 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.13
  GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
 runc:
  Version:          1.0.0-rc10
  GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```

#### 2.1.6、使用阿里源

地址：https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors（需登录）

### 2.2、运行镜像

#### 2.2.1、运行测试镜像

```shell
docker run hello-word
```

```shell
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
0e03bdcc26d7: Pull complete 
Digest: sha256:d58e752213a51785838f9eed2b7a498ffa1cb3aa7f946dda11af39286c3db9a9
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

> 在本地仓库中找不到指定镜像，则会从远程镜像仓库中下载

#### 2.2.2、查看现有镜像

```shell
docker images
```

```shell
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              bf756fb1ae65        6 months ago        13.3kB
```

#### 2.2.3、卸载 `Docker` 

```shell
yum remove docker-ce docker-ce-cli containerd.io
rm -rf /var/lib/docker
```

