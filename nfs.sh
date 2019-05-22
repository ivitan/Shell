#! /bin/bash

yum install rpcbind nfs-utils -y

service rpcbind start
service nfs start

mkdir /home/share

cat << EOF > /etc/exports
/home/share
