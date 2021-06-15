### 常用的sql 片段


##### 1、递归查询节点
```

-- （1）通过父ID查询所有子节点

select * from group_info  start with parent_id='0' connect by prior id=parent_id


-- （2）通过子ID查询所有父节点

select * from group_info start with id='61' connect by prior parent_id=id
```

