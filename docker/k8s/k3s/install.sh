#!/bin/bash
# 强制使用 bash，避免 dash 兼容问题
set -euo pipefail

# 代理
export http_proxy="http://192.168.8.3:7899"
export https_proxy="http://192.168.8.3:7899"
export no_proxy="127.0.0.1,localhost"

echo "==============================="
echo "      K3s 一键安装脚本"
echo "  多网卡 + Flannel host-gw + 禁用 Traefik"
echo "==============================="

# 检查是否为 root
if [ "$(id -u)" -ne 0 ]; then
    echo "❌ 请用 root 用户运行此脚本！"
    exit 1
fi

# 获取网卡和对应 IPv4 地址，排除lo/docker/cni/br/veth等虚拟接口
NICS=()
echo ">>> 检测到以下网卡和 IPv4 地址："
index=1
while read -r line; do
    iface=$(echo "$line" | awk '{print $2}')
    ip=$(echo "$line" | awk '{print $4}' | cut -d'/' -f1)

    # 过滤不需要的接口
    if [[ "$iface" =~ ^(lo|docker|cni|br-|veth) ]]; then
        continue
    fi

    echo "  [$index] 网卡: $iface    IP: $ip"
    NICS+=("${iface}|${ip}")
    ((index++))
done < <(ip -4 -o addr show)

# 选择网卡
read -p "请输入要使用的网卡编号 (默认1): " choice
choice=${choice:-1}

selected="${NICS[$((choice-1))]}"
NODE_IFACE="${selected%%|*}"
NODE_IP="${selected##*|}"

echo ">>> 选择网卡: $NODE_IFACE"
echo ">>> 对应 IP: $NODE_IP"


# 节点类型选择
echo "请选择节点类型："
echo "1. Master"
echo "2. Worker"
read -p "请输入编号 (默认1): " NODE_TYPE
NODE_TYPE=${NODE_TYPE:-1}

# 镜像源（国内）
INSTALL_K3S_MIRROR=cn

# 通用参数配置
COMMON_EXEC="--node-ip=${NODE_IP} --node-external-ip=${NODE_IP} "

# Master 安装
if [ "$NODE_TYPE" = "1" ]; then
    echo ">>> 正在安装 Master 节点..."

#    curl -sfL https://rancher-mirror.rancher.cn/k3s/k3s-install.sh \
#        | INSTALL_K3S_MIRROR=${INSTALL_K3S_MIRROR} \
#          INSTALL_K3S_EXEC="${COMMON_EXEC} --advertise-address=${NODE_IP}  --flannel-iface=eth1 --flannel-backend=host-gw --disable=traefik" \
#          sh -
    curl -sfL https://get.k3s.io \
        | INSTALL_K3S_EXEC="${COMMON_EXEC} --advertise-address=${NODE_IP}  --flannel-iface=${NODE_IFACE} --flannel-backend=host-gw --disable=traefik" \
          sh -

    echo "✅ Master 节点安装完成！"
    echo "📢 Master NODE_IP：$NODE_IP"
    echo "📢 请保存以下 Node Token（供 Worker 节点加入使用）："
    cat /var/lib/rancher/k3s/server/node-token
    echo ""
    echo "📢 kubeconfig 路径：/etc/rancher/k3s/k3s.yaml"
    echo "（如需使用 kubectl，请执行： export KUBECONFIG=/etc/rancher/k3s/k3s.yaml）"

# Worker 安装
elif [ "$NODE_TYPE" = "2" ]; then
    echo ">>> 正在安装 Worker 节点..."

    read -rp "请输入 Master 节点的 IP 地址: " MASTER_IP
    read -rp "请输入 Node Token: " NODE_TOKEN

#    curl -sfL https://rancher-mirror.rancher.cn/k3s/k3s-install.sh \
#        | INSTALL_K3S_MIRROR=${INSTALL_K3S_MIRROR} \
#          K3S_URL="https://${MASTER_IP}:6443" \
#          K3S_TOKEN="${NODE_TOKEN}" \
#          INSTALL_K3S_EXEC="${COMMON_EXEC} --flannel-iface=eth1" \
#          sh -
    curl -sfL https://get.k3s.io \
        | K3S_URL="https://${MASTER_IP}:6443" \
          K3S_TOKEN="${NODE_TOKEN}" \
          INSTALL_K3S_EXEC="${COMMON_EXEC} --flannel-iface=${NODE_IFACE}" \
          sh -

    echo "✅ Worker 节点已成功加入集群！"

else
    echo "❌ 输入错误，退出安装。"
    exit 1
fi

echo "==============================="
echo "      ✅ K3s 安装完成"
echo "==============================="
