### 1、创建用户
```shell

#GRANT privileges ON databasename.tablename TO 'username'@'host'
#privileges：用户的操作权限，如SELECT，INSERT，UPDATE等，如果要授予所的权限则使用ALL
#databasename：数据库名
#tablename：表名，如果要授予该用户对所有数据库和表的相应操作权限则可用*表示，如*.*

# 代理用户
SET SQL_LOG_BIN=0;
CREATE USER proxyuser@'%' IDENTIFIED BY '123456';
GRANT ALL ON *.* TO 'proxyuser'@'%';

# 监控用户
CREATE USER 'monitor'@'%' IDENTIFIED BY '123456';
GRANT SELECT ON *.* TO 'monitor'@'%';
FLUSH PRIVILEGES;
SET SQL_LOG_BIN=1;

```

### 2、添加数据库实例
```sql
-- 登录 
mysql -u admin -padmin -h 127.0.0.1 -P 6032 --prompt "ProxySQL Admin>"


-- 添加主库
INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (0, 'mysql1', 3306);

-- 添加从库
INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (1, 'mysql2', 3306);
INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (1, 'mysql3', 3306);

-- 应用配置
LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;
```

### 3、配置读写规则
```sql
- 将 SELECT 语句路由到从库
INSERT INTO mysql_query_rules(rule_id, active, match_pattern, destination_hostgroup) VALUES (1, 1, '^SELECT.*', 1);

-- 将其他操作路由到主库
INSERT INTO mysql_query_rules(rule_id, active, match_pattern, destination_hostgroup) VALUES (2, 1, '^(?!SELECT).*', 0);

-- 应用配置
LOAD MYSQL QUERY RULES TO RUNTIME;
SAVE MYSQL QUERY RULES TO DISK;
```

### 4、开启rest api 
```shell
4. API 端点
ProxySQL 的 REST API 提供了多个端点用于管理和监控：
https://github.com/sysown/proxysql/blob/v2.x/scripts/README.md

/api/proxysql/servers: 管理后端服务器。
/api/proxysql/config: 管理配置设置。
/api/proxysql/stats: 获取 ProxySQL 的统计信息。
/api/proxysql/users: 管理用户。
{ "admin_host": "127.0.0.1", "admin_port": 6032, "admin_user": "radmin", "admin_pass": "radmin" }
```
