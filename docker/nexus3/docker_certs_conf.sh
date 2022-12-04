#!/bin/bash
bakfile=/tmp/hosts_$RANDOM
# ����ֿ������� nexus ǰ̨����
docker_domain=idocker.io
repo_domain=repo.xxx.com
# �󶨲ֿ���������
cp /etc/hosts $bakfile || exit 1
echo "/etc/hosts is bakcup to $bakfile"
if grep -q "$idocker_domain" /etc/hosts;then
    sed -i 's/.*$docker_domain/192.168.1.100 $docker_domain/g' /etc/hosts
else
    echo "192.168.1.100 $docker_domain" >> /etc/hosts
fi
echo
# ̽�⵽�ֿ��Ƿ�ͨ
if which telnet >/dev/null 2>&1;then
    echo start trying to connect to $docker_domain:443 ...
    if ! echo "e" | telnet -e "e" $docker_domain 443 >/dev/null;then
       echo "Can not connect to $docker_domain:443,Plz check!"
    else
       echo connect success.
    fi
fi
echo
# ��ʼ����֤��
mkdir -p /etc/docker/certs.d/$docker_domain
curl -s -o /etc/docker/certs.d/$docker_domain/ca.crt http://$repo_domain/download/cert/ca.crt

echo Docker repository init success, you need login when you want upload docker images.
echo 'Plz Run "docker login --username=idocker $docker_domain"'