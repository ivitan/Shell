#!/usr/bin/env bash

# This script is called on SSH login by /etc/profile.d/LoginBot.sh

# Your USERID or Channel ID to display alert and key, we recommend you create new bot with @BotFather on Telegram
USERID=(chat ID here)
KEY="bot key here"

for i in "${USERID[@]}"; do
    URL="https://api.telegram.org/${KEY}/sendMessage"
    DATE="$(date "+%Y-%m-%d %H:%M:%S")"

    if [ -n "$SSH_CLIENT" ]; then
        CLIENT_IP=$(echo $SSH_CLIENT | awk '{print $1}')

        SRV_HOSTNAME=$(hostname -f)
        #SRV_IP=$(hostname -I | awk '{print $1}')

        IPINFO="https://ipinfo.io/${CLIENT_IP}"
        IPQUERY=$(curl -s --connect-timeout 2 https://ipinfo.io/${CLIENT_IP})

        IPCITY=$(echo ${IPQUERY} | cut -d "," -f2 | cut -d "\"" -f4)
        IPREGION=$(echo ${IPQUERY} | cut -d "," -f3 | cut -d "\"" -f4)
        IPCOUNTRY=$(echo ${IPQUERY} | cut -d "," -f4 | cut -d "\"" -f4)
        IPORG=$(echo ${IPQUERY} | rev | cut -d "," -f1 | rev | cut -d "\"" -f4)

        TEXT="SSH Login(${SRV_HOSTNAME}):
        User: *${USER}*
        Date: ${DATE}
        Client: [${CLIENT_IP}](${IPINFO}) - ${IPCITY}, ${IPREGION}, ${IPCOUNTRY}, ${IPORG}"

        curl -s -d "chat_id=$i&text=${TEXT}&disable_web_page_preview=true&parse_mode=markdown" $URL >/dev/null
    fi
done
