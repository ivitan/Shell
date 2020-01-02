#!/bin/bash

# 将下面脚本添加到crontab定时执行，比如2分钟检查一次*/2****/opt/scripts/GWF_monitor.sh。
name=vitan.me
server=baidu.com
online=/tmp/online
offline=/tmp/offline

api_key=bot key here
chat_id=chat ID here

ping=$(ping -c 5 -W 1 ${server} | grep '100% packet loss')

if [ -z "$ping" ]; then
    rm -rf $offline
    # if never online then log and notify
    if [ ! -f $online ]; then
        touch $online
        curl -s -X POST https://api.telegram.org/$api_key/sendMessage -d chat_id=$chat_id -d text="GFW Monitor - OK:%0A$name is not blocked by GFW, $server is accessible." > /dev/null
    fi
else
    rm -rf $online
    if [ ! -f $offline ]; then
        touch $offline
        curl -s -X POST https://api.telegram.org/$api_key/sendMessage -d chat_id=$chat_id -d text="GFW Monitor - BLOCKED:%0A$name is blocked by GFW, $server is not accessible." > /dev/null
    fi
fi

exit 0