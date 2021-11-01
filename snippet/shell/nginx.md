### nginx 相关命令

#### 启动 -c 指定启动配置文件
```shell
nginx -c [path]
```

#### 发送信号执行相关命令 -s 
```shell
nginx -s signal

#stop — 快速关闭
#quit — 安全退出
#reload — 重新加载配置
#reopen — 重新打开日志文件
```

#### 查看nginx 进程
```shell
ps -ax | grep nginx
```