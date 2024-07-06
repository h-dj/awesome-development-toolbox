基于mysql 8.0.37版本

### 1、启动主从
```

change master to master_host='192.168.56.200'
					,master_port=4400
					,master_auto_position=1;

#启动slaver 服务
START REPLICA USER='rpl_user' PASSWORD='123456';


# 查看从数据库的状态
SHOW REPLICA STATUS

# 看到以下两列 为Yes ，证明连接成功
#Slave_IO_Running             |Yes  
#Slave_SQL_Running            |Yes  			
```

### 2、启用版异步复制
#### 2.1、安装插件
```shell
install plugin rpl_semi_sync_source soname 'semisync_source.so';
install plugin rpl_semi_sync_replica soname 'semisync_replica.so';
```
#### 2.2、查看插件
```shell
show plugins;
```

### 2.3、查看插件配置
```shell
show variables like 'rpl_semi%';
```

### 3、故障切换
```shell

```


### 4、主从不一致问题处理
```sql
-- 备份数据库
DBS=$(mysql -u root -p123456 -e 'SHOW DATABASES;' | grep -Ev 'Database|information_schema|performance_schema|sys')
mysqldump -u root -p123456 --databases $DBS --set-gtid-purged=OFF > alldb.sql

mysqldump -h localhost -u root -p123456 --skip-triggers --compact mysql user > users_backup.sql


-- 恢复
mysql  -u root -p123456 <  /alldb.sql
```