" load regular vim custom config
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" neovim stuff here
"

" nvim plugin config
"
" wilder -------------------------------------------------------------------
call wilder#setup({'modes': [':', '/', '?']})
" Default keys
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Down>',
      \ 'previous_key': '<Up>',
      \ 'accept_key': '<Right>',
      \ 'reject_key': '<Left>',
      \ })

" wilder#popupmenu_border_theme() is optional.
" 'min_height' : sets the minimum height of the popupmenu
"              : can also be a number
" 'max_height' : set to the same as 'min_height' to set the popupmenu to a fixed height
" 'reverse'    : if 1, shows the candidates from bottom to top
call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer(),
      \ '/': wilder#wildmenu_renderer(),
      \ }))
" wilder END ---------------------------------------------------------------

" mappings

" TODO: something that loads plugins and runs :UpdateRemotePlugins
