#!/bin/bash
#Copyright by Vitan @ 2019

blue="\033[36m"
yellow="\033[33m"

function line(){
    echo -e "$blue -------------------------------------------"
}

function logo(){
    echo -e "$blue
 ______
/_  __/__ ______ _  __ ____ __
 / / / -_) __/  ' \/ // /\ \ /
/_/  \__/_/ /_/_/_/\_,_//_\_\  Configer
    "
}

function menu() {
    echo -e "$yellow 0) 退出"
    echo -e "$blue 1) 启动空白问候语"
    echo -e "$yellow 2) 恢复双层键盘"
    echo -e "$blue 3) 安装 SSH"
    echo -e "$yellow 4) Oh-My-Zsh"
    echo -e "$blue 5) Hexo"
    echo -e "$yellow 6) Vim"
    echo -e "$blue 7) Git & GitEmoji"
    echo -e "$yellow 8) 更换清华源"
    echo -e "$blue 9) 获取储存权限"
    echo -e "$yellow 10) Python Tools"
    echo -e "$blue 11) 其他小工具"
}

function Termux(){
    read -p "Hit your choice # " option
    case $option in
        0)
        exit;;
        
        1)
            touch $HOME/.hushlogin
            echo -e "$yellow Successful"
            line
            menu
            Termux
        ;;
        
        2)
            mkdir $HOME/.termux
            echo "extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" >> $HOME/.termux/termux.properties
            echo -e "$blue Successful"
            line
            menu
            Termux
        ;;
        
        3)
            apt install openssh -y
            git config --global user.name "Vitan"
            git config --global user.email "vitan.me@gmail.com"
            ssh-keygen -t rsa -C "vitan.me@gmail.com"
            echo -e "$yellow Successfuly"
            line
            menu
            Termux
        ;;
        
        4)
            apt install git zsh curl wget -y
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            chsh -s zsh
            rm -rf ~/.zshrc
            wget https://github.com/ivitan/UnixConfig/releases/download/zshrc/zshrc -O ~/.zshrc
            source ~/.zshrc
            echo -e "$blue Successfuly"
            line
            menu
            Termux
        ;;
        
        5)
            pkg install nodejs-lts -y
            git clone -b source  https://github.com/iVitan/ivitan.github.io.git $HOME/hexo
            git clone https://github.com/ivitan/Icarus.git $HOME/hexo/themes/icarus
            cd ~/hexo
            npm i -g hexo-cli
            npm i hexo-deployer-git --save
            npm un hexo-renderer-marked --save
            npm i hexo-renderer-markdown-it markdown-it-emoji markdown-it-mark markdown-it-deflist markdown-it-container --save
            wget https://github.com/ivitan/Icarus/releases/download/Top/generator.js  -O $HOME/hexo/node_modules/hexo-generator-index/lib/generator.js
            echo -e "$yellow Successfuly"
            line
            menu
            Termux
        ;;
        
        6)
            apt install vim wget -y
            curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            wget https://github.com/ivitan/UnixConfig/releases/download/vimrc/vimrc  -O ~/.vimrc
            vim +PlugInstall +qall
            echo -e "$blue Sucessfully"
            line
            menu
            Termux
        ;;
        
        7)
            apt install git  wget -y
            wget -O ~/.zshrc https://github.com/ivitan/UnixConfig/releases/download/zshrc/zshrc
            echo -e "$yellow Successfully"
            line
            menu
            Termux
        ;;
        
        8)
            sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux stable main@' $PREFIX/etc/apt/sources.list
            apt update && apt upgrade -y
            line
            menu
            Termux
        ;;
        
        9)
            termux-setup-storage
            line
            menu
            Termux
        ;;
        
        10)
            line
            PythonTools
            PyItems
        ;;
        
        11)
            line
            Tools
            items
        ;;
        
        *)
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            Termux
        ;;
    esac
}

function PythonTools(){
    echo -e "$blue 0)Exit"
    echo -e "$yellow 1) Python3"
    echo -e "$blue 2) Jupyter Notebook"
    echo -e "$yellow 3) BeautifulSoup4 & requests"
    echo -e "$blue 4) lxml"
    echo -e "$yellow 5) scrapy"
    echo -e "$blue 6) numpy"
    echo -e "$yellow 7) matplotlib"
    echo -e "$blue 8) pandas & scipy"
    echo -e "$yellow 9) Sklearn"
    echo -e "$blue 10) Go back"
}

function PyItems() {
    read -p "Hit your choice # " PyItems
    case $PyItems in
        0)
        exit ;;
        
        1)
            pkg install python clang -y
            apt install libxml2 libxslt -y
            apt install openssl libffi openssl-tool -y
            apt install fftw libzmq freetype -y
            apt install libpng pkg-config scrypt -y
            pkg install libcrypt ccrypt libgcrypt -y
            pkg install libjpeg-turbo libllvm openjpeg -y
            pip install --upgrade pip
            echo -e "$blue Sucessfully"
            line
            PythonTools
            PyItems
        ;;
        
        2)
            apt install ndk-sysroot fftw libsodium libzmq freetype libpng glib pkg-config -y
            pip install --upgrade pip
            pip install jupyter
            echo -e "$blue Sucessfully"
            line
            PythonTools
            PyItems
        ;;
        
        3)
            pip install BeautifulSoup4 requests
            echo -e "$yellow Sucessfully"
            line
            PythonTools
            PyItems
        ;;
        
        4)
            apt-get install clang libxml2 libxslt -y
            pip install lxml
            echo -e "$blue Sucessfully"
            line
            PythonTools
            PyItems
        ;;
        
        5)
            if ! [ -x "$(command -v wget)" ];then
                apt install wget -y
            fi
            wget https://github.com/ivitan/Shell/releases/download/Scrapy/openssl_1.1.1-2_arm.deb.gz -O ~/scrapy
            wget https://github.com/ivitan/Shell/releases/download/Scrapy/openssl-dev_1.1.1-2_arm.deb.gz -O ~/scrapy
            wget https://github.com/ivitan/Shell/releases/download/Scrapy/openssl-tool_1.1.1-2_arm.deb.gz -O ~/scrapy
            cd ~/scrapy
            gunzip openssl_1.1.1-2_arm.deb.gz
            gunzip openssl-dev_1.1.1-2_arm.deb.gz
            gunzip openssl-tool_1.1.1-2_arm.deb.gz
            dpkg -i openssl_1.1.1-2_arm.deb
            dpkg -i openssl-dev_1.1.1-2_arm.deb
            dpkg -i openssl-tool_1.1.1-2_arm.deb
            
            apt install openssl libffi
            pip install scrapy
            echo -e "$yellow Sucessfully"
            line
            PythonTools
            PyItems
        ;;
        
        6)
            apt install clang python fftw libzmq freetype libpng pkg-config -y
            pip install numpy
            echo -e "$blue Sucessfully"
            line
            PythonTools
            PyItems
        ;;
        
        7)
            apt install freetype libpng pkg-config libpng -y
            pip install matplotlib
            echo -e "$yellow Sucessfully"
            line
            PythonTools
            PyItems
        ;;
        
        8)
            pip install pandas
            pkg install scipy -y
            echo -e "$blue Sucessfully"
            line
            PythonTools
            PyItems
        ;;
        
        9)
            # 链接到了termux社区一位贡献者(its-pointless)编译的源
            curl -L https://its-pointless.github.io/setup-pointless-repo.sh | sh
            pkg install scipy numpy Sklearn -y
            echo -e "$yellow Sucessfully"
            line
            PythonTools
            PyItems
        ;;
        
        10)
            menu
            Termux
        ;;
        
        11)
            Tools
            items
        ;;
        
        *)
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            PyItems
    esac
}

function Tools(){
    echo -e "$yellow 0) 退出"
    echo -e "$yellow 1) BaiduPCS-Go"
    echo -e "$blue 2) Adb&Fastboot"
    echo -e "$yellow 3) Java"
    echo -e "$blue 4) atilo安装Linux发行版"
    echo -e "$yellow 5) Go back"
}

function  items() {
    read -p "请输入择序号：" items
    case $items in
        1)
            if ! [ -x "$(command -v wget)" ];then
                apt install wget -y
            fi
            wget https://github.com/iikira/BaiduPCS-Go/releases/latest/download/v3.6.1/BaiduPCS-Go-v3.6.1-linux-arm64.zip -O ~/yun.zip
            if ! [ -x "$(command -v unzip)" ];then
                apt install unzip -y
            fi
            unzip ~/yun.zip -d ~/yun
            rm -rf ~/yun.zip
            mv ~/yun/BaiduPCS-GO $PREFIX/bin/yun
            chmod -Rf 777 $PREFIX/bin/yun
            yun
            line
            menu
            items
        ;;
        
        2)
            if ! [ -x "$(command -v wget)" ];then
                apt install wget -y
            fi
            wget https://github.com/ivitan/Shell/releases/download/Adb/adb.zip -O ~/adb.zip
            if ! [ -x "$(command -v unzip)" ];then
                apt install unzip -y
            fi
            unzip ~/adb.zip -d ~/
            rm -rf ~/adb.zip
            mv -f ~/adb $PREFIX/bin/
            mv -f ~/fastboot $PREFIX/bin/
            chmod +x $PREFIX/bin/adb
            chmod +x $PREFIX/bin/fastboot
            line
            menu
            items
        ;;
        
        3)
            if ! [ -x "$(command -v wget)" ];then
                apt install wget -y
            fi
            wget https://github.com/ivitan/Shell/releases/download/Java/java8.deb -O ~/Java.deb
            dpkg -i ~/Java.deb
            rm -rf ~/Java.deb
            line
            menu
            items
        ;;
        
        4)
            if ! [ -x "$(command -v wget)" ];then
                apt install wget -y
            fi
            wget -O ~/atilo.deb https://github.com/ivitan/Shell/releases/download/atilo/atilo.deb
            dpkg -i ~/atilo.deb
            rm -rf ~/atilo.deb
            atilo
            line
            menu
            items
        ;;
        
        5)
            Termux
        ;;
        
        0)
        exit ;;
        
        * )
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            items
        ;;
    esac
}

logo
line
menu
Termux