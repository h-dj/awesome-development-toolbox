### 1、安装
```text
kubectl create namespace dev


#安装es 
kubectl apply -f es.yaml

#安装kibana 
kubectl apply -f kibana-pvc.yaml
kubectl apply -f kibana.yaml

# 安装fluent
kubectl apply -f fluent-bit-rbac.yaml
kubectl apply -f fluent-bit-config.yaml
kubectl apply -f fluent-bit-daemonset.yaml

# 重启
kubectl rollout restart ds fluent-bit -n dev
```

### 2、删除
```text
kubectl delete -f es-pvc.yaml
kubectl delete -f es.yaml
kubectl delete -f kibana-pvc.yaml
kubectl delete -f kibana.yaml

kubectl delete -f fluent-bit-daemonset.yaml
kubectl delete -f fluent-bit-config.yaml
kubectl delete -f fluent-bit-rbac.yaml


```

### 3、验证
```text


```