基于mysql 8.0.37版本



### 1、安装组复制插件
```shell
INSTALL PLUGIN group_replication SONAME 'group_replication.so';
```

### 2、配置组复制参数
```shell

### 注意
#使用docker 部署，ip 地址写主机的ip 是不行的，要写docker 配置的容器ip 
# 

SET GLOBAL group_replication_bootstrap_group=OFF;
SET GLOBAL group_replication_group_name='299bd603-10c0-4db7-9c91-f80dd7a82dbe';
SET GLOBAL group_replication_start_on_boot=ON;
SET GLOBAL group_replication_local_address='192.168.1.10:33061';
SET GLOBAL group_replication_group_seeds='192.168.1.10:33061,192.168.1.11:33061,192.168.1.12:33061';
SET GLOBAL group_replication_single_primary_mode=ON;
SET GLOBAL group_replication_enforce_update_everywhere_checks=OFF;
SET GLOBAL group_replication_ip_whitelist='192.168.1.10,192.168.1.11,192.168.1.12';
SET GLOBAL group_replication_ip_allowlist='192.168.1.10,192.168.1.11,192.168.1.12';
SET GLOBAL group_replication_recovery_use_ssl=OFF;

```


### 3、创建用户
```shell
# docker 启动后就创建了，可以不用再执行
SET SQL_LOG_BIN=0;
CREATE USER rpl_user@'%' IDENTIFIED BY '123456';
GRANT REPLICATION SLAVE ON *.* TO rpl_user@'%';
GRANT CONNECTION_ADMIN ON *.* TO rpl_user@'%';
GRANT BACKUP_ADMIN ON *.* TO rpl_user@'%';
GRANT GROUP_REPLICATION_STREAM ON *.* TO rpl_user@'%';
FLUSH PRIVILEGES;
SET SQL_LOG_BIN=1;

```

### 4、开始组复制
```shell
CHANGE REPLICATION SOURCE TO  SOURCE_USER='rpl_user', SOURCE_PASSWORD='password' FOR CHANNEL 'group_replication_recovery';
```

### 5、启动
```shell
# 重置 gtid 事物id
# gtid_executed 相同则不用重置，重置数据会丢失
# show variables like 'gtid%'
# STOP GROUP_REPLICATION
# reset master

# 主库
SET GLOBAL group_replication_bootstrap_group=ON;
START GROUP_REPLICATION USER='rpl_user', PASSWORD='123456' ,DEFAULT_AUTH='mysql_native_password';
SET GLOBAL group_replication_bootstrap_group=OFF;

# 从库
START GROUP_REPLICATION USER='rpl_user', PASSWORD='123456' ,DEFAULT_AUTH='mysql_native_password';


```


### 6、检查命令
```shell
# 查看插件安装情况
show plugins;

# 查看组复制 参数
show variables like 'group_replication%'

# 查看gtid 事务id
show variables like 'gtid%'

# 查看组复制成员
SELECT * FROM performance_schema.replication_group_members;

```

### 7、添加新的节点
1、根据步骤1~5 执行即可
2、注意ip 地址的替换


