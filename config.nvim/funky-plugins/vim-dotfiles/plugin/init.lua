local M = {}

vim.api.nvim_create_user_command("OpenPRForCommit", require("vim-dotfiles.git").open_pr_for_commit, {})

return M
