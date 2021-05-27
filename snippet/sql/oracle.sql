-- 1、oracle 用户 空间授权
--------------------------------------------
--------------------------------------------
--表空间
CREATE TABLESPACE sdt
DATAFILE 'F:\tablespace\demo' size 800M
         EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
--索引表空间
CREATE TABLESPACE sdt_Index
DATAFILE 'F:\tablespace\demo' size 512M
         EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;

--2.建用户
create user demo identified by demo
default tablespace std;

--3.赋权
grant connect,resource to demo;
grant create any sequence to demo;
grant create any table to demo;
grant delete any table to demo;
grant insert any table to demo;
grant select any table to demo;
grant unlimited tablespace to demo;
grant execute any procedure to demo;
grant update any table to demo;
grant create any view to demo;
--------------------------------------------
--------------------------------------------


-- 2、 组内排序
--------------------------------------------
--------------------------------------------
select table_.*
        -- 按照table_.COMPANY_ID 分组，
        -- 按照table_.CREATE_TIME 排序
       ,row_number() over (partition by table_.COMPANY_ID order by table_.CREATE_TIME desc nulls last ,table_.id) as n
from table_ cs
--------------------------------------------
--------------------------------------------