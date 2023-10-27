-- Persist undos, incompatible with vim
vim.opt.undodir = vim.fn.expand("$HOME/.nvim/undo") -- mkdir this if you need to
vim.opt.undofile = true
