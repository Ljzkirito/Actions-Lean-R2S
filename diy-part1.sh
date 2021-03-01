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
#sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default

#关机（增加关机功能）
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/lean/luci-app-poweroff
# 获取luci-app-passwall以及缺失的依赖
pushd package/lean
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng
popd
# 使用官方ppp
rm -rf package/network/services/ppp
svn co https://github.com/openwrt/openwrt/trunk/package/network/services/ppp package/network/services/ppp
# Remove upx commands
sed -i "/upx/d" package/lean/UnblockNeteaseMusicGo/Makefile || true
sed -i "/upx/d" package/lean/frp/Makefile || true
sed -i "/upx/d" package/lean/trojan-go/Makefile || true
sed -i "/upx/d" package/lean/v2ray-plugin/Makefile || true
# Add OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash package/lean/OpenClash
# Add luci-app-adguardhome
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome package/lean/luci-app-adguardhome
#svn co https://github.com/Lienol/openwrt-packages/trunk/net/adguardhome package/lean/adguardhome
#svn co https://github.com/Lienol/openwrt-packages/trunk/devel/packr package/lean/packr
mv $GITHUB_WORKSPACE/adguardhome $GITHUB_WORKSPACE/openwrt/package/lean
# Add luci-app-diskman
#git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman package/lean/luci-app-diskman
#mkdir package/lean/parted
#cp package/lean/luci-app-diskman/Parted.Makefile package/lean/parted/Makefile
# Add luci-app-dockerman
rm -rf package/lean/luci-app-docker package/lean/luci-lib-docker
git clone --depth=1 https://github.com/KFERMercer/luci-app-dockerman  package/lean/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker package/lean/luci-lib-docker
# Add luci-theme-argon
rm -rf package/lean/luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/lean/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/lean/luci-app-argon-config
#Remove default apps
sed -i 's/luci-app-zerotier//g' target/linux/rockchip/Makefile
sed -i 's/luci-app-vsftpd //g' include/target.mk
sed -i 's/luci-app-unblockmusic //g' include/target.mk
sed -i 's/luci-app-vlmcsd //g' include/target.mk
sed -i 's/luci-app-sfe //g' include/target.mk
sed -i 's/luci-app-nlbwmon //g' include/target.mk
sed -i 's/luci-app-accesscontrol //g' include/target.mk
#交换Lan Wan 接口
sed -i 's/wan\" \"eth0/wan\" \"eth1/g' target/linux/rockchip/armv8/base-files/etc/board.d/01_leds
sed -i 's/lan\" \"eth1/lan\" \"eth0/g' target/linux/rockchip/armv8/base-files/etc/board.d/01_leds
sed -i "s/eth1' 'eth0/eth0' 'eth1/g" target/linux/rockchip/armv8/base-files/etc/board.d/02_network

# Auto Update Adguardhome
latest_ver="$(curl -L -k --retry 2 --connect-timeout 20 -o - https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest 2>/dev/null|grep -E 'tag_name' |grep -E '[0-9.]+' -o 2>/dev/null)"
echo -e "Adguardhome cloud version: ${latest_ver}." 
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=${latest_ver}/g" package/lean/adguardhome/Makefile
