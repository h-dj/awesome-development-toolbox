#!/usr/bin/env bash
set -e

echo "===> Ubuntu 22.04 init start"
echo "===> Switch APT mirror to Aliyun (Jammy)"

sed -i 's|http://archive.ubuntu.com|https://mirrors.aliyun.com|g' /etc/apt/sources.list
sed -i 's|http://security.ubuntu.com|https://mirrors.aliyun.com|g' /etc/apt/sources.list

########################################
# 基础配置
########################################

# 代理（如不需要可注释）
export http_proxy="http://192.168.8.9:7899"
export https_proxy="http://192.168.8.9:7899"
export no_proxy="127.0.0.1,localhost,mirrors.aliyun.com"

# 时区
timedatectl set-timezone Asia/Shanghai

# 关闭 swap（K8s 必须）
swapoff -a
sed -ri 's/.*swap.*/#&/' /etc/fstab

########################################
# APT 初始化
########################################

apt clean
apt update -y

apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  software-properties-common

########################################
# 常用工具 & 构建依赖
########################################

apt install -y \
  build-essential \
  gcc \
  make \
  llvm \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  libffi-dev \
  liblzma-dev \
  uuid-dev \
  tk-dev \
  xz-utils \
  libncursesw5-dev \
  libxml2-dev \
  libxmlsec1-dev \
  wget \
  vim \
  nfs-common \
  socat \
  conntrack \
  ebtables \
  ipset \
  chrony

########################################
# Docker 安装（Ubuntu 22.04 官方方式）
########################################

echo "===> Install Docker"

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update -y
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

########################################
# Docker 配置
########################################

mkdir -p /etc/docker

tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "registry-mirrors": [
    "https://dockerproxy.net"
  ],
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  },
  "insecure-registries": ["192.168.56.200:5000"]
}
EOF

systemctl daemon-reload
systemctl enable docker
systemctl restart docker

usermod -aG docker $USER

########################################
# SSH & Root（Vagrant / 内网）
########################################

echo "===> Configure SSH"

echo "root:123456" | chpasswd  || true

# 使用 drop-in 覆盖 cloud-init / cloudimg 默认配置
cat <<EOF > /etc/ssh/sshd_config.d/99-force-password.conf
PermitRootLogin yes
PasswordAuthentication yes
PubkeyAuthentication yes
EOF
# 重启 SSH（Ubuntu 22.04 服务名是 ssh）
systemctl restart ssh

########################################
# 防火墙
########################################

ufw disable || true
# Ubuntu 无 SELinux
# setenforce 0

########################################
# 验证
########################################

docker --version || true
docker compose version || true

echo "===> Init finished. Re-login recommended."
