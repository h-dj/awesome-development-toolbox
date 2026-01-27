#!/bin/bash
set -e

echo "🔧 安装 NFS 相关组件..."
sudo apt update
sudo apt install -y nfs-kernel-server rpcbind nfs-common

echo "📁 创建共享目录 /opt/k3s/nfs..."
sudo mkdir -p /opt/k3s/nfs
sudo chown nobody:nogroup /opt/k3s/nfs
sudo chmod 777 /opt/k3s/nfs  # 可根据需要调整权限

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
