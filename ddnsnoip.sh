#!/bin/sh
install_package(){
    echo "Tiến hành cài đặt gói cấu hình ddns noip: "
    opkg install ddns-scripts ddns-scripts-noip ddns-scripts-services luci-app-ddns
}

setup_noip_basic(){
    uci delete ddns.myddns_ipv4
    uci delete ddns.myddns_ipv6
    uci set ddns.noip=service
    uci set ddns.noip.service_name='no-ip.com'
    uci set ddns.noip.use_ipv6='0'
    uci set ddns.noip.enabled='1'
    uci set ddns.noip.ip_source='web'
    uci set ddns.noip.ip_url='http://checkip.dyndns.com'
    uci set ddns.noip.interface='wan'
    uci set ddns.noip.use_syslog='2'
    uci set ddns.noip.check_unit='minutes'
    uci set ddns.noip.force_unit='minutes'
    uci set ddns.noip.retry_unit='seconds'
}

setup_info() {
    clear
    echo "Vui lòng cung cấp thông tin: "
    echo "DOMAIN: "
    read domain
    echo "User: "
    read user
    echo "Pass: "
    read pass 
    setup_noip $domain $user $pass
}

setup_noip() {
    setup_noip_basic
    uci set ddns.noip.lookup_host=$1
    uci set ddns.noip.domain=$1
    uci set ddns.noip.username=$2
    uci set ddns.noip.password=$3
    uci commit ddns
    /etc/init.d/ddns restart
    /etc/init.d/ddns start
}

start() {
    install_package
    if [ $? = 0 ]; then
        setup_info
    else
        echo "Đã xảy ra lỗi trong quá trình cài đặt gói, vui lòng thử lại"
        exit 1
    fi
}
start