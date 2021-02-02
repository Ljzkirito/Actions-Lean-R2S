#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# Add a feed source
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default

# Remove UnblockNeteaseMusicGo upx commands
sed -i "/upx/d" package/lean/UnblockNeteaseMusicGo/Makefile || true
# Add OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash package/lean/OpenClash
# Add luci-app-adguardhome
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome package/lean/luci-app-adguardhome
# Add luci-app-diskman
git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman package/lean/luci-app-diskman
mkdir package/lean/parted
cp package/lean/luci-app-diskman/Parted.Makefile package/lean/parted/Makefile
# Add luci-app-dockerman
rm -rf package/lean/luci-app-docker
git clone --depth=1 https://github.com/KFERMercer/luci-app-dockerman  package/lean/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker package/lean/luci-lib-docker
# Add luci-theme-argon
rm -rf package/lean/luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/lean/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/lean/luci-app-argon-config
