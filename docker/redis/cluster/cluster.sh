#!/bin/bash

BASE_DIR=$PWD
PORTS=`seq 7000 7005`

# Remove redis cluster
function remove_cluster() {
    if [ "$(docker ps -q -f name=redis-cluster-$ms-$port)" ]; then
      #stop
          echo "==========暂停 redis docker 容器============"
          docker container stop redis-cluster-$ms-$port
    fi
    if [ "$(docker ps -aq -f status=exited -f status=created -f status=dead -f name=redis-cluster-$ms-$port)" ]; then
          #cleanup
          echo "==========删除 redis docker 容器============"
          docker container rm redis-cluster-$ms-$port
    fi

    if [ -d "$BASE_DIR" ]; then
      echo -n "是否删除 redis 配置和数据 default n:(Y/n)"
      read remove_confirm

      if [ $remove_confirm = "N" ]; then
          rm -vrf $BASE_DIR/master $BASE_DIR/slave
        else
          echo "skip remove data in $BASE_DIR"
        fi
    fi

    if [   -n "$( docker network ls -q -f name=network-redis-cluster)" ]; then
        docker network rm network-redis-cluster
    fi
}


function prepare() {
    echo "========== 准备初始化 =================="
    echo -n "请输入安装路径 default $BASE_DIR:"
    read install_dir
    if [ -d "$install_dir" ]; then
        $BASE_DIR = $install_dir
      else
         echo -n "输入安装路径不存在，采用默认 $BASE_DIR"
    fi
    #master 和 slave 文件夹
    for port in $PORTS; do
    	ms="master"
    	if [ $port -ge 7003 ]; then
    		ms="slave"
    	fi
    	mkdir -p $BASE_DIR/$ms/$port/conf \
      	&& mkdir -vp $BASE_DIR/$ms/$port/data \
    		&& PORT=$port envsubst < ./redis.cluster.template > $BASE_DIR/$ms/$port/conf/redis.conf;
    done
}

function start() {
    #创建网络
    if [  ! -n "$( docker network ls -q -f name=network-redis-cluster)" ]; then
        docker network create network-redis-cluster
    fi
    echo "========== 启动实例 =================="
    for port in $PORTS; do
    	ms="master"
    	if [ $port -ge 7003 ]; then
    		ms="slave"
    	fi
      # run your container
      docker run -d -p $port:$port -p 1$port:1$port \
        -v $BASE_DIR/$ms/$port/conf:/conf \
        -v $BASE_DIR/$ms/$port/data:/data \
        --privileged=true --restart always \
        --name redis-cluster-$ms-$port \
        --net network-redis-cluster \
        redis:6.0 redis-server /conf/redis.conf;
    done


    echo "========== 配置集群 =================="
    matches=""
    for port in $PORTS; do
    	ms="master"
    	if [ $port -ge 7003 ]; then
    		ms="slave"
    	fi
    	matches=$matches$(docker inspect --format '{{(index .NetworkSettings.Networks "network-redis-cluster").IPAddress}}' "redis-cluster-$ms-${port}"):${port}" ";
    done

    # 创建docker-cluster
    # redis 4 or 3版本
    #需要redis-trib 镜像
    #docker run -it --rm --net redis-cluster-net redis-trib ruby redis-trib.rb create --replicas 1 $matches

    #redis 5 版本
    docker run -it --rm --net network-redis-cluster --privileged=true redis  redis-cli --cluster create $matches --cluster-replicas 1
    #如果权限不够，则添加一下参数
    #--privileged=true
}

function redis_cluster_install() {
    
}


# 执行删除
if [ "$1" = "--remove" ]; then
  remove_cluster
  exit 0
fi


