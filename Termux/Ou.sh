#!/bin/sh
# Copyright by Vitan @ 2020.6

if ! [ -x "$(command -v curl)" ];then
	pkg install curl -y
fi

curl http://10.1.1.22/ytask/adoa_user_updtime.php?user_id_set=$1
