#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# cp -rf ../megatron package/megatron

rm -rf feeds/luci/applications/luci-app-aria2
rm -rf feeds/packages/net/aria2
# cp -rf ../luci-app-aria2 feeds/luci/applications/luci-app-aria2
# cp -rf ../aria2 feeds/packages/net/aria2

# cp ../luciMenu.py luciMenu.py

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



# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
# sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
