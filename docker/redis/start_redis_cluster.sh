#!/bin/bash
#拼接masters : slaves 节点参数
matches=""
for port in `seq 7000 7005`; do
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