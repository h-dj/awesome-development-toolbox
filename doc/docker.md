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
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# 官方源
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


   
#国内
$ echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# 官方源
# $ echo \
#   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


#安装
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

- 使用一键安装脚本

```
curl -fsSL get.docker.com -o get-docker.sh
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


sudo tee /etc/docker/daemon.json <<EOF
{
     "registry-mirrors": [
       "https://dockerproxy.net"
    ],
    "exec-opts": ["native.cgroupdriver=systemd"],
    "proxies": {
                "http-proxy": "http://192.168.8.3:7899",
                "https-proxy": "http://192.168.8.3:7899",
                "no-proxy": "*.test.example.com,.example.org,127.0.0.0/8,dockerproxy.net"
    }
}
EOF

sudo systemctl daemon-reload 
sudo systemctl restart docker
```

- 获取阿里docker镜像加速器 https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors


- 配置代理
```
sudo vim /etc/systemd/system/docker.service.d/proxy.conf
# Add content below
[Service]
Environment="HTTP_PROXY=http://192.168.43.47:7890/"
Environment="HTTPS_PROXY=http://192.168.43.47:7890/"
Environment="NO_PROXY=localhost,127.0.0.1,.example.com"
```


#### 2.4 重启

```
sudo systemctl daemon-reload && sudo systemctl restart docker
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
    --restart=always  # 表示容器退出时，docker会总是自动重启这个容器
    --restart=on-failure:3  # 表示容器的退出状态码非0(非正常退出)，自动重启容器，3是自动重启的次数。超过3此则不重启
    --restart=no  # 默认值，容器退出时，docker不自动重启容器
    --restart=unless-stopped  # 表示容器退出时总是重启，但是不考虑docker守护进程运行时就已经停止的容器

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

> 旧版

```shell
#下载
sudo curl  --proxy http://192.168.8.17:7899 -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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

> 新版
```shell
# 针对当前用户
# 对全部用户生效，/usr/local/lib/docker/cli-plugins
 mkdir -p ~/.docker/cli-plugins/
 curl -SL https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose


# 配置执行权限
chmod +x ~/.docker/cli-plugins/docker-compose

#测试
docker compose version

#新版使用命令变为 由 docker-compose docker compose

```

#### 4.2 docker-compose.yaml 文件了解

- https://yeasy.gitbook.io/docker_practice/compose/compose_file

#### 4.3 docker-compose 命令

- https://yeasy.gitbook.io/docker_practice/compose/commands

#### 参考

- https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
- https://docs.docker.com/compose/gettingstarted/
- https://docs.docker.com/engine/install/
- https://docs.docker.com/engine/install/linux-postinstall/
- https://docs.docker.com/compose/cli-command/#install-on-linux

