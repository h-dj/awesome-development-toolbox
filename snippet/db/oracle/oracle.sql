--oracle 数据库相关命令

--表空间
CREATE TABLESPACE cemmall
DATAFILE '/u01/app/oracle/oradata/XE/cemmall.dbf' size 800M
         EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
--索引表空间
CREATE TABLESPACE cemmall_Index
DATAFILE '/u01/app/oracle/oradata/XE/cemmall_index.dbf' size 512M
         EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;

--2.建用户
create user cemmall identified by abc123
default tablespace cemmall;

--3.赋权
grant connect,resource,dba to cemmall;
grant create any sequence to cemmall;
grant create any table to cemmall;
grant delete any table to cemmall;
grant insert any table to cemmall;
grant select any table to cemmall;
grant unlimited tablespace to cemmall;
grant execute any procedure to cemmall;
grant update any table to cemmall;
grant create any view to cemmall;

--修改用户名密码
update user$ set name ='asxxsst2' where name='asxxsst';

--表空间自动扩展
alter database datafile '/u01/app/oracle/product/11.2.0/xe/dbs/CEMMALL.dbf' autoextend on next 5m maxsize unlimited;
--临时文件自动扩展
alter database tempfile '/oradata/orcl/temp01.dbf' autoextend on next 5m maxsize unlimited;



--导入导出命令
--ip导出方式：
exp demo/demo@127.0.0.1:1521/orcl file=f:/f.dmp full=y
exp demo/demo@orcl file=f:/f.dmp full=y
imp demo/demo@orcl file=f:/f.dmp full=y ignore=y

docker exec -it oracle exp demo/demo@127.0.0.1:1521/orcl file=/u01/app/oracle/backup/cemmall.dmp full=y