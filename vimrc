syntax on
set fileencodings=utf-8,gb2312,gbk,cp936,latin-1
set fileencoding=utf-8
set termencoding=utf-8
set fileformat=unix
set encoding=utf-8
set t_Co=256

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

set hlsearch
set laststatus=2

set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ [POS=%l,%v][%p%%]
set showmatch
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

set scrolloff=2
set backspace=indent,eol,start