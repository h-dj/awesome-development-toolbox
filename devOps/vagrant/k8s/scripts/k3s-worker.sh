#!/usr/bin/env bash
set -e

export http_proxy="http://192.168.8.9:7899"
export https_proxy="http://192.168.8.9:7899"
export no_proxy="127.0.0.1,localhost"

MASTER_IP=192.168.56.80
CLUSTER_TOKEN_FILE=/vagrant/k3s.token

detect_cluster_iface() {
  ip -o -4 addr show | awk '
    {
      split($4, a, "/")
      ip = a[1]
      if (ip ~ /^192\.168\.56\./) {
        print $2
        exit
      }
    }
  '
}

FLANNEL_IFACE=$(detect_cluster_iface)
NODE_IP=$(ip -4 -o addr show dev "${FLANNEL_IFACE}" \
  | awk '{print $4}' \
  | cut -d/ -f1)

echo "===> K3s worker iface=${FLANNEL_IFACE}, ip=${NODE_IP}"

########################################
# sysctl
########################################

cat <<EOF >/etc/modules-load.d/k8s.conf
br_netfilter
EOF

modprobe br_netfilter

cat <<EOF >/etc/sysctl.d/99-kubernetes.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                = 1
EOF

sysctl --system

########################################
# wait token
########################################

while [ ! -f ${CLUSTER_TOKEN_FILE} ]; do
  sleep 2
done

TOKEN=$(cat ${CLUSTER_TOKEN_FILE})

########################################
# install agent
########################################
curl -sfL https://get.k3s.io | \
K3S_URL="https://${MASTER_IP}:6443" \
K3S_TOKEN="${TOKEN}" \
INSTALL_K3S_EXEC="\
--node-ip=${NODE_IP} \
--node-external-ip=${NODE_IP} \
--flannel-iface=${FLANNEL_IFACE}" \
sh -

echo "===> K3s worker ready"
