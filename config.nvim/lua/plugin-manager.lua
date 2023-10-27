local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load from lua/plugins dir
require("lazy").setup("plugins", {
	change_detection = {
		notify = false, -- don't notify panes of config change
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
	},
	dev = {
		path = "~/.config/nvim/plugins",
	},
})
