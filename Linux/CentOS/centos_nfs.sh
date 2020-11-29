#! /bin/bash
# Centos NFS  Server config
blus="\033[36m"
yellow="\033[33m"
function line() {
    echo -e "$yellow------------------------------------------------------------------------------------"
}

if [ $UID -ne 0 ]; then
    echo -e "$blue Must to be use root for exec shell."
    echo -e "$yellow Please change root user"
    exit
else
    if [ $(rpm -qa | grep rpcbind | wc -l) -ne 0 ]; then
        yum install dialog -y
        echo -e "$blue Rpcbind & nfs-utils oreadly installed"
    else
        yum install rpcbind nfs-utils dialog -y
        SYSTEM=$(rpm -q centos-release | cut -d- -f3)
        if
            [ $SYSTEM = "6" ]
        then
            service rpcbind start && service nfs start
            echo -e "$blue Rpcbind & utils install Successfully!"
        elif [ $SYSTEM = "7" ]; then
            systemctl restart rpcbind && systemctl restart nfs
            echo -e "$yellow rpcbind & utils install Successfully!"
        else
            exit
        fi
    fi
fi

line

function power() {
    cmd=(dialog --separate-output --checklist "请选择权限" 22 76 16)
    options=(
        1 "rw:可读写权限" on # any option can be set to default to "on"
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
    for choice in $choices; do
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
            U=$(whiptail --title "Test Free-form Input Box" --inputbox "Please enter the UID?" 10 60 3>&1 1>&2 2>&3)
            PROMISSION8="anonuid=$U"
            ;;
        9)
            G=$(whiptail --title "Test Free-form Input Box" --inputbox "Please enter the GID?" 10 60 3>&1 1>&2 2>&3)
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
        13)
            PROMISSION13="insecure"
            ;;
        14)
            PROMISSION14="no_wdelay"
            ;;
        esac
    done

    VAR=("$PROMISSION1","$PROMISSION2","$PROMISSION3","$PROMISSION4","$PROMISSION5","$PROMISSION6","$PROMISSION7","$PROMISSION8","$PROMISSION9","$PROMISSION10","$PROMISSION11","$PROMISSION12","$PROMISSION13","$PROMISSION14")
    array=(${VAR//,/ })
    for i in ${array[@]}; do
        echo -n "$i," >>pow.txt
    done
}

line

read -p "请输入分享目录(/home/share):" DIR
read -p "请输入允许连接的IP:" CLIENT_IP

function exports() {
    cat <<EOF >/etc/exports
# 分享目录       分享给主机(参数)
# /home/guests 192.168.22.100/24(rw,sync)
$DIR    $CLIENT_IP/24($POWERFUL)
EOF
}

if [ $DIR ]; then
    mkdir -p $DIR
    echo -e "$yellow $DIR Create Successfully!"
    line
    power
    POWERFUL=$(cat pow.txt)
    exports

    SYSTEM=$(rpm -q centos-release | cut -d- -f3)

    if [ $SYSTEM = "6" ]; then
        service iptables stop
        service rpcbind restart
        service nfs restart
        rm pow.txt
    elif [ $SYSTEM = "7" ]; then
        systemctl stop iptables
        systemctl restart rpcbind
        systemctl restart nfs
        rm pow.txt
    else
        echo -e "$blue System not supported"
        exit
    fi
fi

line

echo -e "$yellow Finsh"
