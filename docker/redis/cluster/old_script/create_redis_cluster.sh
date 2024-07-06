#!/bin/bash

#创建网络
 if [  ! -n "$( docker network ls -q -f name=network-redis-cluster)" ]; then
    docker network create network-redis-cluster
fi



#运行docker redis 的 master 和 slave 实例
for port in `seq 7000 7005`; do
	ms="master"
	if [ $port -ge 7003 ]; then
		ms="slave"
	fi

  if [ "$(docker ps -q -f name=redis-cluster-$ms-$port)" ]; then
    #stop
    docker container stop redis-cluster-$ms-$port
  fi
  if [ "$(docker ps -aq -f status=exited -f status=created -f status=dead -f name=redis-cluster-$ms-$port)" ]; then
        #cleanup
        docker container rm redis-cluster-$ms-$port
  fi
  # run your container
  docker run -d -p $port:$port -p 1$port:1$port \
    -v $PWD/$ms/$port/conf:/conf \
    -v $PWD/$ms/$port/data:/data \
    --privileged=true --restart always \
    --name redis-cluster-$ms-$port \
    --net network-redis-cluster \
    docker.homecloud.com/redis:6.0 redis-server /conf/redis.conf;
done