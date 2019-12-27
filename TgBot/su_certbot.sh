#!/bin/bash

# Update let's encrypt
:<<BLOCK
Let's Encrypt有个官方的CertBot脚本，添加个crontab任务在每周四的三点执行下面的脚本0 4 * * 3 /opt/scripts/su_certbot.sh：
BLOCK

api_key=bot key here
chat_id=chat ID here

result=$(/opt/certbot-auto renew --renew-hook "systemctl restart nginx & systemctl restart v2ray")
$result=$(python -c "import urllib, sys; print urllib.quote(sys.argv[1])" "$result")

curl -s -X POST https://api.telegram.org/$api_key/sendMessage -d chat_id=$chat_id -d \
	text="Let's Encrypt Certbot(s2.shuyz.com): \
	%0A \
	${result}"  > /dev/null

exit 0