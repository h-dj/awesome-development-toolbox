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


6、 零拷贝分割文件
```java
// 链接：https://juejin.cn/post/6844904205556121607
class Main{

    public static void chunkFile(Path file, long chunkSize) throws IOException {
        if (Files.notExists(file) || Files.isDirectory(file)) {
            throw new IllegalArgumentException("文件不存在:" + file);
        }
        if (chunkSize < 1) {
            throw new IllegalArgumentException("分片大小不能小于1个字节:" + chunkSize);
        }
        // 原始文件大小
        final long fileSize = Files.size(file);
        // 分片数量
        final long numberOfChunk = fileSize % chunkSize == 0 ? fileSize / chunkSize : (fileSize / chunkSize) + 1;
        // 原始文件名称
        final String fileName = file.getFileName().toString();
        // 读取原始文件
        try(FileChannel fileChannel = FileChannel.open(file, EnumSet.of(StandardOpenOption.READ))){
            for (int i = 0; i < numberOfChunk; i++) {
                long start = i * chunkSize;
                long end = start + chunkSize;
                if (end > fileSize) {
                    end = fileSize;
                }
                // 分片文件名称
                Path chunkFile = Paths.get(fileName + "-" + (i + 1));
                try (FileChannel chunkFileChannel = FileChannel.open(file.resolveSibling(chunkFile), 
                                        EnumSet.of(StandardOpenOption.CREATE_NEW, StandardOpenOption.WRITE))){
                    // 返回写入的数据长度
                    fileChannel.transferTo(start, end - start, chunkFileChannel);
                }
            }
        }
    }

    /**
     * 把多个文件合并为一个文件
     * @param file			目标文件	
     * @param chunkFiles	分片文件
     */
    public static void mergeFile (Path file, Path ... chunkFiles) throws IOException {
        if (chunkFiles == null || chunkFiles.length == 0) {
            throw new IllegalArgumentException("分片文件不能为空");
        }
        try (FileChannel fileChannel = FileChannel.open(file, EnumSet.of(StandardOpenOption.CREATE_NEW, StandardOpenOption.WRITE))){
            for (Path chunkFile : chunkFiles) {
                try(FileChannel chunkChannel = FileChannel.open(chunkFile, EnumSet.of(StandardOpenOption.READ))){
                    chunkChannel.transferTo(0, chunkChannel.size(), fileChannel);
                }
            }
        }
    }
}
```