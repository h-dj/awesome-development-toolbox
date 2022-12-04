#!/bin/bash
bakfile=/tmp/hosts_$RANDOM
# 定义仓库域名和 nexus 前台域名
docker_domain=idocker.io
repo_domain=repo.xxx.com
# 绑定仓库域名解析
cp /etc/hosts $bakfile || exit 1
echo "/etc/hosts is bakcup to $bakfile"
if grep -q "$idocker_domain" /etc/hosts;then
    sed -i 's/.*$docker_domain/192.168.1.100 $docker_domain/g' /etc/hosts
else
    echo "192.168.1.100 $docker_domain" >> /etc/hosts
fi
echo
# 探测到仓库是否畅通
if which telnet >/dev/null 2>&1;then
    echo start trying to connect to $docker_domain:443 ...
    if ! echo "e" | telnet -e "e" $docker_domain 443 >/dev/null;then
       echo "Can not connect to $docker_domain:443,Plz check!"
    else
       echo connect success.
    fi
fi
echo
# 开始部署证书
mkdir -p /etc/docker/certs.d/$docker_domain
curl -s -o /etc/docker/certs.d/$docker_domain/ca.crt http://$repo_domain/download/cert/ca.crt

echo Docker repository init success, you need login when you want upload docker images.
echo 'Plz Run "docker login --username=idocker $docker_domain"'