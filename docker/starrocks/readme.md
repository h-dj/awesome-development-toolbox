1、启动虚拟
```
VBoxManage.exe list vms
"rhel64" {240f96d8-6535-431d-892e-b70f3dc464e8}

VBoxManage.exe modifyvm "rhel64" --nested-hw-virt on

VBoxManage modifyvm "vagrant_starrock_1720897896780_53741" --hwvirtex on
VBoxManage modifyvm "vagrant_starrock_1720897896780_53741" --vtxvpid on
VBoxManage modifyvm "vagrant_starrock_1720897896780_53741" --nestedpaging on
VBoxManage modifyvm "vagrant_starrock_1720897896780_53741" --largepages on

VBoxManage.exe modifyvm "vagrant_starrock_1720897896780_53741" --nested-hw-virt on
```