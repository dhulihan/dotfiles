if exists('g:dotfiles_loaded')
  finish
endif
let g:dotfiles_loaded = 1

" ------------------------------------------------------------------------------
" Reload - allow for reloading of dotfiles vimscript
" ------------------------------------------------------------------------------
function! Reload()
  " TODO: use a shared data structure here that any plugin file can append to
  if exists('g:dotfiles_loaded')
    unlet g:dotfiles_loaded
  endif

  if exists('g:dotfiles_loaded_markdown')
    unlet g:dotfiles_loaded_markdown
  endif

  if has('nvim')
    "echom "neovim detected, reloading init.vim"
    source ~/.config/nvim/init.vim

    " install plugins
    PlugInstall
    UpdateRemotePlugins
  else
    source ~/.vimrc

    " install plugins
    PlugInstall
  endif

  UltiSnipsReload

  " todo reload plugin
endfunction
command! Reload call Reload()
