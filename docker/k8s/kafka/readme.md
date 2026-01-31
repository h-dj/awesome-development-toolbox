### 1、install 
```text
kubectl create namespace dev

安装 strimzi 的operator
kubectl apply -n dev \
  -f https://strimzi.io/install/latest?namespace=dev

删除 strimzi 的operator
kubectl delete -n dev \
  -f https://strimzi.io/install/latest?namespace=dev


# 1. 确保之前的 Kafka 已删除
kubectl delete kafka kafka-cluster -n dev --ignore-not-found

# 2. 删除 NodePool（如果存在）
kubectl delete kafkanodepool kafka-role -n dev --ignore-not-found

# 3. 删除 Kafka PVC
kubectl delete pvc -n dev -l strimzi.io/cluster=my-cluster

# 4. 重新创建
kubectl delete -f kafka.yaml
kubectl apply -f kafka.yaml
```

### 2、观察
```text
kubectl get kafkanodepool -n dev
kubectl get kafka -n dev
kubectl get pods -n dev
```


### 3、安装 kafka-console-ui.yaml
```text
kubectl delete -f kafka-console-ui.yaml
kubectl apply -f kafka-console-ui.yaml
```