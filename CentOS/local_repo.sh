#! /bin/bash
# CentOs local source

color3="\e[0;33;40m"

mkdir /local
mount /dev/cdrom /local

PATH="/etc/yum.repos.d/local.repo"

cat << EOF > $PATH
[local]
name=local
baseurl=file:///local
gpgcheck=0 # 关闭 Key 检查
enabled=1 #开启本地源
EOF

echo "$colori3 Successful!"
