### 1、安装
```text
helm repo add ygqygq2 https://ygqygq2.github.io/charts/
helm repo update


helm install my-nacos ygqygq2/nacos  -f nacos-values.yaml -n dev


helm uninstall my-nacos -n dev
```