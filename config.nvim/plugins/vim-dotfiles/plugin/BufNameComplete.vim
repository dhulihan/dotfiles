" BufNameComplete.vim: Insert mode completion of filenames loaded in Vim.
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher.
"   - BufNameComplete.vim autoload script
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.00.001	16-Nov-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_BufNameComplete') || (v:version < 700)
    finish
endif
let g:loaded_BufNameComplete = 1

"- mappings --------------------------------------------------------------------

inoremap <silent> <expr> <Plug>(BufNameComplete) BufNameComplete#Expr()
if ! hasmapto('<Plug>(BufNameComplete)', 'i')
    imap <C-x>f <Plug>(BufNameComplete)
endif
