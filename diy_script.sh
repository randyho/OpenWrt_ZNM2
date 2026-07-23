#!/bin/bash

echo "自定义固件版本名字"
sed -i "/^\. \/etc\/openwrt_release/a\\
sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release\n\
echo \"DISTRIB_REVISION='v\$(date +'%Y.%m.%d')'\" >> /etc/openwrt_release\n\
sed -i '/DISTRIB_RELEASE/d' /etc/openwrt_release\n\
echo \"DISTRIB_RELEASE='v\$(date +'%Y.%m.%d')'\" >> /etc/openwrt_release\n\
 sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release\n\
 echo \"DISTRIB_DESCRIPTION='AutoBuild Firmware Compiled By @waynesg Build \$(TZ=UTC-8 date \"+%Y.%m.%d\") @ OpenWrt '\" >> /etc/openwrt_release
" package/emortal/default-settings/files/99-default-settings

echo "调整网络诊断地址到www.baidu.com"
sed -i "/exit 0/d" package/emortal/default-settings/files/99-default-settings
cat <<EOF >>package/emortal/default-settings/files/99-default-settings
uci set luci.diag.ping=www.baidu.com
uci set luci.diag.route=www.baidu.com
uci set luci.diag.dns=www.baidu.com
uci commit luci
exit 0
EOF

# echo 
# TIME y "ttyd自动登录"
# sed -i "s?/bin/login?/usr/libexec/login.sh?g" feeds/packages/utils/ttyd/files/ttyd.config

echo "修改最大连接数修改为65535"
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf

echo "更换golang版本"
# rm -rf feeds/packages/lang/golang
# git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 26.x feeds/packages/lang/golang

# 修改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# TTYD 免登录
# sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 移除要替换的包
# rm -rf feeds/packages/net/mosdns
# rm -rf feeds/packages/net/msd_lite
# rm -rf feeds/packages/net/smartdns
# rm -rf feeds/luci/themes/luci-theme-argon
# rm -rf feeds/luci/themes/luci-theme-netgear
# rm -rf feeds/luci/applications/luci-app-mosdns
# rm -rf feeds/luci/applications/luci-app-netdata
# rm -rf feeds/luci/applications/luci-app-serverchan
# rm -rf feeds/luci/applications/luci-app-smartdns

# 修改版本为编译日期
sed -i "s/^CONFIG_VERSION_NUMBER=.*/CONFIG_VERSION_NUMBER=\"$(date +%Y.%m.%d)\"/" .config
sed -i "s/^CONFIG_VERSION_CODE=.*/CONFIG_VERSION_CODE=\"R$(date +%Y%m%d)\"/" .config

# 修改默认主题
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 科学上网插件
git clone --depth 1 -b main https://github.com/nikkinikki-org/OpenWrt-nikki package/luci-app-nikki
# echo "src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main" >> "feeds.conf.default"

# 下载geo文件
mkdir -p files/etc/nikki/run

GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
MMDB_URL="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country.mmdb"
ASN_URL="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/GeoLite2-ASN.mmdb"

wget -qO files/etc/nikki/run/GeoIP.dat "$GEOIP_URL"
wget -qO files/etc/nikki/run/GeoSite.dat "$GEOSITE_URL"
wget -qO files/etc/nikki/run/Country.mmdb "$MMDB_URL"
wget -qO files/etc/nikki/run/ASN.mmdb "$ASN_URL"

# 再次更新feeds
./scripts/feeds update -a
./scripts/feeds install -a
