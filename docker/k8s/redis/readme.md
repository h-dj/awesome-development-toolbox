1、 创建 dev 命名空间（如果不存在）
kubectl create namespace dev

2、安装
kubectl apply -f redis-single.yaml

4、删除
kubectl delete -f redis-single.yaml