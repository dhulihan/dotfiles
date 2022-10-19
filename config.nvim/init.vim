echom "neovim loaded"
" load regular vim custom config
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" neovim stuff here
"
" recall vundle install again
call vundle#begin()
"" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call vundle#end()            " required
