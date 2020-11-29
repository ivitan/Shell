#!/bin/bash

vm_key=SolusVM Key
vm_hash=SolusVM hash
vm_addr=https://manage.myvpssolusvm.com

api_key=bot key here
chat_id=chat ID here

# VPS status monitor to telegram
ver=$(lsb_release -d)
# Node
node=$(uname -n)
# Kernel
kern=$(uname -r)
# Bandwidth
bwarr=($(curl -s --connect-timeout 5 $vm_addr/api/client/command.php?key=$vm_key\&hash=$vm_hash\&action=info\&bw=true | grep -oP '\<bw\>(.)*\<\/bw\>' | cut -d ">" -f2 | cut -d "<" -f1 | tr "," "\n"))
# Uptime
upth=$(uptime | cut -d',' -f1)
# Disk
dfh=($(df -h | grep xvda))
# Memory
freeh=($(free -h | grep Mem))
# Top Processes
toph=$(ps -eo pmem,pcpu,cmd | sort -k 1 -nr | head -5)
# All
report="VPS STATUS(${node}): \
%0A \
${ver} \
%0A Kernel: ${kern} \
%0A \
%0A UPTIME:  ${upth} \
%0A DISK:  Total: ${dfh[1]} Used:${dfh[2]} Avail:${dfh[3]} Used%:${dfh[4]} \
%0A BANDWIDTH:  Total: $(echo "scale=2; ${bwarr[0]}/1024/1024/1024/1024" | bc -l)TB Used: $(echo "scale=3; ${bwarr[1]}/1024/1024/1024" | bc -l)GB Avail: $(echo "scale=2; ${bwarr[2]}/1024/1024/1024/1024" | bc -l)TB  Used%: $(echo "scale=3; 100*${bwarr[1]}/${bwarr[0]}" | bc -l) % \
%0A MEMORY:  Total: ${freeh[1]} Used:${freeh[2]} Avail:${freeh[3]} \
%0A \
%0A ----------------------------- \
%0A TOP Processes(pmem,pcpu,cmd): \
%0A ${toph}"

curl -s -X POST https://api.telegram.org/$api_key/sendMessage -d chat_id=$chat_id -d text="$report" >/dev/null

exit 0
