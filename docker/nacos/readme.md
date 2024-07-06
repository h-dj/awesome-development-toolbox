1、创建用户
```shell

CREATE USER 'nacos'@'%' IDENTIFIED BY '123456';
GRANT ALL ON nacos_devtest.* TO 'nacos'@'%';
FLUSH PRIVILEGES;

```

2、执行sql 
```
CREATE DATABASE `nacos_devtest` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

```