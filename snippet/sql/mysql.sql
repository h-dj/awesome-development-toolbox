-- 查询数据库表，并行转列
select GROUP_CONCAT(table_name,",")  from information_schema.tables where table_schema='cmall' and table_type='base table';