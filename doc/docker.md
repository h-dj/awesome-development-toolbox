## docker 环境安装

以下只考虑在Linux下安装



### 一、安装docker

#### 1.1 先卸载旧版本

```
sudo apt-get remove docker docker-engine docker.io containerd runc

#如果想完全卸载docker，执行以下命令
sudo apt-get purge docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker
```



#### 1.2 使用apt包管理安装docker

```
#更新包索引
sudo apt-get update

#添加docker仓库，允许apt通过https协议访问
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    
#添加docker官方的GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#验证 是否拥有指纹：9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
sudo apt-key fingerprint 0EBFCD88

#添加docker软件源
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
#国内
echo -e "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian stretch stable" >> /etc/apt/sources.list

#安装
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

- 使用一键安装脚本

  ```
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh --mirror Aliyun
  ```

#### 1.3 使用安装包安装

- 从 https://download.docker.com/linux/ubuntu/dists/ 中下载对应的Docker安装包
- 执行安装 `sudo dpkg -i /path/to/package.deb`



### 二、docker 配置

#### 2.1 配置开机启动

```
sudo systemctl enable docker
sudo systemctl start docker
```

#### 2.2 创建docker 用户组，并加入当前用户

```
#查看用户组
groups
#创建用户组
sudo groupadd docker
#将当前用户添加到docker 用户组
sudo usermod -aG docker $USER
#重启
reboot

#验证，不需要添加sudo 
docker run hello-world
```

#### 2.3 配置加速

```
#添加文件/etc/docker/daemon.json
{
    "registry-mirrors": [
        "https://dockerhub.azk8s.cn",
        "https://docker.mirrors.ustc.edu.cn",
        "https://registry.docker-cn.com",
        "https://reg-mirror.qiniu.com",
        "https://hub-mirror.c.163.com",
        "https://hub.daocloud.io"
    ]
}      
```

- 获取阿里docker镜像加速器 https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors

#### 2.4 重启

```
sudo systemctl daemon-reload 
sudo systemctl restart docker
```



### 三、docker简单命令了解

- 容器操作命令

  ```
  #查看容器列表
  docker container ls 
  #查看所有
  docker container ls -a
  
  #启动容器
  docker container start [container_id]
  
  #停止容器
  docker container stop [container_id]
  
  # 重启容器
  docker container restart [container_id]
  
  #删除全部停止的容器
  docker container prune
  
  #删除指定容器
  docker container rm [container_id]
  
  #查看指定容器的日志
  docker container logs  [container_id]
  
  #运行容器(-d 后台运行)docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
  docker run hello-world
  
  #进入容器docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
  docker exec -it container bash
  
  #批量获取容器id
  docker container ls -a -q
  #批量获取镜像id
  docker image ls -a -q
  
  #批量删除容器
  docker rm -f $(docker container ls -a -q)
  docker rm -f $(docker image ls -a -q)
  
  //删除指定名称
  docker rm -f $(docker ps -a | grep "zhy*" | awk '{print $1}')
  ```

- docker  run 命令

  ```
  --name  指定容器名
  -v 挂载数据卷
  -p 映射端口号
  -d  后台启动
  --restart=always 开机启动
  --privileged=true 权限
  -e 常量
  
  #启动mysql
  docker run --name mysql-serve \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e TZ=Asia/Shanghai -d -i -p 3306:3306 \
  -v $PWD/mysql/data:/var/lib/mysql \
  --restart=always  mysql
  ```

- docker exec 进入容器终端

  ```
  # 终端支持中文
  env LANG=C.UTF-8　
  
  docker exec -it mysql-serve  env LANG=C.UTF-8 bash
  ```

- Dockerfile 文件了解

  - https://yeasy.gitbook.io/docker_practice/image/dockerfile

### 四、安装docker-compose

#### 4.1 安装

```shell
#下载
sudo curl -L https://github.com/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
#授予执行权限
sudo chmod +x /usr/local/bin/docker-compose
#验证安装
docker-compose --version


# pip 安装
sudo apt-get install -y python3 python3-pip
sudo pip3 install docker-compose
# 如果提示找不到ffi.h文件，先安装以下依赖
sudo apt-get install libffi-dev 

```

#### 4.2 docker-compose.yaml 文件了解

- https://yeasy.gitbook.io/docker_practice/compose/compose_file

#### 4.3 docker-compose 命令

- https://yeasy.gitbook.io/docker_practice/compose/commands



#### 参考

- https://docs.docker.com/compose/gettingstarted/
- https://docs.docker.com/engine/install/
- https://docs.docker.com/engine/install/linux-postinstall/
- https://yeasy.gitbook.io/docker_practice/compose/install

