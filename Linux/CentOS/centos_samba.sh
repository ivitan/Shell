#! /bin/bash
blue="\033[36m"
yellow="\033[33m"

function logo() {
    echo -e "$yellow
   ______           __  ____  _____ _____    _____ ___    __  _______  ___
  / ____/__  ____  / /_/ __ \/ ___// ___/   / ___//   |  /  |/  / __ )/   |
 / /   / _ \/ __ \/ __/ / / /\__ \/ __ \    \__ \/ /| | / /|_/ / __  / /| |
/ /___/  __/ / / / /_/ /_/ /___/ / /_/ /   ___/ / ___ |/ /  / / /_/ / ___ |
\____/\___/_/ /_/\__/\____//____/\____/   /____/_/  |_/_/  /_/_____/_/  |_|
    "
}

function line() {
    echo -e "$blue ------------------------------------------------------------------"
}

function check_samba() {
    if [ $UID -ne 0 ]; then
        echo -e "$yellow Must to be use root for exec shell."
        echo -e "$yellow Please change root user"
        exit
    else
        yum install samba samba-client -y &>/dev/null
        echo -e "$yellow Samba installed successfully"
    fi
}

function anyone() {
    read -p "请输入要分享的目录名(/share)" DIR
    mkdir $DIR
    chmod 777 $DIR
    mv /etc/samba/smb.conf /etc/samba/smb.conf.bak

    cat <<EOF >/etc/samba/smb.conf
    [global]
            workgroup = WORKGROUP
            server string = Samba Server Version %v
            security = share
            passdb backend = tdbsam
            load printers = yes
            cups options = raw

    [share]
        comment = share for users
        path = /$DIR
        browseable = yes
        writable = yes
        public = no

    [printers]
            comment = All Printers
            path = /var/spool/samba
            browseable = no
            guest ok = no
            writable = no
            printable = yes
EOF
    service smb start
}

function adduser() {
    read -p "请输入组名" GROUP
    groupadd $GROUP
    read -p "请输入要创建的用户名" NAME
    useradd -g $GROUP $NAME
    echo -e "$blue 设置密码"
    echo
    passwd $NAME
    line
    echo -e "$blue 设置samba账号密码"
    smbpasswd -a $NAME
}

function mima() {
    read -p "请输入要分享的目录名(/share)" DIR
    mkdir $DIR
    chmod 777 $DIR
    mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
    adduser

    cat <<EOF >/etc/samba/smb.conf
    [global]
        workgroup = WORKGROUP
        server string = Samba Server Version %v

        log file = /var/log/samba/log.%m
        max log size = 50

        security = user
        ;passdb backend = tdbsam
        smb passwd file = /etc/samba/smbpsaawd
        load printers = yes
        cups options = raw

    [$GROUP]
        comment = share for users
        path = /$DIR
        browseable = yes
        writable = yes
        public = no
        valid users = @$NAME
EOF
}

function test() {
    function test_menu() {
        echo
        echo "Select Item"
        echo -e "$blue 1.测试smb.conf是否正确"
        echo -e "$blue 2.重启 samba"
        echo -e "$yellow 3.关闭 iptables"
        echo -e "$yellow 4.将 SELinux 设成允许(Permissive)"
        echo -e "$blue5 .返回主菜单"
        read -p "Enter your choice:" options
    }

    while [ true ]; do
        test_menu
        case $options in
        0)
            break
            ;;
        1)
            testparm
            ;;
        2)
            service smb reload && service smb restart
            ;;
        3)
            service iptables stop
            ;;
        4)
            setenforce 0
            ;;
        5)
            menu
            ;;
        *)
            clear
            echo "Sorry wrong selection"
            ;;
        esac
        read -p "Hit any key to continue. Or CTRL D for exit" options
    done
}

function helper() {
    clear
    cat <<EOT
    [global] 定义全局的配置，”workgroup”用来定义工作组

    security = user #指定samba的安全等级。关于安全等级有四种：
        share：用户不需要账户及密码即可登录samba服务器
        user：由提供服务的samba服务器负责检查账户及密码（默认）
        server：检查账户及密码的工作由另一台windows或samba服务器负责
        domain：指定windows域控制服务器来验证用户的账户及密码。
EOT
    echo "samba 的找密码为 添加的用户明和设置的samba密码"
    echo "更多内容请自行GOOGLE"

}

function menu() {
    echo
    echo -e "$yellow 1.共享一个目录，任何人都可以访问"
    echo -e "$yellow 2.共享一个目录，使用用户名和密码登录后才可以访问"
    echo -e "$blie 3.测试"
    echo -e "$blue 4.帮助"
    echo -e "$yellow 5.添加用户组和用户并设置samba密码"
    read -p "Enter your choice:" option
}

while [ true ]; do
    logo
    line
    check_samba
    line
    menu
    case $option in
    0)
        break
        ;;
    1)
        anyone
        ;;
    2)
        mima
        ;;
    3)
        test
        ;;
    4)
        helper
        ;;
    5)
        adduser
        ;;
    *)
        clear
        echo -e "$blue Sorry wrong selection"
        ;;
    esac
    read -p "Hit any key to continue" option
done
clear
