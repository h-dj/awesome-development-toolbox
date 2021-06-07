### excel 帮助公式片段


#### 1、两列交集
```
=IF(COUNTIF(B:B,A3)>0,"A 列的值在 B 列中存在","")
```

#### 2、两列差集
```shell
IF(COUNTIF($B:$B,A2)=0,A2,"")
```