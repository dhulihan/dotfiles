local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- uncomment to install
--if not (vim.uv or vim.loop).fs_stat(lazypath) then
--  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
--  if vim.v.shell_error ~= 0 then
--    vim.api.nvim_echo({
--      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
--      { out, "WarningMsg" },
--      { "\nPress any key to exit..." },
--    }, true, {})
--    vim.fn.getchar()
--    os.exit(1)
--  end
--end
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
		path = "~/.config/nvim/funky-plugins",
	},
})
