#!/bin/bash
cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
options=(
    1 "rw: read-write可读写权限" on # any option can be set to default to "on"
    2 "ro：read-only，唯读权限" off
    3 "sync：资料同步运存与硬盘当中" off
    4 "async：资料会先暂存于运存，而非直接写入硬盘" off
    5 "no_root_squash：用者如果是root，对于分享的目录具有root权限极不安全，不建议使用" off
    6 "root_squash：使用者如果是root，权限将被压缩成匿名使用者，通常他的UID 与GID 都会变成nobody(nfsnobody)那个系统帐号的身份；" off
    7 "all_squash：不论登入NFS 的使用者身份为何，都会被压缩成为匿名使用者，通常是nobody(nfsnobody)" off
    8 "anonuid：anon意指anonymous(匿名者)，自订匿名使用者的UID" off
    9 "anongid：自订匿名使用者的是变成GID" off
    10 "subtree_check:如果输出的目录是子目录，服务器将检查器父目录的权限" off
    11 "no_subtree_check:如果输出的目录是子目录，服务器将不检查父目录的权限" off
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
    esac
done

VAR=("$PROMISSION1","$PROMISSION2","$PROMISSION3","$PROMISSION4","$PROMISSION5","$PROMISSION6","$PROMISSION7","$PROMISSION8","$PROMISSION9","$PROMISSION10","$PROMISSION11")
array=(${VAR//,/ })
for i in ${array[@]}; do
    echo -n "$i," >>pow.txt
done

POWER=$(cat pow.txt)
echo $POWER
