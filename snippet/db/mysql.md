### mysql 创建用户及授权
- 创建用户
```shell
CREATE USER 'blog'@'%' IDENTIFIED BY 'blog@123456';

#例子
CREATE USER 'demo'@'192.168.43.178' IDENDIFIED BY '123456';
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

### mysql 使用技巧
- 查询数据库表，并行转列
```shell
select GROUP_CONCAT(table_name,",")  
from information_schema.tables 
where table_schema='cmall' and table_type='base table';
```