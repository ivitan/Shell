#! /bin/bash
# author Vitan
# DNS Configer
if [ `yum list installed | grep bind` -ne 0 ];then
yum remove bind bind-chroot || rm -rf /var/named
yum -y install bind bind-utils bind-chroot &> /dev/null
echo "Bind is installed"
else
yum -y install bind bind-utils bind-chroot &> /dev/null
echo -e "\033[32m  Installed!!!\033[0m\n"
service named start
echo -e "\033[32m Install Success!!!\033[0m\n"
fi

echo "请输入主配置文件的名字(named)"
read NAMED
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

echo "请输入正向解析域配置文件名称(vitan.me)"
read ZHENGXIANG

echo "请输入反向向解析域配置文件名称(149.28.197)"
read FANXIANG

echo -e "\033[32m 请输入反向IP(197.28.149) \033[0m\n"
read FANIP

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

echo -e "\033[32m Restart named service \022[om\n"
service named restart

echo "Cofiger resolv.conf"
cat << EOF > /etc/resolv.conf
search $$ZHENGXIANG
nameserver $FANXIANG
EOF


echo -e "\033[32m Finsh \033[0m\n"