" conceal and obscure shell secrets like PGPASSWORD, etc
syn match shSecret /.*\(PASS\|password\|PASSWORD\|KEY\|_PWD\|TOKEN\)=/ nextgroup=shSecretValue
syn match shSecretValue /.*/  contained conceal cchar=🔒
hi shSecretValue ctermfg=red ctermbg=red
highlight Conceal ctermbg=none ctermfg=none

" WARNING: syntax highlighters like those in vim-markdown will load this for
" syntax highlight, which may affect the whole buffer's configuration (eg
" setting high conceal level on a markdown file that contains fenced sh code
" blocks), so we add an extra check here that the filetype is sh
if &filetype ==# 'sh'
  setl conceallevel=2 concealcursor=nv
endif
