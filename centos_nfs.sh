#! /bin/bash
# Centos NFS  Server config
color1="\e[0;31;40m"
color2="\e[0;32;40m"
color3="\e[0;33;40m"
color4="\e[0;34;40m"
color5="\e[0;35;40m"
color6="\e[0;37;40m"

function line()
{
    echo -e "$color1------------------------------------------------------------------------------------"
}

if [ $UID -ne 0 ];then
    echo -e "$color5 Must to be use root for exec shell."
    echo -e "$color5Please change root user"
    exit
else
    if [ `rpm -qa | grep rpcbind | wc -l` -ne 0 ];then
        echo -e "$color6 rpcbind & utils oredly installed"
    else
        yum install rpcbind nfs-utils -y && service rpcbind start && service nfs start
        echo -e "$color4 rpcbind & utils install Successfully!"
    fi
fi

line

function power()
{
cmd=(dialog --separate-output --checklist "请选择权限" 22 76 16)
options=(
         1 "rw:可读写权限" on   # any option can be set to default to "on"
         2 "ro:只是读权限" off
         3 "sync:同步读写硬盘" on
         4 "async:数据先暂存缓冲区，非直接写入硬盘" off
         5 "no_root_squash:用者是root,分享的目录具有root权限极不安全，不建议使用" off
         6 "root_squash:将root用户及所属用户组映射为匿名用户和用户组；" off
         7 "all_squash:将所有用户及所属用户组映射为匿名用户和用户组" off
         8 "anonuid:anon意指anonymous(匿名者)，自订匿名使用者的UID" off
         9 "anongid:自订匿名使用者的是变成GID" off
         10 "subtree_check:输出的目录是子目录，服务器将检查父目录的权限" off
         11 "no_subtree_check:输出的目录是子目录，服务器将不检查父目录的权限" off
         12 "secure:限制客户端从小于1024端口连接(默认)" off
         13 "insecure:允许从大于1024端口连接" off
         14 "no_wedlay:如有写操作,则立即执行" off
         )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            PROMISSION1="rw"
            ;;
        2)
            PROMISSION2="ro"
            ;;
        3)
            PROMISSION3="sync"
            ;;
        4)
            PROMISSION4="async"
            ;;
        5)
            PROMISSION5="no_root_squash"
            ;;
        6)
            PROMISSION6="root_squash"
            ;;
        7)
            PROMISSION7="all_squash"
            ;;
        8)
            U=$(whiptail --title "Test Free-form Input Box" --inputbox "Please enter the UID?" 10 60  3>&1 1>&2 2>&3)
            PROMISSION8="anonuid=$U"
            ;;
        9)
            G=$(whiptail --title "Test Free-form Input Box" --inputbox "Please enter the GID?" 10 60  3>&1 1>&2 2>&3)
            PROMISSION9="anongid=$G"
            ;;
        10)
            PROMISSION10="rsubtree_check"
            ;;
        11)
            PROMISSION11="no_subtree_check"
            ;;
        12)
            PROMISSION12="secure"
            ;;
        13) PROMISSION13="insecure"
            ;;
        14)
            PROMISSION14="no_wdelay"
            ;;
    esac
done

VAR=("$PROMISSION1","$PROMISSION2","$PROMISSION3","$PROMISSION4","$PROMISSION5","$PROMISSION6","$PROMISSION7","$PROMISSION8","$PROMISSION9","$PROMISSION10","$PROMISSION11","$PROMISSION12","$PROMISSION13","$PROMISSION14")
array=(${VAR//,/ }) 
for i in ${array[@]}
do 
   echo -n "$i," >> pow.txt
done
}

line

echo -e "$color3请输入分享目录(/home/share):"
read DIR
echo -e "$color3请输入允许连接的IP:"
read CLIENT_IP

function exports ()
{
cat << EOF > /etc/exports
# 分享目录       分享给主机(参数)	
# /home/guests 192.168.22.100/24(rw,sync)
$DIR    $CLIENT_IP/24($POWERFUL)
EOF
}

if [ $DIR ];then
    mkdir -p $DIR
    echo -e "$color54 $DIR Create Successfully!"
    line
    power
    POWERFUL=$(cat pow.txt)
    exports
    service iptables stop
    service rpcbind restart
    service nfs restart
    rm pow.txt
fi

line

echo -e "$color4 Finsh"