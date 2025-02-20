#!/bin/bash

SRC_DIR=$(cd $(dirname $0) && pwd)
# export ALL_PROXY=socks5://127.0.0.1:1080

# 安装编译环境
# git config --global core.compression 0

# sudo apt update -y
# sudo apt full-upgrade -y
# sudo apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
#   bzip2 ccache clang cmake cpio curl device-tree-compiler ecj fastjar flex gawk gettext gcc-multilib \
#   g++-multilib git gnutls-dev gperf haveged help2man intltool lib32gcc-s1 libc6-dev-i386 libelf-dev \
#   libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses-dev libpython3-dev \
#   libreadline-dev libssl-dev libtool libyaml-dev libz-dev lld llvm lrzsz mkisofs msmtp nano \
#   ninja-build p7zip p7zip-full patch pkgconf python3 python3-pip python3-ply python3-docutils \
#   python3-pyelftools qemu-utils re2c rsync scons squashfs-tools subversion swig texinfo uglifyjs \
#   upx-ucl unzip vim wget xmlto xxd zlib1g-dev zstd

# cp -rf /mnt/d/router/* ./
# rm -rf openwrt


# git clone -b openwrt-21.02 https://github.com/openwrt/openwrt
# git clone -b openwrt-23.05 https://github.com/openwrt/openwrt

# git clone -b openwrt-24.10 https://github.com/openwrt/openwrt

cd openwrt


# netdata

# sed -i 's/dnsmasq /dnsmasq-full blockd libopenssl-legacy libopenssl-conf zerotier kmod-fs-cifs kmod-nls-utf8 luci luci-app-argon-config luci-app-aria2 luci-app-vlmcsd/g' include/target.mk


# 带USB的路由器
# sed -i 's/ppp-mod-pppoe/ppp-mod-pppoe vsftpd kmod-fs-exfat kmod-fs-ext4 kmod-fs-vfat kmod-usb-storage kmod-usb2 kmod-usb3 luci-app-hd-idle luci-app-samba4/g' include/target.mk


# sed -i 's/dnsmasq/dnsmasq-full luci/g' include/target.mk




./scripts/feeds update -a


./scripts/feeds install -a





# sed -i 's/tools-y +=.*sstrip/& ucl upx/g' tools/Makefile
# sed -i 'N;40a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile

# openwrt
# echo "src-git Megatron https://github.com/jakiro6709/Megatron.git" >> "feeds.conf.default"
# echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"
# echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"

# git clone https://github.com/jakiro6709/Megatron.git package/Megatron
# sed -i 's/dnsmasq/dnsmasq-full blockd default-settings netdata kmod-fs-cifs kmod-nls-utf8 zerotier/g' include/target.mk
# sed -i 's/ppp-mod-pppoe/ppp-mod-pppoe luci luci-app-argon-config luci-app-aria2 luci-app-ddns luci-app-nlbwmon luci-app-upnp luci-app-vlmcsd/g' include/target.mk
# sed -i 's/ppp-mod-pppoe/ppp-mod-pppoe block-mount blockd default-settings  kmod-fs-cifs kmod-nls-utf8 kmod-fs-exfat kmod-fs-ext4 zerotier luci luci-app-argon-config luci-app-aria2 luci-app-vlmcsd/g' include/target.mk








# # Modify default IP
# sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
# # 修改material为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
# # sed -i 's/luci-theme-bootstrap/luci-theme-material +@LUCI_LANG_zh_Hans/g' feeds/luci/collections/luci/Makefile
# # 开启wifi
# # sed -i '/set wireless.*disabled=1/d' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# chmod +x luciMenu.py
# python3 luciMenu.py
# rm -rf luciMenu.py


# sed -i 's/option enabled 0/option enabled 1/g' /etc/config/zerotier
# sed -i 's/8056c2e21c000001/233ccaac275dbd40/g' /etc/config/zerotier
# /etc/init.d/zerotier start
# 内核错误
# sed -i 's/5.4.188-1-e10b6f43ee178ece2640b2c478f3c8d9/5.4.188-1-95238bfd570012d05891b8156dec4a28/g' /usr/lib/opkg/status
# 如果需要重新配置：
# rm -rf ./tmp && rm -rf .config
# 
# make -j8 download V=s
# make -j$(nproc) V=s

# 输入 make -j1 V=s （-j1 后面是线程数。第一次编译推荐用单线程）即可开始编译你要的固件了。


# make -j$(($(nproc) + 1)) V=s
# 编译完成后输出路径：bin/targets

#磁盘映射
# Base system -->block-mount/blockd
# Kernel modules --> Filesystem -->kmod-fs-cifs
# Kernel modules --> Native Language Support -->kmod-nls-utf-8
# mount -t cifs //192.168.5.2/sda1 /mnt/sda1 -o user=,iocharset=utf8,file_mode=0777,dir_mode=0777
# mount -t cifs //192.168.5.2/sda1 /mnt/sda1 -o user=,iocharset=utf8,file_mode=0777,dir_mode=0777,vers=1.0
# 官方源代码编译OpenWrt，和USB相关的编译选项：
# luci-app-aria2/hd-idle/samba
# USB挂载：
# Base system -->block-mount/blockd
# Kernel modules --> Filesystem -->kmod-fs-ext4
# Kernel modules --> USB Support -->kmod-usb-storage/kmod-usb2/kmod-usb3
# mount -t cifs //192.168.50.1/sda1 /mnt/sda1 -o user=,file_mode=0777,dir_mode=0777,vers=1.0




# find dl -size -1024c -exec ls -l {} \;
# find dl -size -1024c -exec rm -f {} \;