if vim.g.loaded_vim_notes == 1 then
	return
end

vim.g.loaded_vim_notes = 1

require("vim-notes.autocommit")
