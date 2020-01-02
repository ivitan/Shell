#! /bin/bash
# author Vitan
# DNS Configer

blue="\033[36m"
yellow="\033[33m"

color1="\e[0;31;40m"
color2="\e[0;32;40m"
color3="\e[0;33;40m"
color4="\e[0;34;40m"
color5="\e[0;35;40m"
color6="\e[0;37;40m"

function logo()
{
    echo -e "$yellow
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                  _oo0oo_
                                 088888880
                                 88" . "88
                                 (| -_- |)
                                  0\ = /0
                               ___/'---'\___
                             .' \\\\|     |// '.
                            / \\\\|||  :  |||// \\
                           /_ ||||| -:- |||||- \\
                          |   | \\\\\\  -  /// |   |
                          | \_|  ''\---/''  |_/ |
                          \  .-\__  '-'  __/-.  /
                        ___'. .'  /--.--\  '. .'___
                     ."" '<  '.___\_<|>_/___.' >'  "".
                    | | : '-  \'.;'\ _ /';.'/ - ' : | |
                    \  \ '_.   \_ __\ /__ _/   .-' /  /
                ====='-.____'.___ \_____/___.-'____.-'=====
                                  '=---='
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        佛祖保佑    iii    永无 Bug
    "
}

function line()
{
    echo -e "$blue ----------------------------------------------------------------------"
}

logo
line

if [ `rpm -qa | grep bind | wc -l` -ne 0 ];then
    yum install bind-chroot -y &> /dev/null
    echo -e "$blue Bind is installed"
else
    yum  install bind bind-utils bind-chroot -y &> /dev/null
    echo -e "$yellow  Installed!!!"
    
    SYSTEM=`rpm -q centos-release|cut -d- -f3`
    if
    [ $SYSTEM = "6" ];then
        service named start
        echo -e "$blue Install Success!!!"
        elif [ $SYSTEM = "7" ];then
        systemctl start named
        echo -e "$blue Install Success!!!"
    else
        echo -e "$yellow System not supported"
        exit
    fi
fi

line

read -p "请输入主配置文件的名字(named)" NAMED
if [ $NAMED ];then
cat << EOF > /var/named/chroot/etc/named.conf
options {
        listen-on port 53 { any; };# 监听任何ip对53端口的请求
        listen-on-v6 port 53 { ::1; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        allow-query     { any; }; # 接收任何来源查询dns记录
        recursion yes;

        dnssec-enable yes;
        dnssec-validation yes;

        /* Path to ISC DLV key */
        bindkeys-file "/etc/named.iscdlv.key";

        managed-keys-directory "/var/named/dynamic";
};

//以下用于限定 bind 服务器的日志参数
logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

//用于指定根服务器的配置信息，一般不能改动
zone "." IN {
        type hint;
        file "named.ca";
};

include "/etc/$NAMED.zones"; //指定住配置文件，按实际改动
include "/etc/named.root.key";
EOF
fi

line

read -p "请输入正向解析域配置文件名称(vitan.me)" ZHENGXIANG
read -p "请输入反向向解析域配置文件名称(149.28.197)" FANXIANG
read -p "请输入反向IP(197.28.149)" FANIP

if [ $ZHENGXIANG  ];then
    cd /var/named/chroot/etc/
    cp -p named.rfc1912.zones $NAMED.zones
cat << EOF > $NAMED.zones
zone "$ZHENGXIANG" IN {
        type master;
        file "$ZHENGXIANG.zone";
        allow-update { none; };
};

zone "$FANIP.in-addr.arpa" IN {
        type master;
        file "$FANXIANG.zone";
        allow-update { none; };
};
EOF
fi

line

cd /var/named/chroot/var/named
cp -p named.localhost $ZHENGXIANG.zone

if [ $ZHENGXIANG.zone ];then
cat << EOF > $ZHENGXIANG.zone
\$TTL 1D
@       IN SOA  www.$ZHENGXIANG. mail.$ZHENGXIANG.me. (
                2007101100      ; serial
                1D      ; refresh # 主从刷新时间
                1H      ; retry # 主从通讯失败后重试间隔
                1W      ; expire # 缓存过期时间
                3H )    ; minimum # 没有TTL定义时的最小生存周期

@       IN      NS              www.$ZHENGXIANG.
@       IN      MX      10      www.$ZHENGXIANG.
www     IN      A               $FANXIANG.1
mail    IN      A               $FANXIANG.1
www1    IN      CNAME           www.$ZHENGXIANG.
EOF
fi

line

cd /var/named/chroot/var/named
cp -p named.loopback $FANXIANG.zone

if [ $FANXIANG.zone ];then
cat << EOF > $FANXIANG.zone
\$TTL 1D
@       IN SOA  www.$ZHENGXIANG. mail.$ZHENGXIANG.me. (
                2007101100      ; serial
                1D      ; refresh # 主从刷新时间
                1H      ; retry # 主从通讯失败后重试间隔
                1W      ; expire # 缓存过期时间
                3H )    ; minimum # 没有TTL定义时的最小生存周期

@       IN      NS              www.$ZHENGXIANG.
@       IN      MX      10      www.$ZHENGXIANG.

www     IN      A               $FANXIANG.1
mail    IN      A               $FANXIANG.1
www1    IN      CNAME           www.$ZHENGXIANG.
EOF
fi

line

echo -e "$blue  Restart named service"

SYSTEM=`rpm -q centos-release|cut -d- -f3`
if
[ $SYSTEM = "6" ] ; then
    service named restart
    elif [ $SYSTEM = "7" ] ; then
    systemctl restart named
else
    echo -e "$Blue  System not supported"
    exit
fi

line

echo -e "$yellow Cofiger resolv.conf"
cat << EOF > /etc/resolv.conf
search $ZHENGXIANG
nameserver $FANXIANG
EOF

line
echo -e "$blue Finsh"
