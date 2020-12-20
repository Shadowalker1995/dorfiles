"                                 _
"     ____ ___  __  ___   __(_)___ ___  __________
"   / __ `__ \/ / / / | / / / __ `__ \/ ___/ ___/
"  / / / / / / /_/ /| |/ / / / / / / / /  / /__
" /_/ /_/ /_/\__, / |___/_/_/ /_/ /_/_/   \___/
"             /____/

" Todos
" - vimviki
" Provides a separate terminal in vim <Leader>t
" Plug 'kassio/neoterm'

" Maintainer:       Shadowalker
" Last Change:      2020 Jun 12


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.vim/_machine_specific.vim'))
    let has_machine_specific_file = 0
    exec "!cp ~/.vim/default_configs/_machine_specific_default.vim ~/.vim/_machine_specific.vim"
endif
source ~/.vim/_machine_specific.vim

" ┌──────────────┐
" │ Editor Setup │
" └──────────────┘
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/home/zzhenry/miniconda3/bin/python3'
" ===
" === Editor behavior
" ===
set number
set relativenumber
" 高亮显示当前行/列
set cursorline
"set cursorcolumn

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 使配色更加兼容你的终端
let &t_ut=''

" 设置空格的显示
set list
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:▫

set indentexpr=

" 上下始终各留出4行空间
set scrolloff=4

" Alaways show status bar
set laststatus=2

" Show current cursor position
set ruler

" Window behaviors
set splitright
set splitbelow

" When a line exceeds the limit, it is folded and displayed
set wrap
" 证单词不会被截断而是被完整的显示在下一拆行
set linebreak
set tw=0

" get rid of -- INSERT --
set noshowmode

" 命令模式下显示敲击的命令
set showcmd

" Better display for messages
set cmdheight=2

set nocompatible
set mouse=a
set encoding=utf-8

set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview

set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 取消backup和swap文件
set nobackup
set nowritebackup
set noswapfile

" vim 自身命令行模式智能补全
set wildmenu
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=full

" 解决插入模式下delete/backspce键失效问题
set backspace=indent,eol,start

"set colorcolumn=100
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Rectangular selections can be made in Block Visual Mode
set virtualedit=block

set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
set history=700
set undolevels=700
if has('persistent_undo')
     set undofile
     set undodir=~/.config/nvim/tmp/undo,.
endif

" Cancel the delay of ESC
set timeoutlen=1000 ttimeoutlen=0
" set notimeout

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
set smartcase
" 高亮显示搜索结果
set hlsearch
" 刚进入的时候取消之前的高亮显示
exec "nohlsearch"
" 在搜索的结果中跳转 =:下一个 -:上一个
noremap = nzz
noremap - Nzz
" 取消高亮
noremap <LEADER><CR> :nohl<CR>
vnoremap <LEADER><CR> :nohl<CR>

" Duplicate words
map <leader>fd /\(\<\w\+\>\)\_s*\1

" Space to Tab
"nnoremap <LEADER>tt :%s/     /\t/g
"vnoremap <LEADER>tt :s/     /\t/g

" 基于缩进或语法进行代码折叠
set foldmethod=indent
"set foldmethod=syntax
"set foldmethod=manual
set foldlevel=99
" 启动 vim 时关闭折叠代码
set nofoldenable
set formatoptions-=tc

" always show signcolumns
set signcolumn=yes

" 更棒的复制粘贴
" 粘贴大段代码时 先按 F2,进入`-- INSERT (paste) --`模式
set pastetoggle=<F2>
"set clipboard=unnamedplus

" 设置终端的光标在不同模式下用不同的样式
if !has('nvim')
    let &t_SI.="\e[5 q" "SI = INSERT mode
    let &t_SR.="\e[4 q" "SR = REPLACE mode
    let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
endif
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" vim执行的外部命令会在当前目录下执行
set autochdir

" 启动的时候不显示那个援助乌干达儿童的提示
set shortmess=atI
set shortmess-=F

" don't give |ins-completion-menu| messages.
set shortmess+=c

" 不保存当前buffer也可以打开新的buffer
set hidden

" 进入文件时定位到上一次退出时的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" ===
" === Indent
" ===
" 自适应不同语言的智能缩进
filetype indent on
filetype plugin indent on

" 用space替代tab的输入
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" ===
" === 专注气氛
" ===
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

"let g:bufferline_echo=0

" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
    call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>
"" 启动 vim 时自动全屏
"autocmd VimEnter * call ToggleFullscreen()

" ===
" === Terminal Behaviors
" ===
augroup terminal_settings
    autocmd!

    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert

    " Ignore various filetypes as those will close terminal automatically
    " Ignore fzf, ranger, coc
    autocmd TermClose term://*
        \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") && (expand('<afile>') !~ "python") |
        \   call nvim_input('<CR>')  |
        \ endif
augroup END

let $TERM = "tmux-256color"
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <ESC> <C-\><C-n>
tnoremap <A-[> <ESC>
tnoremap <A-k> <C-\><C-n><C-w>i
tnoremap <A-i> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <A-j> <C-\><C-n><C-w>h
tnoremap <A-Down> <C-\><C-n><C-w>i
tnoremap <A-Up> <C-\><C-n><C-w>k
tnoremap <A-Right> <C-\><C-n><C-w>l
tnoremap <A-Left> <C-\><C-n><C-w>h

let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'


" ┌────────────────┐
" │ Editor Mapping │
" └────────────────┘
" ===
" === Basic Mappings
" ===
let mapleader=";"
let maplocalleader = ","
" map ' for going to next char
noremap ' ;
" map " for going to previous char
noremap " ,

" INSERT MODE
noremap n i
noremap N I

" map s to NONE
map s <nop>
"noremap z s

" make Y to copy till the end of the line
nnoremap Y y$
" Copy to system clipboard
vnoremap <Leader>y "+y
" paste from the system clipboard to vim
nmap <Leader>p "+p

" 数字自增和自减
"nn <C-g> <C-a>
nn <C-d> <C-x>

" INSERT模式下的直接撤销
inoremap <C-u> <C-o>u
"inoremap <C-r> <C-o><C-r>

" easier moving of code blocks
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation
nnoremap < <<
nnoremap > >>

" map R to source vimrc directly
map R :w<CR>:source $MYVIMRC<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" ===
" === Save & Quit
" ===
"map ; :
map q; q:

" Close current split window
nmap <Leader>q :BD<CR>
" Save the current window
nmap <Leader>w :w<CR>
" Save all windows and quit
nmap <Leader>WQ :wa<CR>:qa<CR>
" Quit vim without saving
nmap <Leader>Q :qa!<CR>
noremap <C-q> :q<CR>

" Quick save
noremap <C-z> :update<CR>
vnoremap <C-z> <C-C>:update<CR>
inoremap <C-z> <C-O>:update<CR>

" ===
" === Cursor Movement
" ===
" new cursor movement
"        ^
"        i
" < j        l >
"        k
noremap <silent> j h
noremap <silent> k j
noremap <silent> i k
noremap <silent> l l
noremap <silent> gi gk
noremap <silent> gk gj

noremap <silent> zk zj
noremap <silent> zi zk

noremap <silent> I 5k
noremap <silent> K 5j
noremap W 5W
noremap B 5B

" J: go to the start of the line
noremap <silent> J 0
" L: go to the end of the line
noremap <silent> L $

" set h (same as n, cursor left) to 'end of word'
noremap h e

" Ctrl + I or K will move up/down the view port without moving the cursor
"noremap <C-I> 5<C-y>
"noremap <C-k> 5<C-e>

" Insert Mode Cursor Movement
inoremap <C-e> <ESC>A
imap <C-a> <ESC>N

" Command Mode Cursor Movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-j> <Left>
cnoremap <C-l> <Right>
cnoremap <M-j> <S-Left>
cnoremap <M-l> <S-Right>

" ===
" === Window management
" ===
" s+jkli split
map sl :set splitright<CR>:vsplit<CR>
map sj :set nosplitright<CR>:vsplit<CR>
map si :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>

" reshape the split size
map <Leader>si :res +5<CR>
map <Leader>sk :res -5<CR>
map <Leader>sj :vertical resize-5<CR>
map <Leader>sl :vertical resize+5<CR>

" switch between windows
noremap <LEADER>k <c-w>j
noremap <LEADER>i <c-w>k
noremap <LEADER>l <c-w>l
noremap <LEADER>j <c-w>h

noremap <C-w>k <c-w>j
noremap <C-w>i <c-w>k
noremap <C-w>l <c-w>l
noremap <C-w>j <c-w>h

noremap <C-w><C-k> <c-w>j
noremap <C-w><C-i> <c-w>k
noremap <C-w><C-l> <c-w>l
noremap <C-w><C-j> <c-w>h

"noremap <A-Down> <c-w>j
"noremap <A-Up> <c-w>k
"noremap <A-Right> <c-w>l
"noremap <A-Left> <c-w>h
" Traverse between windows
noremap sw <C-W><C-W>
" Clsoe the current window
noremap sd :close<CR>

" Place the two screens up and down
map sh <C-w>t<C-w>K
" Place the two screens side by side
map sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" ===
" === Tab Management
" ===
" open a new tab
noremap <silent> tn :tabe<CR>
" switch to previous tab
nnoremap <silent> <C-[> :-tabnext<CR>
nnoremap <silent> tj :-tabnext<CR>
" switch to next tab
noremap <silent> <C-]> :+tabnext<CR>
noremap <silent> tl :+tabnext<CR>
" close current tab
noremap <silent> td :tabclose<CR>
" Move the tabs with tmn and tmi
noremap <silent> tmj :-tabmove<CR>
noremap <silent> tml :+tabmove<CR>

" ===
" === Buffer Management
" ===
" switch to next buffer
nnoremap <silent> <C-l> :bn<CR>
" switch to previous buffer
nnoremap <silent> <C-j> :bp<CR>
" Move forwards through recently accessed buffers
nnoremap <silent> <C-Right> :BF<CR>
" Move backwards through recently accessed buffers
nnoremap <silent> <C-Left> :BB<CR>
nnoremap <silent> <C-A> :BA<CR>
" switch to first buffer
nnoremap <silent> [b :bfirst<CR>
" switch to last buffer
nnoremap <silent> ]b :blast<CR>

" ===
" === Other Useful Stuff
" ===
" find and replace
noremap \s :%s//g<left><left>

" Press ` to change case (instead of ~)
map ` ~

map <LEADER>/ :!
map <LEADER>r :r !
map <LEADER>sr :%s/

imap <C-s> <Esc>zza
nmap <C-s> zz

" Press space twice to jump to the next '<++>' and edit it
noremap <Leader><Leader> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" Open a new instance of st with the cwd
nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'alacritty'<CR><C-\><C-N>:q<CR>

" Move to the Error location
noremap <LEADER>- :lN<CR>
noremap <LEADER>= :lne<CR>

" Call figlet
map fl :r !figlet -f slant 

" Format Python code based on PEP8
map <C-A-F> :Format<CR>
inoremap <C-A-F> <C-o>:Format<CR>

" Spelling
map <Leader>sc :set spell!<CR>
inoremap <Leader>sc <Esc>:set spell!<CR>A
noremap <C-x> ea<C-x>s
inoremap <C-x> <Esc>bea<C-x>s

" 启用:Man命令查看各类man信息
source $VIMRUNTIME/ftplugin/man.vim
" 定义:Man命令查看各类man信息的快捷键
nmap <Leader>man :Man 3 <cword><CR>

" 在命令提示符后输入%%时,自动展开为活动缓冲区所在目录的路径
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

" ===
" === Function
" ===
" Compile and Run function
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        set splitbelow
        exec "!g++ -std=c++11 % -Wall -o %<"
        :sp
        :res +15
        :term time ./%<
    elseif &filetype == 'java'
        set splitbelow
        exec "!javac %"
        :sp
        :res +15
        :term time java %<
        "exec "!time java %"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        ":CocCommand python.execInTerminal
        set splitbelow
        :sp
        :res +15
        :term python %
    elseif &filetype == 'html'
        exec "!google-chrome-stable % &"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'vimwiki'
        exec "MarkdownPreview"
    elseif &filetype == 'tex'
        silent! exec "VimtexStop"
        silent! exec "VimtexCompile"
    elseif &filetype == 'dart'
        CocCommand flutter.run -d iPhone\ 11\ Pro
        CocCommand flutter.dev.openDevLog
    elseif &filetype == 'javascript'
        set splitbelow
        :sp
        :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
        elseif &filetype == 'go'
        set splitbelow
        :sp
        :term go run .
    endif
endfunc
map <F5> :call CompileRunGcc()<CR>

nmap <space>r :CocCommand python.execInTerminal<CR>

" Debug
func! Rungdb()
     exec "w"
     exec "!g++ % -g -o %<"
     exec "!gdb ./%<"
endfunc
map <F8> :call Rungdb()<CR>

"map R :call CompileBuildrrr()<CR>
"func! CompileBuildrrr()
  "exec "w"
  "if &filetype == 'vim'
     "exec "source $MYVIMRC"
  "elseif &filetype == 'markdown'
     "exec "echo"
  "endif
"endfunc


" ┌────────────────┐
" │ Plugin Install │
" └────────────────┘
call plug#begin('~/.vim/bundle')
Plug 'qpkorr/vim-bufkill'
" ===
" === REPL
" ===
Plug 'hkupty/iron.nvim'
    let g:iron_map_defaults = 0
    nmap <localleader>s    <Plug>(iron-send-motion)
    vmap <localleader>s    <Plug>(iron-visual-send)
    nmap <localleader>r    <Plug>(iron-repeat-cmd)
    nmap <localleader>l    <Plug>(iron-send-line)
    nmap <localleader><CR> <Plug>(iron-cr)
    nmap <localleader>i    <plug>(iron-interrupt)
    nmap <localleader>q    <Plug>(iron-exit)
    nmap <localleader>c    <Plug>(iron-clear)
"Plug 'sillybun/vim-repl'
    "let g:repl_ipython_version = '7.13'
    "let g:repl_program = {
                   "\   'python': ['ipython'],
                   "\   'default': ['zsh'],
                   "\   'r': ['R'],
                   "\   'lua': ['lua'],
                   "\   'vim': ['vim -e'],
                   "\   }
    "let g:repl_predefine_python = {
                   "\   'numpy': 'import numpy as np',
                   "\   'matplotlib': 'from matplotlib import pyplot as plt'
                   "\   }
    "let g:repl_cursor_down = 1
    "let g:repl_python_automerge = 1
    "let g:repl_ipython_version = '7'
    "nnoremap <Space>r :REPLToggle<Cr>
    "autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
    "autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
    "autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
    "let g:repl_position = 3

    "let g:repl_width = 80                                 "窗口宽度
    ""let g:repl_height = None                                "窗口高度
    "let g:sendtorepl_invoke_key = "<Space>w"            "传送代码快捷键，默认为<leader>w
    "let g:repl_position = 3                                    "0表示出现在下方，1表示出现在上方，2在左边，3在右边
    "let g:repl_stayatrepl_when_open = 1           "打开REPL时是回到原文件（1）还是停留在REPL窗口中（0）
"Plug 'hkupty/iron.nvim'
Plug 'jpalardy/vim-slime'
    "let g:slime_target = "neovim"
    let g:slime_target = "tmux"
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
    let g:slime_python_ipython = 1
    "let g:slime_paste_file = "~/.slime_paste"
    let g:slime_python_ipython = 1

" ===
" === Auto Complete
" ===
"Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ===
" === Beautify
" ===
Plug 'connorholyday/vim-snazzy'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
    "let g:airline_disable_statusline = 1

    let g:airline#extensions#coc#enabled = 1
    let g:airline_powerline_fonts = 1
    "let g:airline_theme="luna"
    " 开启tabline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#buffer_nr_show = 1
    " unicode symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = '»'
    let g:airline_right_sep = '«'
    let g:airline#extensions#tabline#fnamemod = ':t'

    let g:airline#extensions#whitespace#enabled = 1
    let g:airline#extensions#whitespace#symbol = '!'
    let g:airline#extensions#whitespace#mixed_indent_algo = 1

    function! CocMinimalStatus() abort
        return get(b:, 'coc_current_function', '')
    endfunction

    function! AirlineInit()
        let g:airline_section_a = airline#section#create(['mode'])
        let g:airline_section_b = airline#section#create_left(['hunks', 'branch', '%-0.20{getcwd()}'])
        let g:airline_section_c = airline#section#create(['%f'])
        let g:airline_section_x = airline#section#create(['%{CocMinimalStatus()}   ','filetype'])
        let g:airline_section_y = airline#section#create(['ffenc'])
        "let g:airline_section_y = airline#section#create(['%{strftime("%m/%d - %H:%M")} ', 'ffenc'])
    endfunction
    autocmd User AirlineAfterInit call AirlineInit()
    "let g:airline_section_b = '%{strftime("%m/%d/%y - %H:%M")}'
    "let g:airline_section_c = '%t'
Plug 'vim-airline/vim-airline-themes'
"Plug 'NLKNguyen/papercolor-theme'
Plug 'ayu-theme/ayu-vim'
"Plug 'octol/vim-cpp-enhanced-highlight'


" ===
" === Other Visual Enhancement
" ===
Plug 'kien/rainbow_parentheses.vim'
     let g:rbpt_colorpairs = [
                               \ ['brown',        'RoyalBlue3'],
                               \ ['Darkblue',     'SeaGreen3'],
                               \ ['darkgray',     'DarkOrchid3'],
                               \ ['darkgreen',   'firebrick3'],
                               \ ['darkcyan',     'RoyalBlue3'],
                               \ ['darkred',      'SeaGreen3'],
                               \ ['darkmagenta', 'DarkOrchid3'],
                               \ ['brown',        'firebrick3'],
                               \ ['gray',          'RoyalBlue3'],
                               \ ['darkmagenta', 'DarkOrchid3'],
                               \ ['Darkblue',     'firebrick3'],
                               \ ['darkgreen',   'RoyalBlue3'],
                               \ ['darkcyan',     'SeaGreen3'],
                               \ ['darkred',      'DarkOrchid3'],
                               \ ['red',           'firebrick3'],
                               \ ]
     let g:rbpt_max = 16
     let g:rbpt_loadcmd_toggle = 0
     au VimEnter * RainbowParenthesesToggle
     au Syntax * RainbowParenthesesLoadRound
     au Syntax * RainbowParenthesesLoadSquare
     au Syntax * RainbowParenthesesLoadBraces
Plug 'Yggdroot/indentLine' " display the indention levels with thin vertical lines
Plug 'itchyny/vim-cursorword' " Underlines the word under the cursor
Plug 'tmhedberg/SimpylFold'
     " Preview docstring in fold text
     let g:SimpylFold_docstring_preview = 1


" ===
" === File Navigation
" ===
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
     " 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
     nmap <Leader>fl :NERDTreeToggle<CR>
     " 设置 NERDTree 子窗口宽度
     let NERDTreeWinSize=22
     " 设置 NERDTree 子窗口位置
     let NERDTreeWinPos="right"
     " 显示隐藏文件
     let NERDTreeShowHidden=1
     " NERDTree 子窗口中不显示冗余帮助信息
     let NERDTreeMinimalUI=1
     " 删除文件时自动删除文件对应 buffer
     let NERDTreeAutoDeleteBuffer=1
     let NERDTreeMapOpenExpl = ""
     let NERDTreeMapUpdir = ""
     let NERDTreeMapUpdirKeepOpen = "u"
     let NERDTreeMapOpenSplit = "s"
     let NERDTreeOpenVSplit = "v"
     let NERDTreeMapActivateNode = "l"
     let NERDTreeMapPreview = ""
     let NERDTreeMapCloseDir = "j"
     let NERDTreeMapChangeRoot = "o"
     autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
Plug 'Xuyuanp/nerdtree-git-plugin'
     let g:NERDTreeIndicatorMapCustom = {
          \ "Modified"  : "✹",
          \ "Staged"     : "✚",
          \ "Untracked" : "✭",
          \ "Renamed"   : "➜",
          \ "Unmerged"  : "═",
          \ "Deleted"   : "✖",
          \ "Dirty"      : "✗",
          \ "Clean"      : "✔︎",
          \ "Unknown"   : "?"
          \ }
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
     map <C-p> :CtrlP<CR>
     let g:ctrlp_clear_cache_on_exit = 0
     let g:ctrlp_prompt_mappings = {
       \ 'PrtSelectMove("j")':   ['<c-k>', '<down>'],
       \ 'PrtSelectMove("k")':   ['<c-i>', '<up>'],
       \ }
     " let g:ctrlp_max_height = 30
     set wildignore+=*.pyc
     set wildignore+=*_build/*
     set wildignore+=*/coverage/*
     let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
     let g:ctrlp_max_depth = 10
     let g:ctrlp_lazy_update = 0
     let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*' " MacOSX/Linux


" ===
" === Undo Tree
" ===
Plug 'mbbill/undotree'
     let g:undotree_DiffAutoOpen = 0
     nmap U :UndotreeToggle<CR>


" ===
" === Tagbar
" ===
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }
     " 设置 tagbar 子窗口的位置出现在主编辑区的左边
     let tagbar_left=1
     " 设置显示／隐藏标签列表子窗口的快捷键
     map <silent> T :TagbarOpenAutoClose<CR>
     " 设置标签子窗口的宽度
     let tagbar_width=32
     " tagbar 子窗口中不显示冗余帮助信息
     let g:tagbar_compact=1
     " 设置 ctags 对哪些代码标识符生成标签
     let g:tagbar_type_cpp = {
           \ 'ctagstype' : 'c++',
           \ 'kinds'      : [
                \ 'c:classes:0:1',
                \ 'd:macros:0:1',
                \ 'e:enumerators:0:0',
                \ 'f:functions:0:1',
                \ 'g:enumeration:0:1',
                \ 'l:local:0:1',
                \ 'm:members:0:1',
                \ 'n:namespaces:0:1',
                \ 'p:functions_prototypes:0:1',
                \ 's:structs:0:1',
                \ 't:typedefs:0:1',
                \ 'u:unions:0:1',
                \ 'v:global:0:1',
                \ 'x:external:0:1'
           \ ],
           \ 'sro'          : '::',
           \ 'kind2scope' : {
                \ 'g' : 'enum',
                \ 'n' : 'namespace',
                \ 'c' : 'class',
                \ 's' : 'struct',
                \ 'u' : 'union'
           \ },
           \ 'scope2kind' : {
                \ 'enum'       : 'g',
                \ 'namespace' : 'n',
                \ 'class'      : 'c',
                \ 'struct'     : 's',
                \ 'union'      : 'u'
           \ }
     \ }


" ===
" === Git
" ===
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }


" ===
" === HTML, CSS, JavaScript, PHP, JSON, etc.
" ===
"Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
"Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'mattn/emmet-vim'


" ===
" === Markdown
" ===
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() } }
     let g:mkdp_auto_start = 0
     let g:mkdp_auto_close = 1
     let g:mkdp_refresh_slow = 0
     let g:mkdp_command_for_global = 0
     let g:mkdp_open_to_the_world = 0
     let g:mkdp_open_ip = ''
     let g:mkdp_browser = 'google-chrome-stable'
     let g:mkdp_echo_preview_url = 1
     let g:mkdp_browserfunc = ''
     let g:mkdp_preview_options = {
          \ 'mkit': {},
          \ 'katex': {},
          \ 'uml': {},
          \ 'maid': {},
          \ 'disable_sync_scroll': 0,
          \ 'sync_scroll_type': 'middle',
          \ 'hide_yaml_meta': 1,
          \ 'sequence_diagrams': {},
          \ 'flowchart_diagrams': {}
          \ }
     let g:mkdp_markdown_css = ''
     let g:mkdp_highlight_css = ''
     let g:mkdp_port = ''
     let g:mkdp_page_title = '「${name}」'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
     map <LEADER>tm :TableModeToggle<CR>
Plug 'vimwiki/vimwiki'
     let g:vimwiki_list = [{
       \ 'automatic_nested_syntaxes':1,
       \ 'path_html': '~/wiki_html',
       \ 'path': '~/wiki',
       \ 'template_path': '~/.vim/vimwiki/template/',
       \ 'syntax': 'markdown',
       \ 'ext':'.md',
       \ 'template_default':'markdown',
       \ 'custom_wiki2html': '~/.vim/vimwiki/wiki2html.sh',
       \ 'template_ext':'.html'
     \}]

     let g:taskwiki_sort_orders={"C": "pri-"}
     let g:taskwiki_syntax = 'markdown'
     let g:taskwiki_markdown_syntax='markdown'
     let g:taskwiki_markup_syntax='markdown'
    let g:vimwiki_global_ext = 0


" ===
" === For General Writing
" ===
Plug 'reedes/vim-wordy' " Uncover usage problems in your writing
Plug 'ron89/thesaurus_query.vim' " Multi-language Thesaurus Query and Replacement plugin for Vim/NeoVim
     let g:tq_language=['en', 'cn']
     let g:tq_enabled_backends=["cilin_txt",
                    \"yarn_synsets",
                    \"openoffice_en",
                    \"mthesaur_txt",
                    \"datamuse_com",
                    \"thesaurus_com",]
     let g:tq_map_keys=0
     let g:tq_online_backends_timeout = 0.4
     nnoremap <Leader>tq :ThesaurusQueryReplaceCurrentWord<CR>
     vnoremap <Leader>tq y:ThesaurusQueryReplace <C-r>"<CR>


" ===
" === Bookmarks
" ===
Plug 'kshenoy/vim-signature'
     " 代码收藏
     let g:SignatureMap = {
               \ 'Leader'                :  "m",
               \ 'PlaceNextMark'       :  "m,",
               \ 'ToggleMarkAtLine'   :  "m.",
               \ 'DeleteMark'           :  "dm",
               \ 'PurgeMarks'           :  "dm/",
               \ 'PurgeMarkers'        :  "dm?",
               \ 'GotoNextLineAlpha'  :  "m<Leader>",
               \ 'GotoPrevLineAlpha'  :  "",
               \ 'GotoNextSpotAlpha'  :  "m<Leader>",
               \ 'GotoPrevSpotAlpha'  :  "",
               \ 'GotoNextLineByPos'  :  "",
               \ 'GotoPrevLineByPos'  :  "",
               \ 'GotoNextSpotByPos'  :  "mn",
               \ 'GotoPrevSpotByPos'  :  "mp",
               \ 'GotoNextMarker'      :  "`n",
               \ 'GotoPrevMarker'      :  "`p",
               \ 'GotoNextMarkerAny'  :  "m]",
               \ 'GotoPrevMarkerAny'  :  "m[",
               \ 'ListBufferMarks'     :  "m/",
               \ 'ListBufferMarkers'  :  "m?"
               \ }

" ===
" === Other Useful Utilities
" ===
"Plug 'terryma/vim-multiple-cursors'
     "let g:multi_cursor_use_default_mapping=0
     "let g:multi_cursor_start_word_key       = '<C-n>'
     "let g:multi_cursor_select_all_word_key = '<A-n>'
     "let g:multi_cursor_start_key             = 'g<C-n>'
     "let g:multi_cursor_select_all_key       = 'g<A-n>'
     "let g:multi_cursor_next_key               = '<C-n>'
     "let g:multi_cursor_prev_key               = '<C-p>'
     "let g:multi_cursor_skip_key               = '<C-x>'
     "let g:multi_cursor_quit_key               = '<Esc>'
Plug 'junegunn/goyo.vim' " distraction free writing mode
     map <LEADER>gy :Goyo<CR>
Plug 'ntpeters/vim-better-whitespace', { 'on': ['EnableWhitespace', 'ToggleWhitespace'] } "displays trailing whitespace (after :EnableWhitespace, vim slows down)
     let g:better_whitespace_enabled=0
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'godlygeek/tabular' " type :Tabularize /= to align the =
Plug 'gcmt/wildfire.vim' "in Visual mode, type n' to select all text in '', or type n) n] n} np
     " This selects the previous closest text object.
     vmap <SPACE><CR> <Plug>(wildfire-water)
     let g:wildfire_objects = ["n'", 'n"', "n)", "n]", "n}", "np", "nt"]
     " 取消高亮
     noremap <LEADER><CR> :nohl<CR>
     vnoremap <LEADER><CR> :nohl<CR>
Plug 'scrooloose/nerdcommenter' " in ;cc to comment a line
Plug 'lilydjwg/fcitx.vim'
Plug 'dyng/ctrlsf.vim'
     " 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
     nnoremap <Leader>sp :CtrlSF<CR>
     let g:ctrlsf_ackprg='ag'


" ===
" === Dependencies
" ===
Plug 'MarcWeber/vim-addon-mw-utils'
call plug#end()


luafile $HOME/.config/nvim/plugins.lua
" ===
" === Beautify My Vim
" ===
" Show whitespace. MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" choose colorscheme
map <LEADER>c1 :set background=dark<CR>:let g:SnazzyTransparent=0<CR>:colorscheme snazzy<CR>:AirlineTheme badwolf<CR>
map <LEADER>c2 :set background=dark<CR>:let ayucolor="mirage"<CR>:colorscheme ayu<CR>:AirlineTheme ayu_dark<CR>
map <LEADER>c3 :set background=light<CR>:let ayucolor="light"<CR>:colorscheme ayu<CR>:AirlineTheme ayu_dark<CR>
map <LEADER>c4 :set background=light<CR>:let ayucolor="dark"<CR>:colorscheme ayu<CR>:AirlineTheme ayu_dark<CR>
map <LEADER>c5 :set background=dark<CR>:colorscheme molokai<CR>:AirlineTheme molokai<CR>
map <LEADER>c6 :set background=dark<CR>:colorscheme gruvbox<CR>:AirlineTheme badwolf<CR>
map <LEADER>c7 :set background=light<CR>:colorscheme gruvbox<CR>:AirlineTheme badwolf<CR>
map <LEADER>c8 :set background=dark<CR>:let g:SnazzyTransparent=1<CR>:colorscheme snazzy<CR>:AirlineTheme badwolf<CR>

" global setting for colorscheme and AirlineTheme
set termguicolors      " enable true colors support
colorscheme snazzy
let g:airline_theme='badwolf'
set background=dark
" 设置 gvim 显示字体
set guifont=Ubuntu\ Mono\ derivative\ Powerline.ttf
"set guifont=UbuntuMonoDerivativePowerline-Patched.ttf

" molokai config
let g:airline_molokai_bright = 1
"let g:rehash256 = 1

" ruvbox config convert
let g:gruvbox_italic=1
let g:grubvbox_termcolors='256'
let g:grubvbox_contrast_light = 'soft'


" ===
" === Configure coc
" ===
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-snippets', 'coc-yank', 'coc-gitignore', 'coc-stylelint', 'coc-tslint', 'coc-lists', 'coc-git', 'coc-explorer', 'coc-translator', 'coc-flutter', 'coc-todolist', 'coc-yaml', 'coc-tasks', 'coc-actions', 'coc-diagnostic', 'coc-prettier', 'coc-syntax', 'coc-cmake', 'coc-markdownlint', 'coc-pairs', 'coc-java']

" fix the most annoying bug that coc has
silent! au BufEnter,BufRead,BufNewFile * silent! unmap if

" Add (Neo)Vim’s native statusline support.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ "\<TAB>"
inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

" Use <cr> to confirm completion, `<C-y>` means break undo chain at current
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use <c-space> to cancel completion.
inoremap <expr> <c-space> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Text Objects
xmap nf <Plug>(coc-funcobj-i)
omap nf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap nc <Plug>(coc-classobj-i)
omap nc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Useful commands
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" Use H to show documentation in preview window
nnoremap <silent> H :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
     execute 'h '.expand('<cword>')
  else
     call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap ff :CocCommand explorer<CR>
" Use preset argument to open it
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>

" coc-translator
nmap <leader>t <Plug>(coc-translator-p)
vmap <leader>t <Plug>(coc-translator-pv)

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" coctodolist
nnoremap <leader>tn :CocCommand todolist.create<CR>
nnoremap <leader>tl :CocList todolist<CR>
nnoremap <leader>tu :CocCommand todolist.download<CR>:CocCommand todolist.upload<CR>
" coc-tasks
noremap <silent> <leader>T :CocList tasks<CR>

autocmd FileType json syntax match Comment +\/\/.\+$+

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" set CTRL-S for selections ranges.
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>k :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>i :<C-u>CocPrev<CR>
" RResume latest coc list.
nnoremap <silent> <space>p :<C-u>CocListResume<CR>
" Clipboard History
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>


" ===
" === Shortcuts Cheat Table
" ===
" n:          插入模式
" N:          行首插入模式
" A:          行位插入模式
" cw:        删除当前word并进入插入模
" x:          删除一个word
" o:          在下方插入一行并进入插入模式
" O:          在上发插入一行并进入插入模式
" u:          撤销
" CTRL-r:   重做 NORMAL模式/INSERT模式
" CTRL-u:   INSERT模式下的直接撤销
" CTRL-o:   NORMAL: 光标跳到上一次停留位置
"             INSERT: 临时回到NORMAL模式-(INSERT)
" CTRL-i:   光标跳到下一次停留位置
" CTRL-a:   go to the start of the line
" CTRL-e:   go to the end of the line
" ;y:        复制到系统剪贴板
" ;p:        粘贴系统剪贴板的内容
" >>:        向右缩进
" <<:        向左缩进
" ;q:        关闭当前窗口
" ;w:        保存当前窗口
" ;WQ        保存所有窗口并退出
" ;Q          保存当前窗口并退出
" CTRL-z:   快速保存当前窗口
" CTRL-c:   强制当前行在屏幕中间显示
" ;man:      查看当前word的man信息
" ;vim:      在新tab中打开 vimrc 文件
" CTRL-f:   格式化Python代码
" Space-r:  打开repl
" Space-w:  发送这一行代码到repl
" ;tm:       写Markdown文件时打开table-mode
" ;fl:       打开NERDTree fl - file list
" U:          打开Undotree
" ;gy:       进入Goyo专注模式
" T:          打开Tagbar并自动关闭
" F5:        运行代码
" F8:        调试代码
" F11:       全屏
" F2:        进入`-- INSERT (paste) --`模式
" R:          source vimrc 文件
" CTRL-g:   数字自增
" CTRL-d:   数字自减
" ===分屏
" s+jkli:   分屏
" ;+jkli:   调整分屏大小
" SPACE-jkli: 在分屏窗口之间跳转
" sw:        遍历分屏窗口
" sv:        换为水平分屏 即分屏线为竖直的
" sh:        换为垂直分屏 即分屏线为水平的
" ===tab
" tn:        新建一个tab
" CTRL-Left:  上一个tab
" CTRL-Right: 下一个tab
" td:        关闭当前tab
" ===高亮
" -:          跳到上一个搜索结果
" =:          跳到下一个搜索结果
" ;+Enter:  取消搜索结果高亮
" ===主题
" ;c1-8:     选择不同的主题 1: snazzy
"                              2: ayu-mirage
"                              3: ayu-light
"                              4: ayu-dark
"                              5: molokai
"                              6: gruvbox-dark
"                              7: gruvbox-light
"                              8: snazzy-transparent

" q;:        打开命令历史记录窗口
" ;/          快速开始输入系统命令
" ;sr:       快速开始进入替换命令 search replace
" SPACE+SPACE:  按下两个空格跳到下一个'<++>'并进行编辑 '<++>'是placeholder
" fl:        figlet
" ;sc:       打开拼写检查
" CTRL-x:   给出当前word的拼写建议
" ;fd:       find duplicate word
" ;tq:       查看同义词
" ===jedi-vim
" ;d:        Go to definition
" ;g:        Go to assignment
" ;s:        Finds the stub of the function/class under the cursor
" ;r:        Rename variables
" ;n:        打开一个quickfix窗口显示指向光标所在变量的定义处
" ===python-mode
" [[:        Jump to previous class or function (normal, visual, operator modes)
" ]]:        Jump to next class or function  (normal, visual, operator modes)
" [M:        Jump to previous class or method (normal, visual, operator modes)
" ]M:        Jump to next class or method (normal, visual, operator modes)
" aC:        Select a class. Ex: vaC, daC, yaC, caC (normal, operator modes)
" iC:        Select inner class. Ex: viC, diC, yiC, ciC (normal, operator modes)
" aM:        Select a function or method. Ex: vaM, daM, yaM, caM (normal, operator modes)
" iM:        Select inner function or method. Ex: viM, diM, yiM, ciM (normal, operator modes)
" ":          show python documentation by 'pydoc'
" ;b:        automatically set breakpoints
" CTRL-C+d: Show documentation for object under cursor
" ===YCM
" gd:        GoToDefinitionElseDeclaration
" g/:        GetDoc
" gt:        GetType
" gr:        GoToReferences
" ;;:        调出OmniCppComplete 补全引擎
" CTRL-y:   停止显示补全列表(防止列表影响视野)
" Ctrl-n:   弹出列表时选择后一项
" CTRL-p:   弹出列表时选择前一项
" ===vim-signature
" m+字母:     创建Mark
" m+数字:     创建Marker
" m,:        自动以下一个字母创建Marks
" m;:        按照字母顺序跳到下一个Mark
" mn:        按照位置顺序跳到下一个Mark
" mp:        按照位置顺序跳到上一个Mark
" `n:        跳到上一个相同的Marker
" `p:        跳到下一个相同的Marker
" m]:        跳到下一个任意Marker
" n[:        跳到上一个任意Marker
" m/:        列出所有Marks
" m?:        列出所有Markers
" dm+数字:   删除Mark
" dm/:       删除所有Marks
" dm?:       删除所有Markers
" m<S-数字>: 删除所有当前类型的Markers
" ===multiple-cursors
" CTRL-n:   start multicursor and add a virtual cursor + visual selection on the match
"             add a new virtual cursor + visual selection on the next match
" CTRL-x:   skip the next match
" CTRL-p:   remove current virtual cursor + visual selection and go back on previous match
"
" :w !sudo tee %  当前用户没有保存权限时直接调用sudo保存文件的命令
" :%TOhtml          将当前文件转换为.html文件
" :MarkdownPreview  打开浏览器实时Markdown文件渲染
" Move the next character to the end of the line with ctrl+9
