-- don't autoreload file changes made outside of vim. prompt.
vim.opt.autoread = false

-- Persist undos, incompatible with vim
vim.opt.undodir = vim.fn.expand("$HOME/.nvim/undo") -- mkdir this if you need to
vim.opt.undofile = true

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Set updatetime to 300ms (0.3 seconds). This will shorten CursorHold time (default 4s)
vim.opt.updatetime = 300

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
function OpenDiagnosticIfNoFloat()
	for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(winid).zindex then
			return
		end
	end
	-- THIS IS FOR BUILTIN LSP
	vim.diagnostic.open_float(0, {
		--scope = "cursor",
		scope = "line",
		focusable = false,
		close_events = {
			"CursorMoved",
			"CursorMovedI",
			"BufHidden",
			"InsertCharPre",
			"WinLeave",
		},
	})
end

-- add border to diagnostics
vim.diagnostic.config({
	float = {
		border = "rounded",
		width = 300,
		padding = 2,
		header = "", -- hide header
		title = "", -- no header at top
		--title_pos = "none",
		prefix = "",
		focusable = false,
		format = function(diagnostic)
			local message = diagnostic.message
			local source = diagnostic.source
			local code = diagnostic.code

			local formatted = message
			if source then
				formatted = string.format("%s: %s", source, formatted)
			end
			--if code then
			--formatted = string.format("%s [%s]", formatted, code)
			--end

			return formatted .. "\n" -- Add two newlines at the end
		end,

		--border = {
		--{ "╔", "FloatBorder" },
		--{ "═", "FloatBorder" },
		--{ "╗", "FloatBorder" },
		--{ "║", "FloatBorder" },
		--{ "╝", "FloatBorder" },
		--{ "═", "FloatBorder" },
		--{ "╚", "FloatBorder" },
		--{ "║", "FloatBorder" },
		--},
	},
})

-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = "*",
	command = "lua OpenDiagnosticIfNoFloat()",
	group = "lsp_diagnostics_hold",
})

-- session options (global for tabby.nvim names)
vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

-- resize windows equally when resizing vim/terminal itself
vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*", -- apply yo all buffers
	command = "wincmd =",
})
