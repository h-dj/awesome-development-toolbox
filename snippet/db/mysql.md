### mysql 创建用户及授权

- 创建用户

```shell
CREATE USER 'blog'@'%' IDENTIFIED BY 'blog@123456';

#例子
CREATE USER 'demo'@'192.168.43.178' IDENTIFIED BY '123456';
CREATE USER 'demo'@'%' IDENTIFIED BY '123456';
```

- 授权

```shell
GRANT privileges ON databasename.tablename TO 'username'@'host'

#privileges：用户的操作权限，如SELECT，INSERT，UPDATE等，如果要授予所的权限则使用ALL
#databasename：数据库名
#tablename：表名，如果要授予该用户对所有数据库和表的相应操作权限则可用*表示，如*.*

#例子
GRANT SELECT, INSERT ON test.user TO 'demo'@'192.168.43.178';
GRANT ALL ON *.* TO 'demo'@'192.168.43.178';
GRANT ALL ON student.* TO 'demo'@'192.168.43.178';

FLUSH PRIVILEGES;

```

- 查询用户

```shell
use mysql;
select  host,user,plugin,authentication_string  from   mysql.user;
```

- 设置与更改用户密码

```shell
SET PASSWORD FOR 'username'@'host' = PASSWORD('newpassword');
```

- 修改用户host

```shell
#修改用户访问权限 
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
FLUSH PRIVILEGES;
```

- 撤销用户权限

```shell
REVOKE privilege ON databasename.tablename FROM 'username'@'host';
```

- 删除用户

```shell
DROP USER 'username'@'host';
```

### mysql 备份与还原

- 查看binlog相关参数

```shell
show variables like 'log_bin%';


Variable_name                  |Value                      |
-------------------------------|---------------------------|
log_bin                        |ON                         |
log_bin_basename               |/var/lib/mysql/binlog      |
log_bin_index                  |/var/lib/mysql/binlog.index|
log_bin_trust_function_creators|OFF                        |
log_bin_use_v1_row_events      |OFF                        |
```

- 开启binlog日志

```shell
#在my.conf配置文件
[mysqld] 
#binlog日志文件目录,默认存储在mysql的datadir参数指定的目录下
log-bin=/MySQL/my3306/log/binlog/binlog  
#binlog_format的几种格式:(STATEMENT,ROW和MIXED):
#STATEMENT:基于SQL语句的复制(statement-based replication, SBR)  
#ROW:基于行的复制(row-based replication, RBR)  
#MIXED:混合模式复制(mixed-based replication, MBR)
binlog_format = row
```

- 查看binlog日志文件

```shell
mysqlbinlog '/var/lib/mysql/binlog.000010'
```

- 常用操作

```shell
show master logs;  #查看数据库所有日志文件。 
show binlog events;  #查看当前使用的binlog文件信息。 
show binlog events in 'binlog.000001';  #查看指定的binlog文件信息。 
flush logs;  #将内存中log日志写磁盘，保存在当前binlog文件中，并产生一个新的binlog日志文件。 
flush logs; reset master;  #删除所有二进制日志，并重新（binlog.000001）开始记录。
```

- 使用mysqldump全量备份（mysql8）

```shell
# 备份命令mysqldump格式
# 格式：mysqldump -h主机名  -P端口 -u用户名 -p密码 –database 数据库名 > 文件名.sql 
# https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
# `date +"%Y%m%d"`
mysqldump -uroot -p123456 --databases blog >  /home/mysql/backup/backupfile.sql

# 常用参数
# --databases  指定 数据库，可以指定多个
#  --tables 指定表 ，可以指定多个
# --ignore-table=blog.t_log 忽略表
# -d 备份数据库表结构
# -t 备份数据库表数据
# –all-databases 备份服务器上所有数据库
```

- 增量备份

```
# https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html#option_mysqldump_source-data
# --master-data  写binlog日志
#首先做一次完整备份
mysqldump -uroot -p123456 --single-transaction  --master-data=2 --databases blog-backup > backupfile.sql

#将log日志写入磁盘
flush logs;
```

- 还原

```

#格式
#mysql -h主机 -P端口 -u用户名 -p密码 数据库名 < sql文件.sql
mysql -hlocalhost -P3306  -uroot -p123456 blog-backup < backupfile2.sql

#迁移到新服务器
mysqldump -uusername -ppassword databasename | mysql –host=*.*.*.* -C databasename
```

### MySQL 调试优化

- 查看慢日志

```
-- #查询版本号
show variables like '%version%' 
-- 查看慢日志是否开启
show variables like 'slow_query_log';
-- 查看日志
show variables like '%log%'
-- 开启记录索引查询日志
set global log_queries_not_using_indexes=ON

-- 查询时间
show variables LIKE 'long_query_time';
-- 开启慢日志
set global slow_query_log = ON
-- 查看慢日志存储位置
show variables like 'slow%'


-- 慢日志相关参数
slow_query_log #慢查询开启状态,ON开启,OFF关闭
slow_query_log_file #慢查询日志存放的位置（这个目录需要MySQL的运行帐号的可写权限,一般设置为MySQL的数据存放目录）
long_query_time #查询超过多少秒才记录,默认10s,查询命令 SHOW VARIABLES LIKE 'long_query_time';
log_queries_not_using_indexes = 1 #表明记录没有使用索引的 SQL 语句


```



### mysql 使用技巧

- 查询数据库表，并行转列

```shell
select GROUP_CONCAT(table_name)  
from information_schema.tables 
where table_schema='test';
```

