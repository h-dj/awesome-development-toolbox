#!/bin/bash
#删除创建的文件
rm -rf $PWD/master $PWD/slave
#master 和 slave 文件夹
for port in `seq 7000 7005`; do
	ms="master"
	if [ $port -ge 7003 ]; then
		ms="slave"
	fi
	mkdir -p $PWD/$ms/$port/conf \
  	&& mkdir -vp $PWD/$ms/$port/data \
		&& PORT=$port envsubst < ./redis.cluster.template > $PWD/$ms/$port/conf/redis.conf;
done



