#! /bin/bash
# CentOs local source

mkdir /nfs
mount /dev/cdrom /nfs

PATH="etc/yum.repos.d/nfs.repo"

cat << EOF > $PATH
[nfs]
name=nfs
baseurl=file:///nfs
gpgcheck=1
enabled=1 #开启本地源
EOF
