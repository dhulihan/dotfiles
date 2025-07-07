M = {}

--if vim.g.dotfiles_loaded then
--return
--end
--vim.g.dotfiles_loaded = 1

M.replace_bulleted_inline_snippet = function()
	local current_line = vim.api.nvim_get_current_line()
	local new_line = require("vim-dotfiles.convert").convert_bulleted_inline_snippet(current_line)
	vim.api.nvim_set_current_line(new_line)
end

return M
