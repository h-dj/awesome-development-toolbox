1、配置 
```shell
# /etc/docker/daemon.json

{ "insecure-registries":["192.168.56.200:5000"] }


sudo systemctl daemon-reload && sudo systemctl restart docker
```

2、push 镜像
```shell
docker pull mysql:8.0
docker tag mysql:8.0 192.168.56.200:5000/mysql:8.0
docker push 192.168.56.200:5000/mysql:8.0

y
```