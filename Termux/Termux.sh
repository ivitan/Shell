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
    echo -e "$blue 1) Termux 配置"
    echo -e "$yellow 2) 开发环境"
    echo -e "$blue 3) 信息安全工具"
    echo -e "$yellow 4) 实用工具"
}

function MenuItem(){
    read -p "请输入序号 # " MenuItems
    case $MenuItems in
        0)
        exit;;

        1)
            line
            Termux
            TermuxItem
        ;;

        2)
            line
            development
            DevItem
        ;;

        3)
            line
            security
            SeItem
        ;;

        4)
            line
            Tools
            items
        ;;

        *)
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            MenuItem
        ;;
    esac
}

function Termux(){
    echo -e "$yellow 0) 返回主菜单"
    echo -e "$blue 1) 空白问候语"
    echo -e "$blue 2) 辅助键盘"
    echo -e "$yellow 3) 修改启动问候语"
    echo -e "$blue 4) Oh-My-Zsh"
    echo -e "$yellow 5) 更换清华源"
    echo -e "$blue 6) 获取存储权限"  
    echo -e "$yellow 7) 获取设备信息"
    echo -e "$blue 8) 获取存储权限"  
    echo -e "$yellow 9) 阻止CPU休眠"
    echo -e "$blue 10) 允许CPU休眠" 
    echo -e "$yellow 11) 安装 Termux-Api"
}

function TermuxItem(){
    read -p "请输入序号 # " option
    case $option in
        0)
            line
            menu
            MenuItem
        ;;
        
        1)
            touch $HOME/.hushlogin
            echo -e "$yellow Successful"
            line
            Termux
            TermuxItem
        ;;
        
        2)
            mkdir $HOME/.termux
            echo "extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" >> $HOME/.termux/termux.properties
            echo -e "$blue Successful"
            line
            Termux
            TermuxItem
        ;;
        
        3)
            vim $PREFIX/etc/motd
            echo -e "$yellow 配置完成"
            line
            Termux
            TermuxItem
        ;;
        
        4)
            apt install git zsh curl wget -y
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            chsh -s zsh
            rm -rf ~/.zshrc
            wget https://github.com/ivitan/UnixConfig/releases/download/zshrc/zshrc -O ~/.zshrc
            source ~/.zshrc
            echo -e "$blue 配置完成"
            line
            Termux
            TermuxItem
        ;;
          
        5)
            sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux stable main@' $PREFIX/etc/apt/sources.list
            apt update && apt upgrade -y
		    echo "更换完成！"
            line
            Termux
            TermuxItem
        ;;
        
        6)
            termux-setup-storage
            line
            Termux
            TermuxItem
        ;;
        
        7)
            termux-info
            line
            Termux
            TermuxItem
        ;;
        
        8)
            termux-setup-storage
            line
            Termux
            TermuxItem
        ;;

        9)  
            termux-wake-lock
            line
            Termux
            TermuxItem
        ;;

        10) 
            termux-wake-unlock
            line
            Termux
            TermuxItem
        ;;

        11)  
            pkg install termux-api
            line
            Termux
            TermuxItem
        ;;
        
        *)
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            Termux
        ;;
    esac
}

function PythonTools(){
    echo -e "$blue 0) 返回主菜单"
    echo -e "$yellow 1) Python3"
    echo -e "$blue 2) Jupyter Notebook"
    echo -e "$yellow 3) BeautifulSoup4 & requests"
    echo -e "$blue 4) lxml"
    echo -e "$yellow 5) scrapy"
    echo -e "$blue 6) numpy"
    echo -e "$yellow 7) matplotlib"
    echo -e "$blue 8) pandas & scipy"
    echo -e "$yellow 9) Sklearn"
    echo -e "$blue 10) iPython"
}

function PyItem() {
    read -p "Hit your choice # " PyItems
    case $PyItems in
        0)
            line
            menu
            MenuItem
        ;;
        
        1)
            echo "正在安装 Python3"
            pkg install python clang -y
            apt install libxml2 libxslt -y
            apt install openssl libffi openssl-tool -y
            apt install fftw libzmq freetype -y
            apt install libpng pkg-config scrypt -y
            pkg install libcrypt ccrypt libgcrypt -y
            pkg install libjpeg-turbo libllvm openjpeg -y
            while true
            do
                read -p "要换 Pypi源为清华源吗？ [Y/n] " input
                case $input in
                    [yY][eE][sS]|[yY])
                        echo "正在更换 pip 源..."
                        pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
                        pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
                        break;;
                    [nN][oO]|[nN])
                        echo "正在更新 pip..."
                        pip install pip -U
                        break;;
                    *)
                        echo "输入错误，请重新输入...";;
                esac
            done
            echo -e "$blue 安装完成"
            line
            PythonTools
            PyItem
        ;;
        
        2)
            echo "正在安装 Jupyter Notebook"
            apt install ndk-sysroot fftw libsodium libzmq freetype libpng glib pkg-config -y
            pip install --upgrade pip
            pip install jupyter
            echo -e "$blue 安装完成"
            line
            PythonTools
            PyItem
        ;;
        
        3)
            echo "正在安装 BeautifulSoup4 requests"
            pip install BeautifulSoup4 requests
            echo -e "$yellow 安装完成"
            line
            PythonTools
            PyItem
        ;;
        
        4)
            echo "正在安装 lxml"
            apt-get install clang libxml2 libxslt -y
            pip install lxml
            echo -e "$blue 安装完成"
            line
            PythonTools
            PyItem
        ;;
        
        5)
            echo "正在安装 scrapy"
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
            echo -e "$yellow 安装完成"
            line
            PythonTools
            PyItem
        ;;
        
        6)
            echo "正在安装 Numpy"
            apt install clang python fftw libzmq freetype libpng pkg-config -y
            pip install numpy
            echo -e "$blue 安装完成"
            line
            PythonTools
            PyItem
        ;;
        
        7)
            echo "正在安装 Matplotlib"
            apt install freetype libpng pkg-config libpng -y
            pip install matplotlib
            echo -e "$yellow 安装完成"
            line
            PythonTools
            PyItem
        ;;
        
        8)
            echo "正在安装 pandas scipy"
            pip install pandas -y
            pkg install scipy -y
            echo -e "$blue 安装完成"
            line
            PythonTools
            PyItem
        ;;
        
        9)
            echo "正在安装 Sklearn"
            # 链接到了termux社区一位贡献者(its-pointless)编译的源
            curl -L https://its-pointless.github.io/setup-pointless-repo.sh | sh
            pkg install scipy numpy Sklearn -y
            echo -e "$yellow 安装完成"
            line
            PythonTools
            PyItem
        ;;
        
        10)
            apt install -y clang
			pip install ipython
            echo "安装完成"
            line
            PythonTools
            PyItem
        ;;

        *)
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            PyItem
    esac
}

function Tools(){
    echo -e "$yellow 0) 返回主菜单"
    echo -e "$yellow 1) BaiduPCS-Go"
    echo -e "$blue 2) Adb&Fastboot"
    echo -e "$yellow 3) Java"
    echo -e "$blue 4) atilo安装Linux发行版"
    echo -e "$yellow 5) Nginx 服务器"
    echo -e "$blue 6) Apache2 服务器"
    echo -e "$blue 7) Tmux 终端复用软件"
    echo -e "$yellow 8) Hexo 博客"
    echo -e "$blue 9) OpenSSH SSH"
    echo -e "$yellow 10) Aria2 下载工具"
    echo -e "$blue 11) You-Get 视频下载"
    echo -e "$yellow 12) UnblockNeteaseMusic 工具"
    echo -e "$blue 13) KodExplorer 可道云"
    echo -e "$yellow 14) ELinks 纯文本浏览器"
    echo -e "$blue 15) MPV 播放器"
    echo -e "$yellow 16) BiliHelper B站直播脚本"
}

function  items() {
    read -p "请输入择序号：" items
    case $items in
        1)
            echo "正在安装 BaiduPCS-Go"
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
            echo "安装完成 使用 yun 打开"
            line
            tools
            items
        ;;
        
        2)
            echo "正在安装 Adb"
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
            echo "安装完成"
            line
            tools
            items
        ;;
        
        3)
            echo "正在安装 Java8"
            if ! [ -x "$(command -v wget)" ];then
                apt install wget -y
            fi
            wget https://github.com/ivitan/Shell/releases/download/Java/java8.deb -O ~/Java.deb
            dpkg -i ~/Java.deb
            rm -rf ~/Java.deb
            echo "安装完成"
            line
            tools
            items
        ;;
        
        4)
            echo "正在安装 atilo"
            if ! [ -x "$(command -v wget)" ];then
                apt install wget -y
            fi
            wget -O ~/atilo.deb https://github.com/ivitan/Shell/releases/download/atilo/atilo.deb
            dpkg -i ~/atilo.deb
            rm -rf ~/atilo.deb
            atilo
            line
            tools
            items
        ;;

        5)
        	pkg install -y nginx
		    echo "安装完成"
            line
            tools
            items
        ;;

        6)
        	pkg install -y apache2
		    echo "安装完成"
            line
            tools
            items
        ;;

        7)
            pkg install -y tmux
            echo "安装完成"
            line
            tools
            items
        ;;
        
        8)
            pkg install nodejs-lts -y
            git clone -b source  https://github.com/iVitan/ivitan.github.io.git $HOME/hexo
            git clone https://github.com/ivitan/indigo.git $HOME/hexo/themes/indigo
            cd ~/hexo
            npm i -g hexo-cli
            npm i hexo-deployer-git --save
            npm un hexo-renderer-marked --save
            npm i hexo-renderer-markdown-it markdown-it-emoji markdown-it-mark markdown-it-deflist markdown-it-container --save
            wget https://github.com/ivitan/Icarus/releases/download/Top/generator.js  -O $HOME/hexo/node_modules/hexo-generator-index/lib/generator.js
            echo "安装完成"
            line
            tools
            items
        ;;
        
        9)
        	pkg install -y openssh
		    echo "安装完成"
            line
            tools
            items
        ;;
        
        10)
            pkg install -y wget aria2 nginx unzip
            echo "创建配置文件..."
            mkdir ~/aria2
            wget -O ~/aria2/aria2.conf https://github.com/ivitan/UnixConfig/releases/download/V0.01/aria2.conf
            echo "将要从Github上下载AriaNg-1.1.4-AllInOne.zip，此版本更新于2019.10.8，截至2020.2.20为最新版。"
            wget https://github.com/mayswind/AriaNg/releases/download/1.1.4/AriaNg-1.1.4-AllInOne.zip ~/
            if [ -f ~/AriaNg-1.1.4-AllInOne.zip ]; then
                unzip AriaNg-1.1.4-AllInOne.zip
                mv -f ~/index.html $PREFIX/share/nginx/html/index.html
                mv -f ~/LICENSE $PREFIX/share/nginx/html/LICENSE
                echo -e "nginx\naria2c --conf-path=$HOME/aria2/aria2.conf -D" >$PREFIX/bin/startaria2
                echo -e "nginx -s stop\nkillall aria2c" > $PREFIX/bin/stoparia2
                chmod +x $PREFIX/bin/startaria2
                chmod +x $PREFIX/bin/stoparia2
                echo '安装完成！请使用"startaria2"命令打启动Aria2下载服务，使用"stoparia2"命令关闭服务。'
            else
		        echo "下载失败！"
	        fi
            line
            tools
            items
        ;;
        
        11)
            pkg install -y python ffmpeg
            pip install you-get
            echo "安装完成"
            line
            tools
            items
        ;;
        
        12)
            pkg install -y nodejs
            echo "正在更新NPM..."
            npm install -g npm
            npm install -g @nondanee/unblockneteasemusic
            echo "安装完成"
            line
            tools
            items
        ;;
        
        13)
            echo "正在安装依赖..."
            pkg install -y git
            echo "正在从Gitee克隆KodExplorer..."
            git clone https://gitee.com/kalcaddle/KODExplorer.git
            chmod -Rf 777 ./KODExplorer/*
            echo -e "cd ~/KODExplorer\nphp -S 127.0.0.1:8080 -t ." > /data/data/com.termux/files/usr/bin/startkod
            chmod +x /data/data/com.termux/files/usr/bin/startkod
            echo "安装完成！请使用 startkod 命令启动可道云服务，Ctrl+C关闭。"
            line
            tools
            items
        ;;

        14)
            pkg install -y elinks
            echo "安装完成！"
            line
            tools
            items
        ;;
        
        15)
            pkg install -y mpv
            echo "安装完成"
            line
            tools
            items
        ;;       
                        
        16)
            git clone https://github.com/lkeme/BiliHelper-personal.git
            echo "正在安装依赖..."
            pkg install -y php
            php -r "readfile('https://install.phpcomposer.com/installer');" | php
            mv -f ~/composer.phar ~/BiliHelper-personal/
            cd ~/BiliHelper-personal/
            php composer.phar config -g repo.packagist composer https://mirrors.aliyun.com/composer/
            php composer.phar install
            cp ~/BiliHelper-personal/conf/user.conf.example ~/BiliHelper-personal/conf/user.conf
            echo "php ~/BiliHelper-personal/index.php" > $PREFIX/bin/bilihelper
            chmod +x /data/data/com.termux/files/usr/bin/bilihelper
            echo "安装完成！修改 ~/BiliHelper-personal/conf/user.conf 修改配置文件，填入自己的帐号信息，并使用 bilihelper 命令运行BiliHelper。"
            tools
            items
        ;;
        
        0)
            line
            menu
            MenuItem
        ;;
        
        * )
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            items
        ;;
    esac
}


function development() {
    echo -e "$yellow 0) 返回主菜单"
    echo -e "$yellow 1) 配置 Vim"
    echo -e "$blue 2) Python 环境"
    echo -e "$yellow 3) C/C++ 环境 "
    echo -e "$blue 4) Node.js JavaScript 环境"
    echo -e "$yellow 5) MariaDB"
    echo -e "$blue 6) PHP 环境"
    echo -e "$yellow 7) Go 环境"
    echo -e "$blue 8) JAVA 环境"
    echo -e "$yellow 9) 配置 SSH"
}

function  DevItem() {
    read -p "请输入择序号：" DevItems
    case $DevItems in
        0)
            line
            menu
            MenuItem
        ;;

        1)
            echo "正在安装 Vim..."
            apt install vim wget -y
            curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            wget https://github.com/ivitan/UnixConfig/releases/download/vimrc/vimrc  -O ~/.vimrc
            vim +PlugInstall +qall
            echo -e "$blue 安装配置完成"
            line
            development
            DevItem
        ;;

        2)
            PythonTools
            PyItems
        ;;

        3)
            echo "正在安装 clang..."
            apt update
            apt install -y clang
            echo "正在安装 make..."
            apt install -y make
            echo "正在安装 build-essential..."
            apt install  -y build-essential
            echo "正在安装 GDB..."
            apt install -y gdb
            echo "C/C++开发环境安装完成..."
            line
            development
            DevItem
        ;;

        4)
            echo "正在安装 Node.js..."
		    pkg install -y nodejs
            while true
            do
                read -p "你要切换NPM源为淘宝源吗？ [Y/n] " input
                case $input in
                    [yY][eE][sS]|[yY])
                        echo "正在切换 NPM 源..."
                        npm config set registry http://registry.npm.taobao.org/
                        npm install -g npm
                        break;;
                    [nN][oO]|[nN])
                        echo "正在更新NPM..."
                        npm install -g npm
                        break;;
                    *)
                        echo "输入错误，请重新输入...";;
                esac
            done
            echo "Node.js安装完成..."
            line
            development
            DevItem
        ;;
        5)
            pkg install -y mariadb
		    echo "正在安装基本数据..."
		    mysql_install_db
		    echo "安装完成"
            line
            development
            DevItem
        ;;

        6)
            pkg install -y php
            line
            development
            DevItem
        ;;

       7)
            echo "正在安装golang..."
            pkg install -y golang
            echo "正在安装golang-doc..."
            pkg install -y golang-doc
            echo "Go开发环境安装完成..."
            line
            development
            DevItem
        ;;

        8)
            echo "正在安装 Java8"
            if ! [ -x "$(command -v wget)" ];then
                apt install wget -y
            fi
            wget https://github.com/ivitan/Shell/releases/download/Java/java8.deb -O ~/Java.deb
            dpkg -i ~/Java.deb
            rm -rf ~/Java.deb
            echo "安装完成"
            line
            development
            DevItem       
        ;;

        9)
            apt install openssh -y
            read -p "请输入 SSH 用户名 # " UserName
            git config --global user.name "${UserName}"
            read -p "请输入 SSH 邮箱 # " UserEmail
            git config --global user.email "${UserEmail}"
            ssh-keygen -t rsa -C "${UserEmail}"
            echo -e "$yellow 配置完成"
            line
            development
            DevItem
        ;;

        * )
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            DevItem
        ;;
    esac
}

function security() {
    echo -e "$yellow 0) 返回主菜单"
    echo -e "$yellow 1) 安装 Metasploit"
    echo -e "$yellow 2) 安装 Nmap"
    echo -e "$yellow 3) 安装 Hydra"
    echo -e "$yellow 4) 安装 SSLscan"
    echo -e "$yellow 5) 安装 whatportis"
    echo -e "$yellow 6) 安装 SQLmap"
    echo -e "$yellow 7) 安装 RouterSploit"
    echo -e "$yellow 8) 安装 Slowloris"
    echo -e "$yellow 9) 安装 RED HAWK "
    echo -e "$yellow 10) 安装 Cupp"
    echo -e "$yellow 11) 安装 Hash-Buster"
    echo -e "$yellow 12) 安装 WPSeku"
    echo -e "$yellow 13) 安装 XSStrike"
}

function SeItem(){
    read -p "请输入择序号：" SeItems
    case $SeItems in
        0)
            line
            menu
            MenuItem
        ;;

        2)
        	pkg install -y unstable-repo
		    pkg install -y metasploit
            echo "安装完成"
            line
            security
            SeItem
        ;;

        3)
		    pkg install -y hydra
            echo "安装完成"
            line
            security
            SeItem
        ;;
        
        4)
            pkg install -y unstable-repo
            pkg install -y sslscan
            echo "安装完成"
            line
            security
            SeItem
        ;;

        5)
            pip install whatportis
            echo "安装完成"
            line
            security
            SeItem
        ;;
        
        6)
            pip install sqlmap
            echo "安装完成"
            line
            security
            SeItem
        ;;
        
        7)
            git clone https://www.github.com/threat9/routersploit ~/routersploit
		    cd routersploit 
		    pip install -r requirements.txt
		    python rsf.py
            echo "安装完成"
            line
            security
            SeItem
        ;;
        
        8)
            pip install slowloris
            echo "安装完成"
            line
            security
            SeItem
        ;;
        
        9)
            pkg install -y php
		    git clone https://github.com/Tuhinshubhra/RED_HAWK.git ~/RED_HAWK
		    cd ~/RED_HAWK
		    php rhawk.php
            echo "安装完成"
            line
            security
            SeItem
        ;;
        
        10)
            git clone https://github.com/Mebus/cupp.git ~/cupp
            cd ~/cupp
            python cupp.py
            echo "安装完成"
            line
            security
            SeItem
        ;; 

        11)
            git clone https://github.com/UltimateHackers/Hash-Buster.git ~/Hash-Buster
            cd ~/Hash-Buster
            python hash.py
            echo "安装完成"
            line
            security
            SeItem
        ;;        
        12)
            git clone https://github.com/m4ll0k/WPSeku.git ~/wpseku
            cd ~/wpseku
            pip install -r requirements.txt
            python wpseku.py
            echo "安装完成"
            line
            security
            SeItem
        ;;

        13)
        	git clone https://github.com/UltimateHackers/XSStrike.git ~/XSStrike
            cd ~/XSStrike
            pip install -r requirements.txt
            python xsstrike.py
            echo "安装完成"
            line
            security
            SeItem
        ;;

        * )
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            SeItem
        ;;
    esac
}

function eggs(){
    echo -e "$yellow 0) 回主菜单"
    echo -e "$yellow 1) screenfetch"
    echo -e "$yellow 2) neofetch"
    echo -e "$yellow 3) sl 火车"
    echo -e "$yellow 4) cmatrix"
    echo -e "$yellow 5) nyancat"
    echo -e "$yellow 6) fortune"
    echo -e "$yellow 7) apt的超级牛力"
    echo -e "$yellow 8) telnet星球大战"
}

function EggItem(){
    read -p "请输入择序号：" EggItems
    case $EggItems in
        0)
            line
            menu
            MenuItem
        ;;
        1)
            pkg install -y screenfetch
            screenfetch
            line
            eggs
            EggItem
        ;;

        2)
            pkg install -y neofetch
            neofetch
            line
            eggs
            EggItem
        ;;

        3)
            pkg install -y sl
            sl
            line
            eggs
            EggItem
        ;;

        4)
            pkg install -y cmatrix
            cmatrix
            line
            eggs
            EggItem
        ;;
        5)
            pkg install -y nyancat
            nyancat
            line
            eggs
            EggItem
        ;;

        6)
            pkg install -y fortune
            fortune
            line
            eggs
            EggItem
        ;;

        7)
            apt-get moo
            line
            eggs
            EggItem
        ;;

        8)
            pkg install -y telnet
            telnet towel.blinkenlights.nl
            line
            eggs
            EggItem
        ;;

        * )
            echo -e "\033[31m 序号无效,请重试 \033[0m"
            EggItem
        ;;
    esac
}

logo
line
menu
MenuItem