#!/bin/bash

echo "Stopping K3s services..."

# 停止 systemd 服务
if systemctl is-active --quiet k3s; then
    systemctl stop k3s
    systemctl disable k3s
elif systemctl is-active --quiet k3s-agent; then
    systemctl stop k3s-agent
    systemctl disable k3s-agent
fi

echo "Running official uninstall script if exists..."

# 官方自带卸载脚本
if [ -f /usr/local/bin/k3s-uninstall.sh ]; then
    /usr/local/bin/k3s-uninstall.sh
fi
if [ -f /usr/local/bin/k3s-agent-uninstall.sh ]; then
    /usr/local/bin/k3s-agent-uninstall.sh
fi

echo "Removing residual files..."

# 手动清理（可选，根据你情况）
rm -rf /etc/rancher/k3s
rm -rf /var/lib/rancher/k3s
rm -rf /var/lib/kubelet
rm -rf /etc/systemd/system/k3s*
rm -rf /etc/systemd/system/k3s-agent*
rm -rf /var/lib/cni/
rm -rf /opt/cni/
rm -rf /var/lib/containerd/
rm -rf /var/lib/longhorn/   # 如果用 longhorn 存储也可以清掉

echo "K3s Uninstalled Successfully!"
