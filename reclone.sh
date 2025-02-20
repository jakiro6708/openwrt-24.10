#!/bin/bash

SRC_DIR=$(cd $(dirname $0) && pwd)


# export ALL_PROXY=socks5://127.0.0.1:1080



rm -rf openwrt
cp -rf lede openwrt
cp -rf megatron openwrt/package/megatron


rm -rf openwrt/feeds/luci/applications/luci-app-aria2
rm -rf openwrt/feeds/packages/net/aria2
cp -rf luci-app-aria2 openwrt/feeds/luci/applications/luci-app-aria2
cp -rf aria2 openwrt/feeds/packages/net/aria2




cp luciMenu.py openwrt/luciMenu.py

cd openwrt
# sed -i 's/dnsmasq/dnsmasq-full luci/g' include/target.mk
# netdata

sed -i 's/dnsmasq /dnsmasq-full blockd libopenssl-legacy libopenssl-conf zerotier kmod-fs-cifs kmod-nls-utf8 luci luci-app-argon-config luci-app-aria2 luci-app-vlmcsd/g' include/target.mk


# 带USB的路由器
sed -i 's/ppp-mod-pppoe/ppp-mod-pppoe vsftpd kmod-fs-exfat kmod-fs-ext4 kmod-fs-vfat kmod-usb-storage kmod-usb2 kmod-usb3 luci-app-hd-idle luci-app-samba4/g' include/target.mk





chmod +x luciMenu.py
python3 luciMenu.py
rm -rf luciMenu.py



# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

cat feeds/luci/modules/luci-base/root/usr/share/luci/menu.d/luci-base.json
ls feeds/luci/applications/luci-app-aria2
ls feeds/packages/net/aria2
# 修改默认软件

#带USB的路由器
# sed -i 's/+luci-light /+luci-light +blockd +libopenssl-legacy +libopenssl-conf +zerotier +kmod-fs-cifs +kmod-nls-utf8 +luci-app-argon-config +luci-app-aria2 +luci-app-vlmcsd +kmod-fs-exfat +kmod-fs-ext4 +kmod-fs-vfat +kmod-usb-storage +kmod-usb2 +kmod-usb3 +vsftpd +luci-app-hd-idle +luci-app-samba4/g' feeds/luci/collections/luci/Makefile

#普通路由器
# sed -i 's/+luci-light /+luci-light +blockd +libopenssl-legacy +libopenssl-conf +zerotier +kmod-fs-cifs +kmod-nls-utf8 +luci-app-argon-config +luci-app-aria2 +luci-app-vlmcsd/g' feeds/luci/collections/luci/Makefile


make menuconfig



# sed -i 's/luci-theme-bootstrap/luci-theme-material +@LUCI_LANG_zh_Hans/g' feeds/luci/collections/luci/Makefile
# 开启wifi
# sed -i '/set wireless.*disabled=1/d' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# echo '95238bfd570012d05891b8156dec4a28' > vermagic
# sed -i 's/grep.*vermagic/cp \$(TOPDIR)\/vermagic $(LINUX_DIR)\/\.vermagic/g' include/kernel-defaults.mk
# sed -i 's/shell .*mkhash md5/shell cat $(LINUX_DIR)\/\.vermagic/g' package/kernel/linux/Makefile


#WARNING: Applying padding in /home/asus/openwrt/bin/packages/aarch64_cortex-a53/packages/Packages to workaround usign SHA-512 bug!
# 6.1. 软件包编译
# 接下来我们以luci的主题包luci-theme-openwrt-2020为例。输入以下命令

# #在menuconfig中勾选要编译的包
# make menuconfigturbine

# #清除已有的编译文件
# make package/luci-theme-openwrt-2020/clean V=s

# #解压源码，本地没有的话会自动下载
# make package/luci-theme-openwrt-2020/prepare V=s

# #进行编译
# make package/luci-theme-openwrt-2020/compile V=s
