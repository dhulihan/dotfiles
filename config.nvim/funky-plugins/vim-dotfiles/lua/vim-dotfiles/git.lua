local M = {}

M.open_pr_for_commit = function()
	-- Get the current buffer and line number
	local bufnr = vim.api.nvim_get_current_buf()
	local line = vim.api.nvim_win_get_cursor(0)[1]

	-- Get git blame for the current line
	local blame = vim.fn.system(string.format("git blame -L %d,%d %s", line, line, vim.fn.expand("%:p")))

	-- Extract commit hash (first word of git blame output)
	local commit_hash = blame:match("^(%w+)")

	if commit_hash == nil then
		print("No commit hash found for the current line.")
		return
	end

	vim.cmd("!gh pr list --web --state merged --search " .. commit_hash)
end

-- create cmd for above
vim.api.nvim_create_user_command("OpenPRForCommit", M.open_pr_for_commit, {})

return M
