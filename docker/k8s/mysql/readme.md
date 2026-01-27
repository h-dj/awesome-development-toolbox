1、 创建 dev 命名空间（如果不存在）
kubectl create namespace dev

2、安装
kubectl apply -f mysql-standard.yaml --namespace dev

4、删除
kubectl delete -f mysql-standard.yaml --namespace dev

