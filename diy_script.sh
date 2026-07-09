#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# TTYD 免登录
# sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/msd_lite
rm -rf feeds/packages/net/smartdns
# rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/luci/applications/luci-app-smartdns

# 修改本地时间格式
# sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S %A")/g' package/lean/autocore/files/*/index.htm

# 修改版本为编译日期
sed -i "s/^CONFIG_VERSION_NUMBER=.*/CONFIG_VERSION_NUMBER=\"$(date +%Y.%m.%d)\"/" .config
sed -i "s/^CONFIG_VERSION_CODE=.*/CONFIG_VERSION_CODE=\"R$(date +%Y%m%d)\"/" .config

# 修改默认主题
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 科学上网插件
git clone --depth 1 -b main https://github.com/nikkinikki-org/OpenWrt-nikki package/luci-app-nikki

# 下载geo文件
mkdir -p files/etc/nikki/run

GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
MMDB_URL="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country.mmdb"
ASN_URL="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/GeoLite2-ASN.mmdb"

wget -O files/etc/nikki/run/GeoIP.dat "$GEOIP_URL"
wget -O files/etc/nikki/run/GeoSite.dat "$GEOSITE_URL"
wget -O files/etc/nikki/run/Country.mmdb "$MMDB_URL"
wget -O files/etc/nikki/run/ASN.mmdb "$ASN_URL"

# 再次更新feeds
./scripts/feeds update -a
./scripts/feeds install -a
