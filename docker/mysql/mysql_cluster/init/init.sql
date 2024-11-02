SET SQL_LOG_BIN=0;
-- 主从复制用户
CREATE USER  IF NOT EXISTS 'rpl_user'@'%' IDENTIFIED BY '123456';
GRANT REPLICATION SLAVE ON *.* TO rpl_user@'%';

-- 代理用户
CREATE USER IF NOT EXISTS 'proxyuser'@'%' IDENTIFIED BY '123456';
GRANT ALL ON *.* TO 'proxyuser'@'%';

--  监控用户
CREATE USER IF NOT EXISTS 'monitor'@'%' IDENTIFIED BY '123456';
GRANT SELECT ON *.* TO 'monitor'@'%';

-- exporter 用户
CREATE USER IF NOT EXISTS 'exporter'@'%' IDENTIFIED BY '123456';
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';

FLUSH PRIVILEGES;
SET SQL_LOG_BIN=1;