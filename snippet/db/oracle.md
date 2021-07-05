### oracle 创建用户及授权
- 创建表空间
```shell
CREATE TABLESPACE cemmall
DATAFILE '/u01/app/oracle/oradata/XE/cemmall.dbf' size 800M
         EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
         
-- 表空间自动扩展
alter database datafile '/u01/app/oracle/product/11.2.0/xe/dbs/CEMMALL.dbf' autoextend on next 5m maxsize unlimited;
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
#导入方式：
imp demo/demo@orcl file=f:/f.dmp full=y ignore=y
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

- 分组排序
```shell
#按照table_.COMPANY_ID 分组
#按照table_.CREATE_TIME 排序
select table_.*
       ,row_number() over (partition by table_.COMPANY_ID order by table_.CREATE_TIME desc nulls last ,table_.id) as n
from table_ cs
```