local M = {}

-- Helper to run shell commands asynchronously
local function run_job(cmd, on_exit)
	local handle
	handle = vim.loop.spawn("sh", {
		args = { "-c", cmd },
		stdio = { nil, nil, nil },
	}, function(code, signal)
		if on_exit then
			vim.schedule(function()
				on_exit(code, signal)
			end)
		end
		handle:close()
	end)
end

-- Git commit
local function git_commit(filename)
	local cmd = string.format("git add '%s' && git commit -m '%s'", filename, filename)
	run_job(cmd, function(code, _)
		if code == 0 then
			vim.notify("Git commit successful.", vim.log.levels.INFO)
		else
			vim.notify("Git commit failed.", vim.log.levels.ERROR)
		end
	end)
end

-- Git commit + push
local function git_commit_and_push()
	local cmd = [[git commit -am "Autocommit (on save) @ $(hostname -s)" && git push]]
	run_job(cmd, function(code, _)
		if code == 0 then
			vim.notify("Git commit and push successful.", vim.log.levels.INFO)
		else
			vim.notify("Git commit and push failed.", vim.log.levels.ERROR)
		end
	end)
end

-- Git pull
local function git_pull()
	local output = vim.fn.system("git pull origin master")
	if vim.v.shell_error ~= 0 then
		vim.notify("Git pull failed:\n" .. output, vim.log.levels.ERROR)
	else
		vim.notify("Git pull successful.", vim.log.levels.INFO)
	end
end

local home = vim.env.HOME or os.getenv("HOME")

vim.api.nvim_create_augroup("vim_notes_autogit", { clear = true })

--vim.api.nvim_create_autocmd("BufReadPre", {
--group = "vim_notes_autogit",
--pattern = "~/Notes/**",
--callback = function()
--git_pull()
--end,
--})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = "vim_notes_autogit",
	pattern = home .. "/Notes/**",
	callback = function(event)
		local filename = event.file
		git_commit(filename)
		--git_commit_and_push()
	end,
})

return M
