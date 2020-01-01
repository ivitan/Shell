#!/bin/bash
#Copyright by Vitan @ 2019

blue="\033[36m"
yellow="\033[33m"

function logo(){
echo -e "$blue
 ______                       
/_  __/__ ______ _  __ ____ __
 / / / -_) __/  ' \/ // /\ \ /
/_/  \__/_/ /_/_/_/\_,_//_\_\  Config
"
}

function line(){
    echo -e "$blue -------------------------------------------"
}

function menu() {
    echo -e "$yellow 0 ) 退出"
    echo -e "$blue 1 ) 启动空白问候语"
    echo -e "$yellow 2 ) 恢复双层键盘"
    echo -e "$blue 3 ) 安装 SSH"
    echo -e "$yellow 4 ) Oh-My-Zsh"
    echo -e "$blue 5 ) Hexo"
    echo -e "$yellow 6 ) Vim"
    echo -e "$blue 7 ) Git & GitEmoji"
    echo -e "$yellow 8 ) 更换清华源"
    echo -e "$blue 9 ) 获取储存权限"
    read -p "Enter your choice:" option
}

while [ true ]
do
    logo
    line
    menu
    line
    case $option in
    0)
        break ;;

    1)
        touch $HOME/.hushlogin 
		echo -e "$yellow Successful"
		;;

    2)
        mkdir $HOME/.termux
        echo "extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" >> $HOME/.termux/termux.properties 
		echo -e "$blue Successful"
        ;;

    3)
        apt install openssh -y
        git config --global user.name "Vitan"
        git config --global user.email "vitan.me@gmail.com"
        ssh-keygen -t rsa -C "vitan.me@gmail.com" 
       echo -e "$yellow Successfuly"
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
         ;;
    
    6)
        apt install vim wget -y
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        wget -O ~/.vimrc https://github.com/ivitan/UnixConfig/releases/download/vimrc/vimrc
        echo -e "$blue Sucessfully";;

    7)
        apt install git  wget -y
        wget -O ~/.zshrc https://github.com/ivitan/UnixConfig/releases/download/zshrc/zshrc
	    echo -e "$yellow Successfully"
        ;;

    8)
        sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux stable main@' $PREFIX/etc/apt/sources.list
	    apt update && apt upgrade -y
		;;

    9)
        termux-setup-storage
        ;;

    *)
        echo -e "\033[31m Sorry wrong selection  \033[0m" ;;
    esac
    read -p "Hit any key to continue" option 
done
