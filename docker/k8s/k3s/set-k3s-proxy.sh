#!/bin/bash
# 替换或清理 K3s master/agent 的代理配置（自动备份）
# 用法：
#   ./set-k3s-proxy.sh [master|agent|all] clear
#   ./set-k3s-proxy.sh [master|agent|all] http://192.168.8.3:7899

TYPE="$1"
ACTION="$2"

if [[ -z "$TYPE" || -z "$ACTION" ]]; then
  echo "❌ 用法: $0 [master|agent|all] [clear|http://proxy:port]"
  exit 1
fi

# 根据类型定义文件列表
FILES=()
if [[ "$TYPE" == "master" ]]; then
  FILES+=("/etc/systemd/system/k3s.service.env")
elif [[ "$TYPE" == "agent" ]]; then
  FILES+=("/etc/systemd/system/k3s-agent.service.env")
elif [[ "$TYPE" == "all" ]]; then
  FILES+=("/etc/systemd/system/k3s.service.env" "/etc/systemd/system/k3s-agent.service.env")
else
  echo "❌ 类型必须是 master/agent/all"
  exit 1
fi

for ENV_FILE in "${FILES[@]}"; do
  if [ -f "$ENV_FILE" ]; then
    BACKUP_FILE="${ENV_FILE}.$(date +%Y%m%d%H%M%S).bak"
    echo "📦 备份 $ENV_FILE -> $BACKUP_FILE"
    sudo cp "$ENV_FILE" "$BACKUP_FILE"

    # 清理旧代理
    sudo sed -i '/http_proxy/d;/https_proxy/d;/no_proxy/d' "$ENV_FILE"

    # 设置新代理
    if [[ "$ACTION" != "clear" ]]; then
      echo "🌐 设置代理为: $ACTION"
      {
        echo "http_proxy='$ACTION'"
        echo "https_proxy='$ACTION'"
        echo "no_proxy='127.0.0.1,localhost,10.0.0.0/8,192.168.0.0/16,.svc,.cluster.local,dockerproxy.net'"
      } | sudo tee -a "$ENV_FILE" > /dev/null
    else
      echo "🧹 已清理代理配置"
    fi
  else
    echo "⚠️ 文件不存在: $ENV_FILE"
  fi
done

# 重载 systemd
echo "🔄 重载 systemd..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

# 重启服务
for ENV_FILE in "${FILES[@]}"; do
  SERVICE=$(basename "$ENV_FILE" .service.env)
  echo "🚀 重启 $SERVICE..."
  sudo systemctl restart "$SERVICE"
done

echo "✅ 完成，当前代理状态："
for ENV_FILE in "${FILES[@]}"; do
  SERVICE=$(basename "$ENV_FILE" .service.env)
  systemctl show "$SERVICE" | grep -i proxy
done
