" conceal and obscure shell secrets like PGPASSWORD, etc
syn match shSecret /.*\(PASS\|PASSWORD\|KEY\|_PWD\|TOKEN\)=/ nextgroup=shSecretValue
syn match shSecretValue /.*/  contained conceal cchar=🔒
hi shSecretValue ctermfg=red ctermbg=red
highlight Conceal ctermbg=none ctermfg=none
setl conceallevel=2 concealcursor=nv
