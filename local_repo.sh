#! /bin/bash
# CentOs local source

color3="\e[0;33;40m"

mkdir /local_repo
mount /dev/cdrom /loca_repo

PATH="etc/yum.repos.d/local_repo.repo"

cat << EOF > $PATH
[local_repo]
name=local_repo
baseurl=file:///local_repo
gpgcheck=0 # 关闭 Key 检查 
enabled=1 #开启本地源
EOF

echo "$colori3 Successful!"
