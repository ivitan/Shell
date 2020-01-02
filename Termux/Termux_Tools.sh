#!/bin/bash
#Copyright by Vitan @ 2019

blue="\033[36m"
yellow="\033[33m"

function logo(){
echo -e "$blue
 ______                       
/_  __/__ ______ _  __ ____ __
 / / / -_) __/  ' \/ // /\ \ /
/_/  \__/_/ /_/_/_/\_,_//_\_\ Tools
"
}

function line(){
    echo -e "$blue -------------------------------------------"
}

function menu() {
    echo -e "$yellow 1) BaiduPCS-Go"
    echo -e "$blue 2) Adb&Fastboot"
    echo -e "$yellow 3) Java"
    echo -e "$blue 3) atilo安装Linux发行版"
}

function  items() {
read -p "请输入择序号：" items
case $items in
1 )
    pkg in -y golang git
    git clone https://github.com/iikira/BaiduPCS-Go.git ~/BaiduPCS-Go
    cd ~/BaiduPCS-Go/
    echo -e "编译时间较长，请耐心等待"
    sleep 2s
    GOOS=android GOARCH=arm64 go build -o bdy main.go
    mv -f bdy ~
    cd ~
    rm -rf ~/BaiduPCS-Go/
    chmod -Rf 777 ~/go/
    rm -rf ~/go/
    menu ; items ;;

2 ) 
    if ! [ -x "$(command -v wget)" ];then
        apt install wget -y
    fi
    wget https://github.com/ivitan/Shell/releases/download/Adb/adb.zip -O ~/adb.zip
    unzip ~/adb.zip -d ~/
    rm -rf ~/adb.zip
    mv -f ~/adb $PREFIX/bin/
    mv -f ~/fastboot $PREFIX/bin/
    chmod +x $PREFIX/bin/adb
    chmod +x $PREFIX/bin/fastboot
    menu ; items ;;

3 )
    if ! [ -x "$(command -v wget)" ];then
        apt install wget -y
    fi
    wget https://github.com/ivitan/Shell/releases/download/Java/java8.deb -O ~/Java.deb
    dpkg -i ~/Java.deb
    rm -rf ~/Java.deb
    menu ; items ;;     

4 )
    if ! [ -x "$(command -v wget)" ];then
        apt install wget -y
    fi
    wget -O ~/atilo.deb https://github.com/ivitan/Shell/releases/download/atilo/atilo.deb
    dpkg -i ~/atilo.deb
    rm -rf ~/atilo.deb
	atilo
    menu ; items ;;    

0 )
    exit ;;

* )
    echo -e "\033[31m Error,序号无效  \033[0m"
esac
    read -p "请重新输入序号: " items
}

logo
line
menu
items
