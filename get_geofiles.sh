#!/bin/bash
set -e

mkdir -p files/etc/nikki/run

GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
MMDB_URL="https://github.com/Loyalsoldier/geoip/releases/latest/download/Country-without-asn.mmdb"
ASN_URL="https://github.com/Loyalsoldier/geoip/releases/latest/download/GeoLite2-ASN.mmdb"

wget -O files/etc/nikki/run/GeoIP.dat "$GEOIP_URL"
wget -O files/etc/nikki/run/GeoSite.dat "$GEOSITE_URL"
wget -O files/etc/nikki/run/Country.mmdb "$MMDB_URL"
wget -O files/etc/nikki/run/ASN.mmdb "$ASN_URL"

