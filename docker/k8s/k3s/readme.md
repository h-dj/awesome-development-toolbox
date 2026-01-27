1、安装
```shell

chmod +x install.sh
sudo ./install.sh
```

2、重启
```shell
systemctl daemon-reload
systemctl restart k3s

sudo systemctl restart k3s-agent
```

3、配置镜像
```shell

sudo mkdir -p /etc/rancher/k3s

sudo tee /etc/rancher/k3s/registries.yaml > /dev/null <<EOF
mirrors:
  "docker.io":
    endpoint:
      - "https://dockerproxy.net"
  "quay.io":
    endpoint:
      - "https://quay.dockerproxy.net"
  "ghcr.io":
    endpoint:
      - "https://ghcr.dockerproxy.net"
  "k8s.gcr.io":
    endpoint:
      - "https://k8s.dockerproxy.net"
  "gcr.io":
    endpoint:
      - "https://gcr.dockerproxy.net"
EOF

systemctl restart k3s-agent
#systemctl restart k3s
```

4、配置k3s集群
```shell
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
source ~/.bashrc
```

5、安装helm 
```shell
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

6、 NFS server 
```shell
#!/bin/bash
set -e

echo "🔧 安装 NFS 相关组件..."
sudo apt update
sudo apt install -y nfs-kernel-server rpcbind nfs-common

echo "📁 创建共享目录 /srv/nfs/k8s..."
sudo mkdir -p /opt/k3s/nfs
sudo chown nobody:nogroup /opt/k3s/nfs
sudo chmod 777 /srv/nfs/k8s  # 可根据需要调整权限

echo "📝 配置 /etc/exports..."
EXPORT_LINE="/opt/k3s/nfs *(rw,sync,no_subtree_check,no_root_squash)"
if ! grep -qF "$EXPORT_LINE" /etc/exports; then
  echo "$EXPORT_LINE" | sudo tee -a /etc/exports
fi

echo "📡 重载并启动 NFS 服务..."
sudo exportfs -ra
sudo systemctl enable rpcbind nfs-server
sudo systemctl restart rpcbind nfs-server

echo "✅ NFS 服务已安装并共享目录 /opt/k3s/nfs"
```

7、安装 metallb
```shell
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
# kubectl create namespace metallb-system
# kubectl apply -f metallb-config.yaml

apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: ip-pool
  namespace: metallb-system
spec:
  addresses:
    - 192.168.56.230-192.168.56.255
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: layer2
  namespace: metallb-system

```