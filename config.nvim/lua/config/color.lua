vim.opt.background = "dark"

-- Color scheme selection (uncomment one)
vim.cmd("colorscheme doom-one")
-- vim.cmd('colorscheme apprentice')
-- vim.cmd('colorscheme lucius')
-- vim.cmd('colorscheme codedark')
-- vim.cmd('colorscheme vim-material')
-- vim.cmd('colorscheme tokyonight')
-- vim.cmd('colorscheme iceberg')
-- vim.cmd('colorscheme dracula')
-- vim.cmd('colorscheme falcon')
-- vim.cmd('colorscheme jellybeans')
-- vim.cmd('colorscheme hybrid')
-- vim.cmd('colorscheme molokai')
-- vim.cmd('colorscheme blackboard')
-- vim.cmd('colorscheme hemisu')
-- vim.cmd('colorscheme bubblegum')
-- vim.cmd('colorscheme noctu')
-- vim.cmd('colorscheme nefertiti')
-- vim.cmd('colorscheme pencil')
-- vim.cmd('colorscheme badwolf')
-- vim.cmd('colorscheme solarized')

-- if running in Terminal app, use a low-color scheme, since it lies about truecolor
if vim.env.TERM_PROGRAM == "Apple_Terminal" then
	vim.cmd.colorscheme("gruvbox") -- or another low-color scheme
end

-- Cross-scheme colors (dark background)

-- thin line between vsplits
vim.cmd("highlight link WinSeparator VertSplit")

-- doom-one overrides
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#111111" })

--hi VertSplit ctermbg=green guibg=green
--hi StatusLineNC ctermbg=red guibg=red
--hi clear ColorColumn
--highlight Cursor ctermbg=red guibg=#00FF00
--highlight CursorColumn guibg=#303000
--highlight CursorLine guibg=#303000
--hi ColorColumn ctermbg=237
--hi clear SignColumn
--hi clear SpellCap
--hi SpellBad ctermfg=197
--hi clear SpellBad
--hi SpellBad ctermfg=197
--hi clear LineNr
--hi LineNr ctermfg=240
--hi clear Error
--hi Error ctermfg=167
--hi clear GitGutterAdd
--hi GitGutterAdd ctermfg=118
--hi clear GitGutterChange
--hi GitGutterChange ctermfg=186
--hi clear GitGutterDelete
--hi GitGutterDelete ctermfg=1
--hi clear GitGutterChangeDelete
--hi GitGutterChangeDelete ctermfg=166
--
-- lucius color overrides -----
--
-- change default background
--hi Normal ctermbg=234 guibg=#202020
--hi Visual   term=underline ctermbg=18
--hi! VertSplit ctermfg=237 ctermbg=237
--hi! Todo term=standout ctermfg=186 cterm=bold gui=underline guifg=#e0e090
--hi! Error term=standout ctermfg=167 cterm=bold gui=underline guifg=#e37170 ctermbg=NONE
-- -----
--
-- doom-one overrides
--i StatusLine ctermbg=black guibg=#111111
--hi StatusLine ctermbg=black guibg=#282c34
--hi clear StatusLine
--hi! link StatusLine Normal
--hi TabLine     term=bold cterm=bold ctermfg=red ctermbg=053
--hi TabLineFill term=bold cterm=bold ctermfg=green ctermbg=053
--hi TabLineSel  term=bold cterm=bold ctermfg=blue ctermbg=225
--
-- material overrides
--hi! link DiagnosticWarn BufferLineHintDiagnosticSelected
--hi! link ALEWarningSign BufferLineHintDiagnosticSelected
--hi! link SpellBad ErrorMsg
--hi! Search ctermfg=236 ctermbg=172 guifg=bg guibg=#d78700
--
-- apprentice color overrides
--hi! link SignColumn Normal
--hi! link LineNr Comment
--hi TabLine     term=bold cterm=bold ctermfg=225 ctermbg=053
--hi TabLineFill term=bold cterm=bold ctermfg=225 ctermbg=053
--hi TabLineSel  term=bold cterm=bold ctermfg=053 ctermbg=225
--
-- old
--hi! link GitGutterAddDefault String
--hi! link GitGutterChangeDefault Function
--hi! link GitGutterDelete GitGutterDeleteDefault
--hi! link GitGutterChangeDelete GitGutterChangeDeleteDefault
--hi default GitGutterAddDefault ctermbg=234
--
--hi Visual   term=underline ctermbg=238
--hi NonText guifg=#4a4a59
--hi SpecialKey guifg=#4a4a59

-- Optional: enable transparent terminal support
-- vim.g.solarized_termtrans = 1
