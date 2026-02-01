### 1、安装
```text
# https://github.com/prometheus-operator/kube-prometheus
kubectl create namespace dev

helm install my-monitoring prometheus-community/kube-prometheus-stack \
  -f prometheus-values.yaml \
  -n dev

helm uninstall my-monitoring -n monitoring
```