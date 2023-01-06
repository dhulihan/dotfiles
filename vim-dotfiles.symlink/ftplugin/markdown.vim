imap ** <Esc>:MarkdownInternalLink<CR>
imap *& <Esc>:MarkdownExternalLink<CR>
imap *( <Esc>:MarkdownExternalLinkFetchTitle<CR>
imap *^ <Esc>:call mdip#MarkdownClipboardImage()<CR>

" open in browser
nnoremap <Leader>x :MarkdownPreviewToggle<CR>
