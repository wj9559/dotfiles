set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set nocompatible              "no compatibility with vi

"{{ syntax and colors
syntax on
filetype on
filetype indent on
filetype plugin on
set title
set wrap
set autoindent
set ruler
set showmode
set background=dark
"set number
"set relativenumber
"set mouse=a
"set scrolloff=3

"{{ tabs and spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab                 "将tab转为space,转换正在编辑的文件用 %retab!

"{{ misc
set nolinebreak
set backspace=indent,eol,start
set showmatch
set wildmenu
set autoread                  "文件在vim之外修改后自动重载
set whichwrap=<,>,[,]         "当光标到行首或行尾，允许左右方向键换行
set completeopt=longest,menu  "智能补全,弹出菜单，无歧义时才自动填充 
"colorscheme pablo
"set t_Co=256
"set backspace=2

"{{ search
set ignorecase
set incsearch
set hlsearch
"set nohlsearch
set smartcase
set more
set history=50


"{{ set no bell
set noerrorbells
set visualbell
set t_vb=

"{{ github flavored markdown
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

"{{ 禁止粘贴时自动缩进
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"按键映射的起始字符 
let mapleader = ','
"使用Ctrl-l 和 Ctrl+h 切换标签页  
nnoremap <C-l> gt 
nnoremap <C-h> gT
nnoremap <leader>t : tabe<CR>

"{{ 打开文件回到离开时位置
if has("autocmd")
    "autocmd BufRead *.txt set tw=78
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

"{{ jk移动光标使用视觉行
"vmap j gj
"vmap k gk
"nmap j gj
"nmap k gk

"{{ 自动补全符号
au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap <buffer> {<CR> {<CR>}<Esc>O
au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap " ""<ESC>i
au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap ' ''<ESC>i
