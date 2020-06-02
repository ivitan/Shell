#!/bin/bash
# Copyright by Vitan @ 2020.6

if ! [ -x "$(command -v curl)" ];then
	pkg install curl -y
fi

read -p "Enter username: " UserName

curl http://10.1.1.22/ytask/adoa_user_updtime.php?user_id_set=$UserName
