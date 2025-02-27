-- this file contains my personal non-default keymaps. Keeping all keymaps in one file makes lookup easier, and declutters your plugin specs.
local M = {}

M.setup = function()
	keys = {
		-- Leader Favorites
		{ "<leader>1", "<cmd>set list!<cr>", mode = { "n", "i" } },
		{ "<leader>7", "<cmd>ALEInfo<cr>", mode = { "n", "i" } },

		-- Buffers
		{ "<leader>b", group = "buffer" },
		{
			"<leader>bd",
			"<cmd>BD<cr>",
			desc = "delete buffer",
			mode = { "n", "i" },
		},

		{ "<leader>d", group = "debug" },

		{ "<leader>g", group = "git" },

		{ "<leader>q", group = "quickfix" }, -- group
		{ "<leader>qq", "<cmd>ToggleQuickFix<cr>", desc = "toggle quickfix", mode = { "n", "i" } },

		-- Tests
		{ "<leader>t", group = "test" },
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle Summary Sidebar",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({
					enter = true,
					auto_close = false,
					last_run = true,
				})
			end,
			desc = "Show Output (last run)",
		},
		{
			"<leader>tp",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle Output Panel",
		},
		{
			"<leader>tT",
			function()
				local qt = require("quicktest")
				qt.run_line()
			end,
			desc = "Test Nearest (quicktest)",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
				require("neotest").summary.open()
			end,
			desc = "Run File",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.run(vim.loop.cwd())
				--require("neotest").summary.open()
			end,
			desc = "Run All Test Files (neotest)",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
				--require("neotest").summary.open()
				require("neotest").output.open()
			end,
			desc = "Run Nearest (neotest)",
		},
		{
			"<leader>tN",
			function()
				require("neotest").run.run({ strategy = "dap" })
				require("neotest").summary.open()
			end,
			desc = "Run Nearest (neotest dap)",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ suite = false, strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
		{
			"<leader>tx",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop",
		},
		{
			"<leader>tL",
			function()
				local qt = require("quicktest")
				qt.run_line("popup")
			end,
			desc = "[T]est Nearest [L]line (quicktest popup)",
		},
		{
			"<leader>tF",
			function()
				local qt = require("quicktest")

				qt.run_file()
			end,
			desc = "[T]est Run [F]ile",
		},
		{
			"<leader>tD",
			function()
				local qt = require("quicktest")

				qt.run_dir()
			end,
			desc = "[T]est Run [D]ir",
		},
		{
			"<leader>tA",
			function()
				local qt = require("quicktest")

				qt.run_all()
			end,
			desc = "[T]est Run [A]ll (quicktest)",
		},
		{
			"<leader>tP",
			function()
				local qt = require("quicktest")

				qt.run_previous()
			end,
			desc = "[T]est Run [P]revious",
		},
		{
			"<leader>tW",
			function()
				local qt = require("quicktest")

				qt.toggle_win("split")
			end,
			desc = "Toggle Test Window",
		},
		{
			"<leader>tX",
			function()
				local qt = require("quicktest")

				qt.cancel_current_run()
			end,
			desc = "[T]est [C]ancel Current Run",
		},
		-- coverage
		{
			"<leader>tc",
			function()
				local cov = require("coverage")
				cov.load()
				cov.toggle()
			end,
			mode = { "n", "i" },
			desc = "Coverage Toggle",
		},
		{
			"<leader>tC",
			function()
				local cov = require("coverage")
				cov.load()
				cov.summary()
			end,
			mode = { "n", "i" },
			desc = "Coverage Summary",
		},

		-- Yanks
		{ "<leader>y", group = "yank" },
		{
			"<leader>yf",
			"<cmd>RelPathToClipboard<cr>",
			desc = "copy relative current file path to clipboard",
			mode = { "n", "i" },
		},
		{
			"<leader>yF",
			"<cmd>AbsPathToClipboard<cr>",
			desc = "copy absolute current file path to clipboard",
			mode = { "n", "i" },
		},
		{
			"<leader>yd",
			"<cmd>RelDirToClipboard<cr>",
			desc = "copy relative current dir path to clipboard",
			mode = { "n", "i" },
		},
		{
			"<leader>yD",
			"<cmd>AbsDirToClipboard<cr>",
			desc = "copy absolute current dir path to clipboard",
			mode = { "n", "i" },
		},
	}

	local wk = require("which-key")
	wk.add(keys)

	-- non-plugin keymaps

	-- open diagnostic float
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>=", function()
		vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.HINT } })
	end, { desc = "Go to next error diagnostic" })
	vim.keymap.set("n", "<leader>-", function()
		vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.HINT } })
	end, { desc = "Go to previous error diagnostic" })
	vim.keymap.set("n", "<leader>]", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { desc = "Go to next error diagnostic" })
	vim.keymap.set("n", "<leader>[", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { desc = "Go to previous error diagnostic" })

	-- TODO: move
	vim.keymap.set("n", "<F10>", function()
		require("dap").step_over()
	end)
	vim.keymap.set("n", "<F11>", function()
		require("dap").step_into()
	end)
	vim.keymap.set("n", "<F12>", function()
		require("dap").step_out()
	end)
	vim.keymap.set("n", "<Leader>1", function()
		require("dap").toggle_breakpoint()
	end)
	vim.keymap.set("n", "<Leader>2", function()
		require("dap-go").debug_test()
	end)
	vim.keymap.set("n", "<Leader>3", function()
		require("dap").continue()
	end)
	vim.keymap.set("n", "<Leader>dr", function()
		require("dap").repl.open()
	end)
	--vim.keymap.set("n", "<Leader>B", function()
	--require("dap").set_breakpoint()
	--end)
	vim.keymap.set("n", "<Leader>lp", function()
		require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
		require("dap.ui.widgets").hover()
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
		require("dap.ui.widgets").preview()
	end)
	vim.keymap.set("n", "<Leader>df", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.frames)
	end)
	vim.keymap.set("n", "<Leader>ds", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.scopes)
	end)

	-- Telescope
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
	vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
end

return M
