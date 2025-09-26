if vim.g.neovide then
	vim.o.guifont = "CodeNewRoman Nerd Font:h18" -- text below applies for VimScript
	vim.g.neovide_cursor_animation_length = 0 -- disable cursor animation
	vim.g.neovide_scroll_animation_length = 0 -- disable scroll animation

	--vim.g.neovide_cursor_vfx_mode = "railgun"
	--vim.g.neovide_scroll_animation_length = 0.3
	--
	-- clipboard
	--vim.keymap.set("n", "<D-s>", ":w<CR>") -- Cmd + S to save
	vim.keymap.set("v", "<D-c>", '"+y') -- Cmd + C to copy in visual mode
	vim.keymap.set("n", "<D-v>", '"+P') -- Cmd + V to paste in normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Cmd + V to paste in visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Cmd + V to paste in command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Cmd + V to paste in insert mode
end
