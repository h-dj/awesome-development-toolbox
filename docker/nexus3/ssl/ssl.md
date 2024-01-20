## 自建证书生成
- 下载ssl 脚本

```shell
git clone https://github.com/Fishdrowned/ssl.git
```

- 生成证书
```shell
cd ssl

# idocker.io 本地域名， 需要配host
./gen.cert.sh idocker.io
```

- 配置 hosts
```shell
vim /etc/hosts

# 换成自己本机的ip地址
192.168.43.122 local.docker.io
192.168.43.122 web.docker.io

```