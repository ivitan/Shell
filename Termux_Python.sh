#! /bin/bash
function logo(){
cat <<EOT
 ______                       
/_  __/__ ______ _  __ ____ __
 / / / -_) __/  ' \/ // /\ \ /
/_/  \__/_/ /_/_/_/\_,_//_\_\ 
                                                                           
EOT
}

function line(){
    echo "-------------------------------"
}

function menu() {
    echo
    echo "1.Python3"
    echo "2.Jupyter Notebook"
    echo "3.BeautifulSoup4 & requests"
    echo "4.lxml"
    echo "5.scrapy"
    echo "6.numpy"
    echo "7.matplotlib"
    echo "8.pandas & scipy"
    echo "9.Sklearn"
    echo "Enter your choice:" 
    echo
    read -n 1 option
}

while [ 1 ]
do
    logo
    line
    menu
    line
    case $option in
    0)
        break ;;
    1)
        pkg install python python-dev clang -y
        apt install libxml2 libxml2-dev libxslt libxslt-dev -y
        apt install openssl libffi libffi-dev openssl-tool openssl-dev -y
        apt install fftw fftw-dev libzmq libzmq-dev freetype freetype-dev -y
        apt install libpng libpng-dev pkg-config scrypt -y
        pkg install libcrypt libcrypt-dev ccrypt libgcrypt libgcrypt-dev -y
        pkg install libjpeg-turbo-dev libllvm-dev openjpeg -y
        pip install --upgrade pip
        ;;

    2)
        apt install clang python python-dev fftw libzmq libzmq-dev freetype freetype-dev libpng libpng-dev pkg-config -y
        pip install --upgrade pip
        pip install jupyter 
        ;;
    3)
        pip install BeautifulSoup4 requests
        ;;
    4)  
        apt-get install clang libxml2 libxml2-dev libxslt libxslt-dev -y
        pip install lxml
        ;;
    5)
        wget https://github.com/termux/termux-packages/files/2408158/openssl_1.1.1-2_arm.deb.gz ~/scrapy
        wget https://github.com/termux/termux-packages/files/2408159/openssl-dev_1.1.1-2_arm.deb.gz ~/scrapy
        wget https://github.com/termux/termux-packages/files/2408160/openssl-tool_1.1.1-2_arm.deb.gz ~/scrapy
        cd ~/scrapy
        gunzip openssl_1.1.1-2_arm.deb.gz
        gunzip openssl-dev_1.1.1-2_arm.deb.gz
        gunzip openssl-tool_1.1.1-2_arm.deb.gz
        dpkg -i openssl_1.1.1-2_arm.deb
        dpkg -i openssl-dev_1.1.1-2_arm.deb
        dpkg -i openssl-tool_1.1.1-2_arm.deb

        apt install openssl libffi libffi-dev
        pip install scrapy
        ;;
    6)
        apt install clang python python-dev fftw libzmq libzmq-dev freetype freetype-dev  libpng libpng-dev pkg-config -y
        pip install numpy
        ;;
    7)
        apt install freetype freetype-dev libpng libpng-dev pkg-config libpng -y
        pip install matplotlib
        ;;
    8)
        pip install pandas
        pkg install scipy -y
        ;;
    9)
        # 链接到了termux社区一位贡献者(its-pointless)编译的源
        curl -L https://its-pointless.github.io/setup-pointless-repo.sh | sh
        pkg install scipy numpy Sklearn -y
        ;;
    *)
        echo "Sorry wrong selection" ;;
    esac
    echo "Hit any key to continue"
    echo
    read -n 1 option 
done