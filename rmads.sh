#!/bin/sh
clear
opkg update
service adguardhome stop
service adguardhome disable
opkg remove adguardhome
 
# 1. Reverts AdGuard Home configuration and resets settings to default.
# 2. Enable rebind protection.
# 3. Remove DHCP options for IPv4 and IPv6 
uci -q delete dhcp.@dnsmasq[0].noresolv
uci -q delete dhcp.@dnsmasq[0].cachesize
uci set dhcp.@dnsmasq[0].rebind_protection='1'
uci -q delete dhcp.@dnsmasq[0].server
uci -q delete dhcp.@dnsmasq[0].port
uci -q delete dhcp.lan.dhcp_option
uci -q delete dhcp.lan.dns
 
# Network Configuration
# Disable peer/ISP DNS
uci set network.wan.peerdns="0"
uci set network.wan6.peerdns="0"
 
# Configure DNS provider to Google DNS
uci -q delete network.wan.dns
uci add_list network.wan.dns="8.8.8.8"
uci add_list network.wan.dns="8.8.4.4"
 
# Configure IPv6 DNS provider to Google DNS
uci -q delete network.wan6.dns
uci add_list network.wan6.dns="2001:4860:4860::8888"
uci add_list network.wan6.dns="2001:4860:4860::8844"
 
# Save and apply
uci commit dhcp
uci commit network
/etc/init.d/network restart
/etc/init.d/dnsmasq restart
/etc/init.d/odhcpd restart