clear
uci set wireless.radio0.disabled='0'
uci set wireless.default_radio0.ssid='💕Dũng💕'
uci set wireless.default_radio0.encryption='psk2'
uci set wireless.default_radio0.key='99999999'
uci set wireless.radio1.disabled='0'
uci set wireless.default_radio1.ssid='💕Dũng💕'
uci set wireless.default_radio1.encryption='psk2'
uci set wireless.default_radio1.key='99999999'
uci commit wireless 
/etc/init.d/network restart