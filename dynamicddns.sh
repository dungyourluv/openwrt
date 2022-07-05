clear
opkg install ddns-scripts ddns-scripts-noip ddns-scripts-services luci-app-ddns
uci delete ddns.myddns_ipv4
uci delete ddns.myddns_ipv6
uci set ddns.noip=service
uci set ddns.noip.service_name='no-ip.com'
uci set ddns.noip.use_ipv6='0'
uci set ddns.noip.enabled='1'
uci set ddns.noip.lookup_host='ltdhome.ddns.net'
uci set ddns.noip.domain='ltdhome.ddns.net'
uci set ddns.noip.username='teeedunn'
uci set ddns.noip.password='Lethedung@1'
uci set ddns.noip.ip_source='web'
uci set ddns.noip.ip_url='http://checkip.dyndns.com'
uci set ddns.noip.interface='wan'
uci set ddns.noip.use_syslog='2'
uci set ddns.noip.check_unit='minutes'
uci set ddns.noip.force_unit='minutes'
uci set ddns.noip.retry_unit='seconds'
uci commit ddns
/etc/init.d/ddns restart
/etc/init.d/ddns start