#! /bin/bash
#Copyright by Vitan @ 2019

blue="\033[36m"
yellow="\033[33m"

function logo(){
    echo -e "$blue
 ______
/_  __/__ ______ _  __ ____ __
 / / / -_) __/  ' \/ // /\ \ /
/_/  \__/_/ /_/_/_/\_,_//_\_\ Python
    "
}

function line(){
    echo -e "$yellow --------------------------------------------"
}

function menu() {
    echo -e "$yellow 1) Python3"
    echo -e "$blue 2) Jupyter Notebook"
    echo -e "$yellow 3) BeautifulSoup4 & requests"
    echo -e "$blue 4) lxml"
    echo -e "$yellow 5) scrapy"
    echo -e "$blue 6) numpy"
    echo -e "$yellow 7) matplotlib"
    echo -e "$blue 8) pandas & scipy"
    echo -e "$yellow 9) Sklearn"
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
        ;;
        
        2)
            apt install ndk-sysroot fftw libsodium libzmq freetype libpng glib pkg-config -y
            pip install --upgrade pip
            pip install jupyter
            echo -e "$blue Sucessfully"
            line
        ;;

        3)
            pip install BeautifulSoup4 requests
            echo -e "$yellow Sucessfully"
            line
        ;;

        4)
            apt-get install clang libxml2 libxslt -y
            pip install lxml
            echo -e "$blue Sucessfully"
            line
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
        ;;

        6)
            apt install clang python fftw libzmq freetype libpng pkg-config -y
            pip install numpy
            echo -e "$blue Sucessfully"
            line
        ;;

        7)
            apt install freetype libpng pkg-config libpng -y
            pip install matplotlib
            echo -e "$yellow Sucessfully"
            line
        ;;

        8)
            pip install pandas
            pkg install scipy -y
            echo -e "$blue Sucessfully"
            line
        ;;

        9)
            # 链接到了termux社区一位贡献者(its-pointless)编译的源
            curl -L https://its-pointless.github.io/setup-pointless-repo.sh | sh
            pkg install scipy numpy Sklearn -y
            echo -e "$yellow Sucessfully"
            line
        ;;

        *)
            echo "Sorry wrong selection"
        ;;
    esac
    read -p "Hit any key to continue" option
done
