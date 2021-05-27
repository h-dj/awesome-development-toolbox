#!/usr/bin/env bash
# nginx 相关命令

### 帮助命令
nginx -h

### 查nginx 配置
./nginx -t

### 重启
./nginx -s reload

### 停止
nginx -s stop
### 平滑停止
nginx -s quit


### 启动 -c 指定启动配置文件
nginx -c [path]
