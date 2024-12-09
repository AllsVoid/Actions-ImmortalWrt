# 请在下方输入自定义命令(一般用来安装第三方插件)(可以留空)
# Please enter the custom command below (usually used to install third-party plugins) (can be left blank)
# git clone --depth=1 https://github.com/EOYOHOO/UA2F.git package/UA2F
# git clone --depth=1 https://github.com/EOYOHOO/rkp-ipid.git package/rkp-ipid
# 设置默认登录 IP
CONFIG_GENERATE="package/base-files/files/bin/config_generate"
sed -i 's/192.168.1.1/192.168.5.1/g' $CONFIG_GENERATE

# 修改主机名
sed -i "s/hostname='OpenWrt'/hostname='YKOP'/g" $CONFIG_GENERATE

# 修改网口配置
NETWORK_CONFIG="target/linux/generic/base-files/etc/board.d/02_network"
sed -i 's/ucidef_set_interface_lan "eth0"/ucidef_set_interface_lan "eth1 eth2 eth3"/g' $NETWORK_CONFIG
sed -i 's/ucidef_set_interface_wan "eth1"/ucidef_set_interface_wan "eth0"/g' $NETWORK_CONFIG

# 预设 Wi-Fi 名称和密码
WIFI_CONFIG="package/kernel/mac80211/files/lib/wifi/mac80211.sh"
sed -i 's/set wireless.default_radio${devidx}.ssid=/# set wireless.default_radio${devidx}.ssid=/g' $WIFI_CONFIG
echo '        set wireless.default_radio${devidx}.ssid="YKOP"' >> $WIFI_CONFIG
echo '        set wireless.default_radio${devidx}.key="wifi@WKY_0220"' >> $WIFI_CONFIG
echo '        set wireless.default_radio${devidx}.encryption="psk2"' >> $WIFI_CONFIG
echo "Custom configurations applied."

git clone https://github.com/gngpp/luci-theme-design.git  package/luci-theme-design
./scripts/feeds update -a && rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
./scripts/feeds install -a