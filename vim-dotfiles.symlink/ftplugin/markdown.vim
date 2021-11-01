if exists('g:dotfiles_loaded_markdown')
  finish
endif
let g:dotfiles_loaded_markdown = 1

imap ** <Esc>:MarkdownInternalLink<CR>
imap *& <Esc>:MarkdownExternalLink<CR>

" ------------------------------------------------------------------------------
" MarkdownInternalLink - add link to new/existing markdown file and open
" ------------------------------------------------------------------------------
function! MarkdownInternalLink()
  let l:filename = input("Filename (no ext): ")

  if l:filename == ""
    echoerr "you must provide a filename"
  endif

  let l:name = input("Friendly name (optional): ", l:filename)
  if l:name == ""
    let l:name = l:filename
  endif

  let l:filename = l:filename . ".md"
  let l:line = printf("[%s](%s)", l:name, l:filename)
  let @z = l:line

  " put link
  normal! "zp

  " open file using plasticboy/vim-markdown (which supports autosave)
  normal ge

  " open file classic mode
  "execute 'edit' l:filename
endfunction
command! MarkdownInternalLink call MarkdownInternalLink()

" ------------------------------------------------------------------------------
" MarkdownExternalLink - add link to external URL
" ------------------------------------------------------------------------------
function! MarkdownExternalLink(name)
  let l:url = input("URL: ")

  " get html title
  let l:html_title = SystemChomp("html-title " . l:url)

  let l:title = input("Title: ", l:html_title)
  let l:line = printf("[%s](%s)", l:title, l:url)
  let @z = l:line
  normal! "zp

  " move to title field to fill out
  if l:title == ""
    normal F]
    startinsert
  else
    "normal o
    "startinsert
  endif
endfunction
command! MarkdownExternalLink call MarkdownExternalLink(<q-args>)
