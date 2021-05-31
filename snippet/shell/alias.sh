
# 方便的别名
alias ll="ls -l"

#连接vpn
alias startVPN = "sudo openvpn --config /etc/openvpn/huangjiajian/client.ovpn"

#设置命令行代理
function setProxy() {
    echo "setProxy: On/off, default off"

    if [ "$1" == "On" ];then
      export http_proxy=http://127.0.0.1:8889
      export https_proxy=http://127.0.0.1:8889
    else
      unset http_proxy
      unset https_proxy
    fi
}


