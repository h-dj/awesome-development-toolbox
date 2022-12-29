#!/bin/bash

BASE_DIR=$PWD
PORTS=`seq 7000 7005`

# Remove redis cluster
function remove_cluster() {
    if [ "$(docker ps -q -f name=redis-cluster-$ms-$port)" ]; then
      #stop
          echo "==========��ͣ redis docker ����============"
          docker container stop redis-cluster-$ms-$port
    fi
    if [ "$(docker ps -aq -f status=exited -f status=created -f status=dead -f name=redis-cluster-$ms-$port)" ]; then
          #cleanup
          echo "==========ɾ�� redis docker ����============"
          docker container rm redis-cluster-$ms-$port
    fi

    if [ -d "$BASE_DIR" ]; then
      echo -n "�Ƿ�ɾ�� redis ���ú����� default n:(Y/n)"
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
    echo "========== ׼����ʼ�� =================="
    echo -n "�����밲װ·�� default $BASE_DIR:"
    read install_dir
    if [ -d "$install_dir" ]; then
        $BASE_DIR = $install_dir
      else
         echo -n "���밲װ·�������ڣ�����Ĭ�� $BASE_DIR"
    fi
    #master �� slave �ļ���
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
    #��������
    if [  ! -n "$( docker network ls -q -f name=network-redis-cluster)" ]; then
        docker network create network-redis-cluster
    fi
    echo "========== ����ʵ�� =================="
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


    echo "========== ���ü�Ⱥ =================="
    matches=""
    for port in $PORTS; do
    	ms="master"
    	if [ $port -ge 7003 ]; then
    		ms="slave"
    	fi
    	matches=$matches$(docker inspect --format '{{(index .NetworkSettings.Networks "network-redis-cluster").IPAddress}}' "redis-cluster-$ms-${port}"):${port}" ";
    done

    # ����docker-cluster
    # redis 4 or 3�汾
    #��Ҫredis-trib ����
    #docker run -it --rm --net redis-cluster-net redis-trib ruby redis-trib.rb create --replicas 1 $matches

    #redis 5 �汾
    docker run -it --rm --net network-redis-cluster --privileged=true redis  redis-cli --cluster create $matches --cluster-replicas 1
    #���Ȩ�޲����������һ�²���
    #--privileged=true
}

function redis_cluster_install() {
    
}


# ִ��ɾ��
if [ "$1" = "--remove" ]; then
  remove_cluster
  exit 0
fi


