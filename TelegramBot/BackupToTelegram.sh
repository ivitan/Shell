#!/bin/bash

# Backup important files to telegram

: /opt/scripts/backuplist <<BLOCK
/etc/sysctl.conf
/etc/sysctl.d
/etc/sysconfig/iptables
/etc/sysconfig/ip6tables
/etc/systemd/system/*.service
/etc/ssh/sshd_config
/home/lance/.vimrc
/home/lance/.bashrc
/home/lance/.gitconfig
/home/lance/.ssh
BLOCK

api_key=bot key here
chat_id=chat ID here

fList=$(tr '\n' ' ' </opt/scripts/backuplist)
fName=/tmp/s2_backup_$(date +"%FT%H%M%S").tar.gz

tar -czvPf $fName $fList
curl -F chat_id=$chat_id -F document=@"${fName}" https://api.telegram.org/$api_key/sendDocument >/dev/null
rm -rf $fName

exit 0
