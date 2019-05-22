#! /bin/bash
color1="\e[0;31;40m"
color2="\e[0;32;40m"
color3="\e[0;33;40m"
color4="\e[0;34;40m"
color5="\e[0;35;40m"
color6="\e[0;37;40m"
mypath=$PREFIX/whatandwhy
function logo()
{
    echo -e "$color2            ██                    ██ "
    echo -e "$color3 ██      ██ ██▄████▄   ▄█████▄  ███████"
    echo -e "$color4 ▀█  ██  █▀ ██▀   ██   ▀ ▄▄▄██    ██ "
    echo -e "$color5  ██▄██▄██  ██    ██  ▄██▀▀▀██    ██ "
    echo -e "$color6  ▀██  ██▀  ██    ██  ██▄▄▄███    ██▄▄▄ "
    echo -e "$color1   ▀▀  ▀▀   ▀▀    ▀▀   ▀▀▀▀ ▀▀     ▀▀▀▀ "
}
function line()
{
    echo -e "$color6————————————————————————————————————————————————"
}
function inp()
{
    echo -en "$color6 ٩(๛ ˘ ³˘)۶❤>"
}
function p2()
{
    pkg in python2 python2-dev -y
}
function p3()
{
    pkg in python python-dev -y
}
function plibs()
{
	apt install *clang* make cmake freetype freetype-dev libpng libpng-dev pkg-config fftw libcrypt libcrypt-dev -y
    pkg in libxml2 libxml2-dev libxslt libxslt-dev -y
    for ((i=1; i<=$#; i++))
    do
    python -m pip install $i
    done
}
function plibs2()
{
	apt install *clang* make cmake freetype freetype-dev libpng libpng-dev pkg-config fftw libcrypt libcrypt-dev -y
    pkg in libxml2 libxml2-dev libxslt libxslt-dev -y
    for ((i=1; i<=$#; i++))
    do
    python2 -m pip install $i
    done
}

 
function English()
{
    interesting="Interesting things "
    hack="Penetration test tools "
    change_source="Use Tsinghua source "
    all="All in one "
    embellish_terminal="Embellish terminal "
    vim="Deploy vim as an IDE "
    q="Quit "
    re_input="Please input correct instruction "
    return="Return"
    thank="Thank for using"
    source_its_pointless="Add a source to install more software"
    soft_keyboard="Enable complete soft keyboard"
    rst="please restart termux"
    wahtset1="Now you can use "
    wahtset2="to start "
    myupdate="update all"
    theone
}
function Chinese()
{
    interesting="好玩的&装逼 "
    hack="渗透测试工具 "
    change_source="使用清华源 "
    all="全部 "
    embellish_terminal="美化终端 "
    vim="配置vim(spacevim) "
    q="退出"
    re_input="请输入正确的指令"
    return="返回"
    thank="感谢使用"
    source_its_pointless="加一个源以安装更多软件"
    soft_keyboard="使用完整的软键盘"
    rst="请重启termux"
    wahtset1="现在你可以使用"
    wahtset2="来启动"
    myupdate="更新一切"
    theone
}
function setsomething
{
    echo '#!/bin/bash' > $PREFIX/bin/$1
    something=$2" "$mypath"/"$3" "\$\*
    echo $something
    echo "$something" >> $PREFIX/bin/$1
    chmod 777 $PREFIX/bin/$1
    setok=$wahtset1$1$wahtset2$1
    echo -e "$color1 $setok"
    sleep 3
}
function getnothing
{
    git clone $1 $mypath/$2
}
function interesting_things()
{
    logo
    line
    echo -e "$color1[1]cmatrix       |[18]screenfetch"
    echo -e "$color2[2]sl            |[19]fortune"
    echo -e "$color2[3]figlet        |[20]factor"
    echo -e "$color3[4]toilet        |[21]nsnake"
    echo -e "$color3[5]moon-buggy    |[22]cal"
    echo -e "$color3[6]asciimap      |[23]pv"
    echo -e "$color4[7]tree          |[24]2048"
    echo -e "$color4[8]cowsay        |[25]bastet"
    echo -e "$color4[9]nyancat       |[26]greed"
    echo -e "$color4[10]htop         |[27]pacman4console"
    echo -e "$color5[11]nethack      |[28]angband"
    echo -e "$color5[12]weather      |[29]curseofwar" 
    echo -e "$color5[13]gnushogi     |[30]brogue" 
    echo -e "$color5[14]gnugo        |[31]moria" 
    echo -e "$color5[15]nudoku       |[32]blessed-contrib" 
    echo -e "$color5[16]ninvaders    |[33]doge" 
    echo -e "$color6[17]pokemonsay   |[520]$return" 
    line
    inp
    read hw
    case $hw in
    1) pkg in cmatrix -y
    interesting_things
    ;;
    2) pkg in sl -y
    sl
    interesting_things
    ;;
    3) pkg in figlet -y
    figlet installed
    interesting_things
    ;;
    4) pkg in toilet -y 
    toilet -f mono12 -F gay ok
    interesting_things
    ;;
    5) pkg in moon-buggy -y
    moon-buggy
    interesting_things
    ;;
    6) cd
    pkg in nodejs -y
    npm install mapscii -g
    interesting_things
    ;;
    7) pkg in tree -y
    tree
    interesting_things
    ;;
    8) pkg in cowsay -y
    cowsay ok
    interesting_things
    ;;
    9) pkg in nyancat -y
    interesting_things
    ;;
    10) pkg in htop -y
    interesting_things
    ;;
    11) apt install nethack -y
    interesting_things
    ;;
    12) curl wttr.in
    interesting_things
    ;;
    13) apt install gnushogi -y
    interesting_things
    ;;
    14) apt install gnugo -y
    interesting_things
    ;;
    15) apt install nudoku -y
    interesting_things
    ;;
    16) git clone https://github.com/TheZ3ro/ninvaders.git
    apt install ncurses* clang -y
    cd ninvaders
    ./configure
    make
    cp nInvaders $PREFIX/bin
    cd
    rm -rf ninvaders
    interesting_things
    ;;
    17) getnothing https://github.com/possatti/pokemonsay.git pokemonsay
    pkg install clang -y
	  pkg in cowsay -y
    setsomething pokemonsay bash pokemonsay/pokemonsay.sh
    sed -i "s/\`pwd\`/\/data\/data\/com.termux\/files\/usr\/whatandwhy\/pokemonsay/" $PREFIX/whatandwhy/pokemonsay/pokemonsay.sh
    interesting_things
    ;;
    18) apt install screenfetch -y
    interesting_things
    ;;
    19) pkg in fortune -y
    interesting_things
    ;;
    20) pkg insatll coreutils -y
    interesting_things
    ;;
    21) apt install nsnake -y
    interesting_things
    ;;
    22) cal
    interesting_things   
    ;;
    23) pkg in pv
    interesting_things
    ;;
    24) cd
    getnothing https://github.com/mydzor/bash2048.git 2048
    setsomething 2048 bash 2048/bash2048.sh
    interesting_things
    ;;
    25) apt install bastet -y
    interesting_things
    ;;
    26) apt install greed -y
    interesting_things 
    ;;
    27) its
    apt install pacman4console -y
    interesting_things 
    ;;
    28) apt install angband -y
    interesting_things
    ;;
    29) apt install curseofwar -y
    interesting_things
    ;;
    30) apt install brogue -y
    interesting_things
    ;;
    31) apt install moria -y
    interesting_things
    ;;
    32) cd
    apt install nodejs -y
    getnothing https://github.com/yaronn/blessed-contrib.git blessed-contri
    cd blessed-contrib
    npm install
    npm audit fix
    cd
    setsomething blessed node blessed-contri/examples/dashboard.js
    interesting_things
    ;;
    33) pkg in python
	    pip install doge
    interesting_things
    ;;
    520) theone
    ;;
    *)  echo "$re_input"
    interesting_things
    ;;
esac
}
function pentest_tools()
{
    logo
    line
    echo -e "$color1[1]metasploit*   |[16]whatportis"
    echo -e "$color2[2]sqlmap*       |[17]hydra*"
    echo -e "$color2[3]routersploit  |[18]sslscan"
    echo -e "$color3[4]RED_HAWK      |[19]wascan*"
    echo -e "$color3[5]cupp          |[20]termineter"
    echo -e "$color3[6]hash-buster   |[21]nmap*"
    echo -e "$color4[7]D-TECT        |[22]SET"
    echo -e "$color4[8]WPseku        |[23]fimap"
    echo -e "$color4[9]xsstrike      |[24]nikto"
    echo -e "$color4[10]socialfish   |[25]thehavester"
    echo -e "$color5[11]httrack      |[26]commix*"
    echo -e "$color5[12]dirsearch    |[27]spookflare"
    echo -e "$color5[13]fsociety     |[28]xxeinjector" 
    echo -e "$color5[14]inspy        |[29]memcrashed"
    echo -e "$color5[15]weevely      |[30]blackwidow"
    echo -e "$color6[520]$return"
    line
    inp
    read srzl
    case $srzl in
    1) pkg i unstable-repo -y
    pkg in metasploit -y
    pentest_tools
    ;;
    2) p2
    getnothing https://github.com/sqlmapproject/sqlmap.git sqlmap
    setsomething sqlmap python2 sqlmap/sqlmap.py
    pentest_tools
    ;;
    3) p2
    getnothing https://github.com/reverse-shell/routersploit.git routersploit
    plibs2 future requests pysnmp paramiko pycryptodome
    setsomething rsf python2 routersploit/rsf.py
    pentest_tools
    ;;
    4) apt install php -y
    getnothing https://github.com/Tuhinshubhra/RED_HAWK.git RED_HAWK
    setsomething rhawk php RED_HAWK/rhawk.php
    pentest_tools
    ;;
    5) p3
    getnothing https://github.com/Mebus/cupp.git cupp
    setsomething cupp python cupp/cupp.py
    pentest_tools
    ;;
    6) p3 
    getnothing https://github.com/UltimateHackers/Hash-Buster.git Hash
    python -m pip install requests
    setsomething buster python Hash/hash.py
    pentest_tools
    ;;
    7) p2
    https://github.com/bibortone/D-Tech.git D-Tech
    python2 -m pip install BeautifulSoup Colorama
    setsomething d-tect python2 D-Tech/d-tect.py
    pentest_tools
    ;;
    8) p3
    getnothing https://github.com/m4ll0k/WPSeku.git WPSeku
    python -m pip install requests urllib3 humanfriendly
    setsomething wpseku python WPSeku/wpseku.py
    pentest_tools
    ;;
    9) p3
    getnothing https://github.com/UltimateHackers/XSStrike.git XSStrike
    python -m pip install tld fuzzywuzzy requests 
    setsomething xsstrike python XSStrike/xsstrike.py
    pentest_tools
    ;;
    10) p3
    getnothing https://github.com/UndeadSec/SocialFish.git SocialFish
    cd $mypath/SocialFish
    python -m pip install -r requirements.txt
    cd
    setsomething socialfish python SocialFish/SocialFish.py
    pentest_tools
    ;;
    11) pkg i unstable-repo -y
    apt install httrack -y
    pentest_tools
    ;;
    12) p3
    getnothing https://github.com/maurosoria/dirsearch.git dirsearch
    setsomething dirsearch python dirsearch/dirsearch/py
    pentest_tools
    ;;
    13) bash <(wget -qO- https://git.io/vAtmB)
    sed -i ‘s/python/python2/’ $PREFIX/bin/fsociety
    pentest_tools
    ;;
    14) p2
    getnothing https://github.com/leapsecurity/InSpy.git InSpy
    cd $mypath/InSpy
    python2 -m pip install -r requirements.txt
    cd
    setsomething inspy python2 InSpy/InSpy.py
    pentest_tools
    ;;
    15) p2
    getnothing https://github.com/epinna/weevely3.git weevely
    python2 -m pip install prettytable Mako PyYAML python-dateutil PySocks
    apt install readline* openssl* -y
    setsomething weevely python2 weevely/weevely.py
    pentest_tools
    ;;
    16) p2
    python2 pip install whatportis
    pentest_tools
    ;;
    17) pkg in hydra -y
    pentest_tools
    ;;
    18) pkg in sslscan -y
    pentest_tools
    ;;
    19) p2
    getnothing https://github.com/m4ll0k/WAScan.git WAScan
    python2 -m pip install BeautifulSoup
    setsomething wascan python2 WAScan/wascan.py
    pentest_tools
    ;;
    20) python -m pip install termineter
    pentest_tools
    ;;
    21) pkg in nmap -y
    pentest_tools
    ;;
    22) echo "暂时不能安装"
      echo "can not install"
      sleep 5
      pentest_tools
    ;;
    23) p2
    getnothing https://github.com/kurobeats/fimap.git fimap
    setsomething fimap python2 fimap/src/fimap.py
    pentest_tools
    ;;
    24) apt install perl -y
    getnothing https://github.com/sullo/nikto.git nikto
    setsomething nikto perl nikto/nikto.pl
    pentest_tools
    ;;
    25) p3
    getnothing https://github.com/laramies/theHarvester.git theHarvester
    cd $mypath/theHavester
    python -m pip install -r requirements.txt
    cd
    setsomething theHarvester python theHarvester/theHarvester.py
    pentest_tools
    ;;
    26) p2
    getnothing https://github.com/commixproject/commix.git commix
    setsomething commix python2 commix/commix.py
    pentest_tools
    ;;
    27) p3
    getnothing https://github.com/hlldz/SpookFlare.git SpookFlare
    python -m pip install terminaltables
    setsomething spookflare python SpookFlare/spookflare.py
    pentest_tools
    ;;
    28) apt install ruby -y
    getnothing https://github.com/enjoiz/XXEinjector.git XXEinjector
    setsomething XXEinjector ruby XXEinjector/XXEinjector.rb
    pentest_tools
    ;;
    29) p3
    gitnothing https://github.com/649/Memcrashed-DDoS-Exploit.git DDoS
    python -m pip install shodan scapy
    setsomething ddos python DDos/Memcrashed.py
    pentest_tools
    ;;
    30) p3
    getnothing https://github.com/1N3/BlackWidow.git blackwidow
    python -m install coloredlogs beautifulsoup4 requests
    plibs lxml
    setsomething blackwidow python blackwidow/blackwidow
    setsomething injectx python blackwidow/injectx.py
    ;;
    520) theone
    ;;
    *)  echo "$re_input"
    pentest_tools
    ;;
esac
}

function theone()
{
    logo
    line
    echo -e "$color1 [1]$interesting"
    echo -e "$color1 [2]$hack"
    echo -e "$color2 [3]$change_source"
    echo -e "$color3 [4]$embellish_terminal"
    echo -e "$color3 [5]$vim"
    echo -e "$color4 [6]$soft_keyboard"
    echo -e "$color5 [520]$q"
    line
    inp
    read choice
    case $choice in
    1) interesting_things
    ;;
    2) pentest_tools
    ;;
    3) echo "deb http://mirrors.tuna.tsinghua.edu.cn/termux stable main" > $PREFIX/etc/apt/sources.list
    theone
    ;;
    4) pkg in zsh -y
    chsh -s zsh
    wget https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh
    chmod +x install.sh
    ./install.sh
    sed -i "s/agnoster/darkblood/g" .zshrc
    rm -rf install.sh
    echo "$rst"
    ;;
    5) cd
    pkg in vim
    curl -sLf https://spacevim.org/install.sh | bash
    ;;
    6) mkdir -p $HOME/.termux/
    echo "extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" > $HOME/.termux/termux.properties
    echo "$rst"
    ;;
    520) echo "$thank"
    ;;
    *) echo "$re_input"
    theone
    ;;
esac
}


function people()
{
    echo "[1]I know English"
    echo "[2]我懂中文"
    inp
    read peo 
    case $peo in
    1) cd $mypath/other
	    echo "1" > people.txt
	    cd
    English
    ;;
    2) cd $mypath/other
	    echo "2" > people.txt
	    cd
    Chinese
    ;;
    *) echo "please input 1 or 2"
    echo "请输入1或2"
    people
    ;;
    esac
}
function choosepeo()
{
    if cat $mypath/other/people.txt
    then b=`cat $mypath/other/people.txt`
    else
    b=0
    fi
    case $b in
    0) people
    ;;
    1) English
    ;;
    2) Chinese
    ;;
    esac
}

function dependent()
{
    apt upgrade -y
    pkg in curl wget git make -y
    cd $mypath/other
    echo "1" > dependent.txt
    choosepeo
} 

function detectdepend()
{
    if cat $mypath/other/dependent.txt
    then a=`cat $mypath/other/dependent.txt`
    else
    a=0
    fi
    if [ $a == 1 ]
    then
    choosepeo
    else
    dependent
    fi
}
mkdir -p $PREFIX/whatandwhy/other
detectdepend

