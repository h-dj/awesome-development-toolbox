1、创建命名空间
```shell
kubectl create namespace mysql

```

2、安装
```shell
helm install my-mysql bitnami/mysql -f mysql-values.yaml \
  --namespace mysql
  
 helm upgrade my-mysql bitnami/mysql -f mysql-values.yaml \
  --namespace mysql

```

3、卸载
```shell
helm uninstall my-mysql -n mysql
kubectl delete pvc --all -n mysql
kubectl delete configmap mysql-config -n mysql

kubectl get all -n mysql
kubectl get pvc -n mysql
```

4、部署proxySQL
```shell
helm install my-proxysql dysnix/proxysql -f proxysql-values.yaml \
  --namespace mysql
  
  
helm uninstall my-proxysql -n mysql

mysql -uproxysql-admin -p123456 -h192.168.56.80 -P30032

mysql -uproxysql-admin -p123456 -hmy-proxysql.mysql.svc.cluster.local -P6032
```

5、部署Adminer
```shell
kubectl apply -f adminer.yaml

kubectl delete -f adminer.yaml -n mysql


kubectl apply -f phpMyAdmin.yaml

kubectl delete -f phpMyAdmin.yaml -n mysql
```