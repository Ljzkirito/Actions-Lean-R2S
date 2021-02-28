#
# Copyright (C) 2019 OpenWrt.org
#
# KFERMercer <KFER.Mercer@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=adguardhome
PKG_VERSION:=0.105.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Network-wide ads & trackers blocking DNS server
	URL:=https://github.com/AdguardTeam/AdGuardHome
endef


define Package/$(PKG_NAME)/description
Network-wide ads & trackers blocking DNS server
endef

STRIP:=true

ifeq ($(ARCH),i386)
	PKG_ARCH_ADGUARDHOME:=386
endif

ifeq ($(ARCH),x86_64)
	PKG_ARCH_ADGUARDHOME:=amd64
endif

ifeq ($(ARCH),mipsel)
	PKG_ARCH_ADGUARDHOME:=mipsle_softfloat
endif

ifeq ($(ARCH),mips)
	PKG_ARCH_ADGUARDHOME:=mips_softfloat
endif

ifeq ($(ARCH),arm64)
	PKG_ARCH_ADGUARDHOME:=arm64
endif

ifeq ($(ARCH),aarch64)
	PKG_ARCH_ADGUARDHOME:=arm64
endif

TAR_NAME:=AdGuardHome_linux_$(PKG_ARCH_ADGUARDHOME)

PKG_SOURCE:=$(TAR_NAME).tar.gz

PKG_SOURCE_URL:=https://github.com/AdguardTeam/AdGuardHome/releases/download/v$(PKG_VERSION)/

UNTAR_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)/$(PKG_NAME)-extract/$(PKG_ARCH_ADGUARDHOME)

PKG_HASH:=skip

define Build/Prepare
	mkdir -vp $(UNTAR_DIR)
	tar -zxvf $(DL_DIR)/$(PKG_SOURCE) -C $(UNTAR_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(UNTAR_DIR)/*/AdGuardHome $(1)/usr/bin/AdGuardHome
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
