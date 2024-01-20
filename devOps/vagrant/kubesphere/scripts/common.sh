# 更换国内源
sudo sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
sudo sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
sudo apt clean
sudo apt-get update -y

# 安装 Docker
# 下载安装脚本并安装 Docker
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun
# 启动 Docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
# docker 镜像加速
# 获取阿里docker镜像加速器 https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors
sudo cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "registry-mirrors": [
    "https://30pma5a7.mirror.aliyuncs.com",
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ],
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

# 安装docker-compose
sudo curl  -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#授予执行权限
sudo chmod +x /usr/local/bin/docker-compose

# 安装软件
sudo apt-get install -y selinux-utils vim socat conntrack ebtables ipset chrony

# 关闭防火墙
sudo ufw disable
# 关闭 selinx
sudo setenforce 0
echo SELINUX=disabled | sudo tee -a /etc/selinux/config
# 关闭 swap
sudo swapoff -a
sudo sed -ri 's/.*swap.*/#&/' /etc/fstab

# 设置时区
sudo timedatectl set-timezone   Asia/Shanghai

# 修改root 密码
sudo echo "root:123456" | chpasswd 

# 在sshd配置文件中启用root密码登录
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
# 重启SSH服务以应用更改
sudo systemctl restart ssh
