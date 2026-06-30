#!/bin/bash

mkdir -p files/etc/nikki/run

GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
MMDB_URL="https://github.com/Loyalsoldier/geoip@release/Country-without-asn.mmdb"
ASN_URL="https://github.com/Loyalsoldier/geoip@release/GeoLite2-ASN.mmdb"

wget -qO- $GEOIP_URL > files/etc/nikki/run/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/nikki/run/GeoSite.dat
wget -qO- $MMDB_URL > files/etc/nikki/run/Country.mmdb
wget -qO- $ASN_URL > files/etc/nikki/run/ASN.mmdb
