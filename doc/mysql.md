### MySQL 相关运维操作

#### 防止误删数据
1. 把 sql_safe_updates 参数设置为 on。 防止在delete或者update时没有添加where条件
2. 代码上线前，必须经过 SQL 审计。
3. 账号分离。这样做的目的是，避免写错命令，并且配置只读账号
4. 制定操作规范。这样做的目的，是避免写错要删除的表名
5. 如果是要删表，就rename，过了观察时间再执行drop

#### 已误删数据，怎么救?
这种情况下，要想恢复数据，就需要使用全量备份，加增量日志的方式了。
这个方案要求线上有定期的全量备份，并且实时备份 binlog。
在这两个条件都具备的情况下，假如有人中午 12 点误删了一个库，恢复数据的流程如下：
1. 取最近一次全量备份，假设这个库是一天一备，上次备份是当天 0 点；
2. 用备份恢复出一个临时库；从日志备份里面，取出凌晨 0 点之后的日志；
3. 把这些日志，除了误删除数据的语句外，全部应用到临时库。