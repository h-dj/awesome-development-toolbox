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

echo "===> K3s master iface=${FLANNEL_IFACE}, ip=${NODE_IP}"

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
# Install K3s server
########################################

curl -sfL https://get.k3s.io | \
INSTALL_K3S_EXEC="\
--node-ip=${NODE_IP} \
--node-external-ip=${NODE_IP} \
--advertise-address=${NODE_IP} \
--tls-san=${MASTER_IP} \
--flannel-backend=host-gw \
--flannel-iface=${FLANNEL_IFACE} \
--disable=traefik \
--write-kubeconfig-mode=644" \
sh -

until kubectl get nodes >/dev/null 2>&1; do
  sleep 2
done

cp /var/lib/rancher/k3s/server/node-token ${CLUSTER_TOKEN_FILE}
chmod 644 ${CLUSTER_TOKEN_FILE}

echo "===> K3s master ready"
