
# 方便的别名
alias ll="ls -l"

#连接vpn
alias startVPN="sudo openvpn --config /home/hdj/software/huangjiajian/client.ovpn"

#设置命令行代理
function setProxy() {
    echo "setProxy: On/off, default off"

    if [ "$1" == "On" ];then
      export http_proxy=http://192.168.8.7:7899
      export https_proxy=http://192.168.8.7:7899
    else
      unset http_proxy
      unset https_proxy
    fi
}




#拷贝文件到多个文件夹
# echo /home/xgj/test/ /home/xgj/tmp | xargs -n 1 cp -v /home/xgj/bin/sys_info.sh

