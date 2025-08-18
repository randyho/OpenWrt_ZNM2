#!/bin/bash

mkdir -p files/etc/nikki

GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"

wget -qO- $GEOIP_URL > files/etc/nikki/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/nikki/GeoSite.dat
