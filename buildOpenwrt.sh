#!/bin/bash

SRC_DIR=$(cd $(dirname $0) && pwd)
cd openwrt

# sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync


# 在源码有大规模更新或者内核更新后执行，以保证编译质量。此操作会删除/bin和/build_dir目录中的文件
# make clean


# 除非是做开发，并打算 push 到 GitHub 这样的远程仓库，否则几乎用不到。此操作相当于make dirclean外加删除/dl、/feeds目录和.config文件
# make distclean
# 还原 OpenWrt 源码到初始状态（可选）
# git clean -xdf


# 更换架构编译前必须执行。此操作会删除/bin和/build_dir目录的中的文件(make clean)以及/staging_dir、/toolchain、/tmp和/logs中的文件
# make dirclean

# # 重新配置：
# rm -rf ./tmp && rm -rf .config
# # 调整 OpenWrt 系统组件
# make menuconfig
# 如果不打算调整组件则输入make defconfig，它会检测编译环境并根据更新自动调整编译配置文件
# make defconfig
# rm -rf bin/targets/*
# 预下载编译所需的软件包
# include $(TOPDIR)/feeds/luci/luci.mk
clear
date
make download -j$(nproc)
# 检查文件完整性
# find dl -size -1024c -exec ls -l {} \;
# find dl -size -1024c -exec rm -f {} \;
echo "开始多线程编译,失败后自动进入单线程编译,失败则输出详细日志"
make -j$(nproc) || make -j1 || make -j1 V=s
# Upload firmware
fileDate=$(date +"%Y%m%d%H%M")
fileName=$(grep '^CONFIG_TARGET.*DEVICE.*=y' .config | sed -r 's/.*DEVICE_(.*)=y/\1/')
fileName=$fileName'_'$fileDate".zip"
echo $fileName
zip -j ../firmware/$fileName bin/targets/*/*/*
# zip -j /mnt/d/router/$fileName bin/targets/*/*/*