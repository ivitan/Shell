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
/_/  \__/_/ /_/_/_/\_,_//_\_\  Config
    "
}

function menu() {
    echo -e "$yellow 0 ) 退出"
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
    read -p "Enter your choice:" option
}

function Termux(){
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
            apt install git zsh curl -y
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
            chsh -s zsh
            git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
            ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
            git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
            git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
            echo -e "$blue Successfuly"
            line
            menu
            Termux
        ;;
        
        5)
            pkg install nodejs -y
            git clone -b source  https://github.com/iVitan/ivitan.github.io.git $HOME/hexo
            git clone https://github.com/ivitan/hexo-theme-cutie.git $HOME/hexo/themes/cutie
            cd ~/hexo
            npm i -g hexo-cli
            npm i hexo-deployer-git --save
            npm un hexo-renderer-marked --save
            npm i hexo-renderer-markdown-it markdown-it-emoji markdown-it-mark markdown-it-deflist markdown-it-container --save
            echo -e "$yellow Successfuly"
            line
            menu
            Termux
        ;;
        
        6)
            apt install vim wget -y
            curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            wget -O ~/.vimrc https://github.com/ivitan/UnixConfig/releases/download/vimrc/vimrc
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
        ;;
        
        *)
        echo -e "\033[31m Sorry wrong selection  \033[0m" ;;
    esac
    read -p "Hit any key to continue" option
    menu
}


function PythonTools(){
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
    read -p "Enter your choice:" PyItems
}

function PyItems() {
    case $PyItems in
        0)
        exit ;;
        
        1)
            pkg install python python-dev clang -y
            apt install libxml2 libxml2-dev libxslt libxslt-dev -y
            apt install openssl libffi libffi-dev openssl-tool openssl-dev -y
            apt install fftw fftw-dev libzmq libzmq-dev freetype freetype-dev -y
            apt install libpng libpng-dev pkg-config scrypt -y
            pkg install libcrypt libcrypt-dev ccrypt libgcrypt libgcrypt-dev -y
            pkg install libjpeg-turbo-dev libllvm-dev openjpeg -y
            pip install --upgrade pip
            echo -e "$blue Sucessfully"
            PythonTools
            PyItems
        ;;
        
        2)
            apt install clang python python-dev fftw libzmq libzmq-dev freetype freetype-dev libpng libpng-dev pkg-config -y
            pip install --upgrade pip
            pip install jupyter
            echo -e "$blue Sucessfully"
            PythonTools
            PyItems
        ;;
        
        3)
            pip install BeautifulSoup4 requests
            echo -e "$yellow Sucessfully"
            PythonTools
            PyItems
        ;;
        
        4)
            apt-get install clang libxml2 libxml2-dev libxslt libxslt-dev -y
            pip install lxml
            echo -e "$blue Sucessfully"
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
            
            apt install openssl libffi libffi-dev
            pip install scrapy
            echo -e "$yellow Sucessfully"
            PythonTools
            PyItems
        ;;
        
        6)
            apt install clang python python-dev fftw libzmq libzmq-dev freetype freetype-dev  libpng libpng-dev pkg-config -y
            pip install numpy
            echo -e "$blue Sucessfully"
            PythonTools
            PyItems
        ;;
        
        7)
            apt install freetype freetype-dev libpng libpng-dev pkg-config libpng -y
            pip install matplotlib
            echo -e "$yellow Sucessfully"
            PythonTools
            PyItems
        ;;
        
        8)
            pip install pandas
            pkg install scipy -y
            echo -e "$blue Sucessfully"
            PythonTools
            PyItems
        ;;
        
        9)
            # 链接到了termux社区一位贡献者(its-pointless)编译的源
            curl -L https://its-pointless.github.io/setup-pointless-repo.sh | sh
            pkg install scipy numpy Sklearn -y
            echo -e "$yellow Sucessfully"
            PythonTools
            PyItems
        ;;
        
        10)
            menu
            Termux
        ;;
        *)
        echo "Sorry wrong selection" ;;
    esac
    read -p "Hit any key go back" option
    PyItems
}
line
logo
line
menu
Termux