- 开启进程堆栈访问
```shell
# 临时开启
echo 0 > /proc/sys/kernel/yama/ptrace_scope

# 永久开启:
/etc/sysctl.d/10-ptrace.conf
#添加或修改为以下这一句:(0:允许, 1:不允许)
kernel.yama.ptrace_scope = 0
```


1. 远程监控参数配置VisualVM
```
-Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=192.168.11.94
```

2. 自动 dump 堆文件
```shell
-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/home/server/dump.hprof
```

3. 打印gc日志
```shell
-XX:+UseParallelGC
-Xloggc:gc.demo.log
-XX:+PrintGCDetails
-XX:+PrintGCDateStamps
```

4. 查看堆概括信息
```shell
jmap -heap pid
```

5. 手动 dump 堆
```shell
jmap -dump:format=b,file=/tmp/HeapDump.hprof pid
```