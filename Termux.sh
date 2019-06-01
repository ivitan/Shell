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
    echo "------------------------------------------------------------------"
}

function menu() {
    echo
    echo "1.启动空白问候语"
    echo "2.恢复双层键盘"
    echo "3.安装 SSH"
    echo "4.Oh-My-ZSH"
    echo "5.Hexo"
    echo "6.Vim"
    echo "Enter your choice:" 
    echo
    read -n 1 option
}

while [ 1 ]
do
    menu
    case $option in
    0)
        break ;;
    1)
        touch .hushlogin ;;
    2)
        mkdir $HOME/.termux
        echo "extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" >> $HOME/.termux/termux.properties 
        ;;
    3)
        apt install openssh -y
        git config --global user.name "Vitan"
        git config --global user.email "me@vitan.me"
        ssh-keygen -t rsa -C "me@vitan.me" 
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
        ;;
    5)
        pkg install nodejs-lts -y
        git clone -b source  https://github.com/iVitan/ivitan.github.io.git $HOME/hexo
        git clone https://github.com/ivitan/hexo-theme-cutie.git $HOME/hexo/themes/cutie
        cd ~/hexo
        npm i -g hexo-cli 
        npm i hexo-deployer-git --save
        npm un hexo-renderer-marked --save
        npm i hexo-renderer-markdown-it markdown-it-emoji markdown-it-mark markdown-it-deflist markdown-it-container --save
         ;;
    
    6)
        apt install vim -y
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        cat << EOF > ~/.vimrc
" 一般设置
set mouse=a              " 鼠标可用
set relativenumber       " 将行号设置为相对行号
set wildmenu             " 命令行补全参数
filetype on              " 设置开启文件类型侦测
filetype plugin on       " 设置加载对应文件类型的插件
syntax enable            " 开启语法高亮功能
syntax on                " 自动语法高亮
set t_Co=256             " 开启256色支持
set cmdheight=2          " 设置命令行的高度
set showcmd              " select模式下显示选中的行数
set ruler                " 总是显示光标位置
set laststatus=2         " 总是显示状态栏
set number               " 开启行号显示
set cursorline           " 高亮显示当前行
set ttimeoutlen=0        " 设置<ESC>键响应时间
set virtualedit=block,onemore  " 允许光标出现在最后一个字符的后面

" 搜索设置
set hlsearch            " 高亮显示搜索结果
set incsearch           " 开启实时搜索功能
set ignorecase          " 搜索时大小写不敏感

" 编码设置
set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

" 语法高亮
syntax enable
syntax on

hi pythonSelf            ctermfg=174 guifg=#6094DB cterm=bold gui=bold
let python_highlight_all=1
syntax enable

" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

" 增强模式中的命令行自动完成操作
set wildmenu

" 总是显示状态行
set laststatus=2

" 命令行补全参数
set wildmenu

" 设置tab键空4格
set tabstop=4

" 自动检测文件类型
filetype plugin indent on

" 开启自动缩进，智能缩进
set autoindent
set cindent
set smartindent
set shiftwidth=4

" 映射光标在窗口间移动的快捷键
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
call plug#end()

" 基本主题配置
set bg=dark  "设置背景为黑色
colorscheme gruvbox    "设置主题为 gruvbox
set guioptions=        "去掉两边的scrollbar
set guifont=Monaco:h17 "设置字体和字的大小

set incsearch "输入搜索内容时就显示搜索结果
set ignorecase
set hlsearch "搜索时高亮显示被找到的文本

"airline settings
let g:airline_theme = 'simple'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#enabled = 1

" show absolute file path in status line
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

" show tab number in tab line
let g:airline#extensions#tabline#tab_nr_type = 1

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za
EOF
        ;;

    *)
        echo "Sorry wrong selection" ;;
    esac
    echo "Hit any key to continue"
    read -n 1 option 
done

logo
line
menu