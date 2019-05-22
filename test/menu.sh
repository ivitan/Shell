#! /bin/bash
power()
{
cat <<EOF
    1. rw: read-write，可读写的权限
    2. ro：read-only，唯读的权限
    3. sync：资料同步写入到记忆体与硬碟当中
    4. async：资料会先暂存于记忆体当中，而非直接写入硬碟
    5. no_root_squash：登入NFS 主机使用分享目录的使用者如果是root，对于分享的目录具有root 的权限极不安全，不建议使用
    6. root_squash：登入NFS 主机使用分享目录的使用者如果是root，权限将被压缩成匿名使用者，通常他的UID 与GID 都会变成nobody(nfsnobody) 那个系统帐号的身份；
    7. all_squash：不论登入NFS 的使用者身份为何，都会被压缩成为匿名使用者，通常是nobody(nfsnobody)
    8. anonuid：anon 意指anonymous (匿名者)，自订匿名使用者的UID
    9. anongid：自订匿名使用者的是变成GID
    10. subtree_check:如果输出的目录是子目录，则NFS服务器将检查器父目录的权限
    11. no_subtree_check:如果输出的目录是子目录，则NFS服务器将不检查器父目录的权限
EOF
}
power
while true
do
    read -p "输入权限选项:" ch
    case $ch in
        1)PROMISSION="rw";;
        2)PROMISSION="ro";;
        3)PROMISSION="sync";;
        4)PROMISSION="async";;
        5)PROMISSION="no_root_squash";;
        6)PROMISSION="root_squash";;
        7)PROMISSION="all_squash";;
        8)
        read -p "请输入UID:" U
        PROMISSION="anonuid=$U"
        ;;
        9)
        read -p "请输入UID:" G
        PROMISSION="anongid=$G";;
        10)PROMISSION="rsubtree_check";;
        11)PROMISSION="no_subtree_check";;
        *)echo '你输入数字超出范围';;
    esac
    break
done
echo $PROMISSION