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

# Add a feed source
# sed -i '1,2d' feeds.conf.default
# sed -i '$a src-git packages https://github.com/KK2018gh/ipq6000_packages.git;1806' feeds.conf.default
# sed -i '$a src-git luci https://github.com/KK2018gh/ipq6000_luci.git;1806' feeds.conf.default

# Add luci-theme-argon
# rm -rf lede/package/lean/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-theme-argon.git
# rm -rf package/lean/luci-theme-argon/
# git clone --depth 1 -b master https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
# git clone --depth 1 -b master https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# 添加额外软件包
git clone --depth 1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash
# git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
