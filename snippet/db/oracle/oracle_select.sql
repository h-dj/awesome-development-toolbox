-- 查看表空间大小
SELECT D.TABLESPACE_NAME,
       SPACE || 'M' "SUM_SPACE(M)",
       BLOCKS "SUM_BLOCKS",
       SPACE - NVL (FREE_SPACE, 0) || 'M' "USED_SPACE(M)",
       ROUND ( (1 - NVL (FREE_SPACE, 0) / SPACE) * 100, 2) ||

'%'
          "USED_RATE(%)",
       FREE_SPACE || 'M' "FREE_SPACE(M)"
  FROM (  SELECT TABLESPACE_NAME,
                 ROUND (SUM (BYTES) / (1024 * 1024), 2) SPACE,
                 SUM (BLOCKS) BLOCKS
            FROM DBA_DATA_FILES
        GROUP BY TABLESPACE_NAME) D,
       (  SELECT TABLESPACE_NAME,
                 ROUND (SUM (BYTES) / (1024 * 1024), 2)

FREE_SPACE
            FROM DBA_FREE_SPACE
        GROUP BY TABLESPACE_NAME) F
 WHERE D.TABLESPACE_NAME = F.TABLESPACE_NAME(+)
UNION ALL

   --如果有临时表空间
SELECT D.TABLESPACE_NAME,
       SPACE || 'M' "SUM_SPACE(M)",
       BLOCKS SUM_BLOCKS,
       USED_SPACE || 'M' "USED_SPACE(M)",
       ROUND (NVL (USED_SPACE, 0) / SPACE * 100, 2) || '%'

"USED_RATE(%)",
       NVL (FREE_SPACE, 0) || 'M' "FREE_SPACE(M)"
  FROM (  SELECT TABLESPACE_NAME,
                 ROUND (SUM (BYTES) / (1024 * 1024), 2) SPACE,
                 SUM (BLOCKS) BLOCKS
            FROM DBA_TEMP_FILES
        GROUP BY TABLESPACE_NAME) D,
       (  SELECT TABLESPACE_NAME,
                 ROUND (SUM (BYTES_USED) / (1024 * 1024), 2)

USED_SPACE,
                 ROUND (SUM (BYTES_FREE) / (1024 * 1024), 2)

FREE_SPACE
            FROM V$TEMP_SPACE_HEADER
        GROUP BY TABLESPACE_NAME) F
 WHERE D.TABLESPACE_NAME = F.TABLESPACE_NAME(+)
ORDER BY 1;
--------------------------------------------
--------------------------------------------


--查看表空间里所有表
-- 列传行
select listagg(table_name, ',') within GROUP(ORDER BY table_name) AS tagg from dba_tables  where owner='CEMMALL';

select xmlagg(xmlparse(content table_name||',' wellformed) order by table_name).getclobval() AS tagg from dba_tables  where owner='CEMMALL';



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
