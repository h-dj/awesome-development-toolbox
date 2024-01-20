### oracle 配置修改
- 登陆oracle  fgfdgd
```shell
 
sqlplus SYS/admin123  as sysdba



# 查询过期用户
SELECT username, account_status FROM dba_users WHERE ACCOUNT_STATUS LIKE '%EXPIRED%';

#修改用户密码
ALTER USER system IDENTIFIED BY system;   

#解锁用户
ALTER USER system ACCOUNT UNLOCK;
```

- 查询oracle server 字符集
```shell
select userenv('language') from dual;

#SIMPLIFIED CHINESE_CHINA.ZHS16GBK
```
- dmp文件的第2和第3个字节记录了dmp文件的字符集
```shell
# cat exp.dmp |od -x|head -1|awk '{print $2 $3}'|cut -c 3-6
 select nls_charset_name(to_number('0354','xxxx')) from dual;
```
- 查询oracle client端的字符集
```shell
echo $NLS_LANG
```

- 修改数据库字符集
```shell
#关闭数据库 
sql> shutdown immediate;
#数据库装载 
sql> startup restrict;

#数据字符集修改
#AL32UTF8 \ ZHS16GBK
#export NLS_LANG="simplified chinese"_china.zhs16gbk
sql> ALTER DATABASE character set INTERNAL_USE ZHS16GBK;

#重启数据库 
sql> shutdown immediate;
#启动实例
sql> startup;
sql> quit;
```

### oracle 创建用户及授权
- 创建表空间
```shell
CREATE TABLESPACE cemmall
DATAFILE '/u01/app/oracle/oradata/XE/cemmall.dbf' size 8000M
         EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
         
-- 表空间自动扩展
alter database datafile '/u01/app/oracle/oradata/XE/cemmall.dbf' autoextend on next 5m maxsize unlimited;
-- 临时文件自动扩展
alter database tempfile '/oradata/orcl/temp01.dbf' autoextend on next 5m maxsize unlimited;
```
- 创建用户
```shell
create user cemmall identified by abc123
default tablespace cemmall;
```
- 授权
```shell
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
```

- 修改密码
```shell
update user$ set name ='asxxsst2' where name='asxxsst';
```

- 导出导入命令
```shell
#导出命令
exp demo/demo@127.0.0.1:1521/orcl file=f:/f.dmp full=y
exp demo/demo@orcl file=f:/f.dmp full=y

exp CEMMALL/CEMMALL@127.0.0.1:1521/XE file=/u01/app/oracle/CEMMALL.dmp full=y
expdp CEMMALL/CEMMALL@127.0.0.1:1521/XE SCHEMAS=CEMMALL DUMPFILE=CEMMALL2.dmp
# 导出DDL
expdp CEMMALL/CEMMALL@127.0.0.1:1521/XE SCHEMAS=CEMMALL DUMPFILE=CEMMALL_ddl.dmp CONTENT=METADATA_ONLY


#导入方式：
imp demo/demo@orcl file=f:/f.dmp full=y ignore=y

impdp cemmall/cemmall@127.0.0.1:1521/XE SCHEMAS=CEMMALL DUMPFILE=CEMMALL2.dmp LOGFILE=import_log.log


导入sql 文件
# 登录用户
sqlplus username/password
# 导入文件
@D:/test.sql; 

#提交
commit;
```

### 常用的sql 片段

- 递归查询节点
```shell
#（1）通过父ID查询所有子节点
select * from group_info  start with parent_id='0' connect by prior id=parent_id

#（2）通过子ID查询所有父节点
select * from group_info start with id='61' connect by prior parent_id=id
```

- 行转列
```shell
select xmlagg(xmlparse(content table_name ||',' wellformed) order by table_name).getclobval() AS tagg
from dba_tables  where owner='CEMMALL';

#使用pivot
select * from (select name, nums from demo) pivot (sum(nums) for name in ('苹果' 苹果, '橘子', '葡萄', '芒果'));
```

- 查询 oracle 序列
```shell
select 'create sequence  '|| SEQUENCE_NAME || '_SEQ minvalue '||MIN_VALUE||' maxvalue '||MAX_VALUE||'   
start with '||LAST_NUMBER||' increment by '||INCREMENT_BY||';' as sql
from dba_sequences where SEQUENCE_OWNER='CEMMALL';
```

- 分组排序
```shell
#按照table_.COMPANY_ID 分组
#按照table_.CREATE_TIME 排序
select table_.*
       ,row_number() over (partition by table_.COMPANY_ID order by table_.CREATE_TIME desc nulls last ,table_.id) as n
from table_ cs
```


- oracle 日期格式写法
```shell
yyyy-MM-dd hh24:mi:ss

#e.g
# to_char(o.CREATE_TIME,'yyyy-MM-dd hh24:mi:ss')  &gt;= to_char(#{param.createTimeStart},'yyyy-MM-dd hh24:mi:ss')
```