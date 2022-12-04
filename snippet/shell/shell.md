1. 添加ssh 
```shell
#新增shell
ssh-keygen -t ed25519 -C "your_email@example.com"

#在后台启动ssh代理
eval "$(ssh-agent -s)"

# 添加私钥
ssh-add ~/.ssh/id_ed25519
```

2、修改时间
```shell
# 选择时区
tzselect
# 修改时间
cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
```