-- this file contains my personal non-default keymaps. Keeping all keymaps in one file makes lookup easier, and declutters your plugin specs.
local M = {}

-- transform a string from "foo: bar" to "* `foo` - bar"
local function transformToInline(input)
	-- Use string.gsub to replace the pattern
	local converted = input:gsub("(%w+):%s*(.+)", "* `%1` - %2")
	return converted
end

-- Initialize a global toggle flag

-- Map a key to toggle autocompletion
vim.keymap.set("n", "<Leader>ua", function()
	vim.g.cmp_toggle = not vim.g.cmp_toggle
	print("nvim-cmp", vim.g.cmp_toggle and "ENABLED" or "DISABLED")
end, { desc = "toggle nvim-cmp" })

-- shell command output in floating window
local function shell_in_float(cmd)
	-- Create a new buffer (not listed, scratch)
	local buf = vim.api.nvim_create_buf(false, true)

	-- Get the editor size
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	-- Start a terminal job in the buffer
	vim.fn.termopen(cmd)
	vim.cmd("startinsert")
end

-- display output of a command in a floating window
local function cmd_in_float(cmd)
	local output = vim.fn.execute(cmd)

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "single",
	}
	local win = vim.api.nvim_open_win(buf, true, opts)

	-- close close on focus loast
	vim.cmd(string.format(
		[[
    autocmd BufLeave,FocusLost <buffer=%d> ++once lua vim.api.nvim_win_close(%d, false)
  ]],
		buf,
		win
	))
end

M.setup = function()
	leader_keys = {
		{ "<leader>c", group = "code" },

		-- Leader Favorites
		{ "<leader>1", "<cmd>set list!<cr>", mode = { "n", "i" } },
		{
			"<leader>5",
			function()
				require("oil").open_float()
			end,
			desc = "Open Oil (float)",
		},
		{ "<leader>7", "<cmd>ALEInfo<cr>", mode = { "n", "i" } },

		-- Buffers
		{ "<leader>b", group = "buffer" },
		{
			"<leader>bd",
			"<cmd>BD<cr>",
			desc = "delete buffer",
			mode = { "n", "i" },
		},
		{
			"<leader>bs",
			"<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>",
			desc = "Switch Buffer",
		},

		{ "<leader>d", group = "debug" },
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>da",
			function()
				require("dap").continue({ before = get_args })
			end,
			desc = "Run with Args",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "Go to line (no execute)",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "Session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},
		{
			"<leader>du",
			function()
				require("dapui").toggle({})
			end,
			desc = "Dap UI",
		},
		{
			"<leader>de",
			function()
				require("dapui").eval()
			end,
			desc = "Eval",
			mode = { "n", "v" },
		},

		-- Errors/Warning/Diagnostics
		{ "<leader>e", group = "errors" },
		{
			"<leader>e]",
			function()
				require("trouble").next()
				require("trouble").jump()
			end,
			desc = "Next Trouble Entry",
			mode = { "n", "v", "i" },
		},
		{
			"<leader>e[",
			function()
				require("trouble").prev()
				require("trouble").jump()
			end,
			desc = "Prev Trouble Entry",
			mode = { "n", "v", "i" },
		},
		{
			"<leader>ed",
			"<cmd>Trouble diagnostics toggle<CR>",
			desc = "Project Diagnostics (ALL)",
		},
		{
			"<leader>ee",
			"<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<CR>",
			desc = "Project Diagnostics (ERROR)",
		},
		{
			"<leader>ew",
			"<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.WARN<CR>",
			desc = "Project Diagnostics (WARN)",
		},
		{
			"<leader>eb",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Buffer Errors/Warnings - Diagnostics (Trouble)",
		},
		{
			"<leader>es",
			"<cmd>Trouble symbols toggle focus=false<CR>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>ex",
			"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>el",
			"<cmd>Trouble loclist toggle<CR>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>eq",
			"<cmd>Trouble qflist toggle<CR>",
			desc = "Quickfix List (Trouble)",
		},

		-- Find
		{ "<leader>f", group = "find" },
		--{ "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
		--{ "<leader>:", "<cmd>Telescope command_history<CR>", desc = "Command History" },
		--{ "q:", "<cmd>Telescope command_history<CR>", desc = "Command History" },
		--{ "<leader><space>", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
		--{ "<C-\\>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "Buffers" }, -- override
		--{ "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find Files" }, -- override
		--{ "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
		--{ "<leader>ff", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
		{ "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "Buffers" },
		--{ "<leader>fF", LazyVim.pick("auto", { root = false }), desc = "Find Files (cwd)" },
		{ "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Find Files (git-files)" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recently Opened Files" },
		--{ "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
		{ "<leader>ft", "<cmd>Telescope live_grep<CR>", desc = "Find Text (Live Grep)" },

		-- Git
		{ "<leader>g", group = "git" },
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
		{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
		{ "<leader>gl", "<cmd>Git log -p %<CR>", desc = "Log Patch (Current File)" },
		{ "<Leader>gg", "<cmd>.GBrowse!<CR>" },
		{ "<Leader>gG", "<cmd>GitPrimaryURL<CR>" },
		{ "<Leader>gb", "<cmd>GBranches<CR>" },
		{ "<Leader>gc", "<cmd>.GBrowse!<CR>" },
		{ "<Leader>gx", "<cmd>.GBrowse<CR>" },
		{ "<Leader>gm", "<cmd>GBrowse @origin<CR>" },
		{ "<Leader>ge", "<cmd>GEdit master:%<CR>" },

		-- inspect internals
		{ "<leader>i", group = "inspect" },
		{
			"<leader>id",
			function()
				print(vim.inspect(vim.diagnostic.get()))
			end,
			desc = "Inspect current diagnostics",
		},
		{
			"<leader>ip",
			desc = "inspect processes with pstree",
			function()
				-- get current pid
				local pid = vim.fn.getpid()
				--vim.cmd(string.format("pstree -p %d", pid))
				shell_in_float(string.format("pstree -p %d", pid))
			end,
		},
		{
			"<leader>im",
			desc = "inspect memory of current session",
			function()
				-- get current pid
				local pid = vim.fn.getpid()
				--vim.cmd(string.format("pstree -p %d", pid))
				shell_in_float(string.format("vmmap %d", pid))
			end,
		},
		{
			"<leader>il",
			desc = "inspect linter",
			function()
				cmd_in_float(":ALEInfo -echo")
			end,
		},
		{
			"<leader>ii",
			desc = "inspect indentations",
			function()
				cmd_in_float(":IndentInfo")
			end,
		},

		{ "<leader>l", group = "list" },
		{ "<leader>lb", "<cmd>Telescope buffers<CR>", desc = "List buffers" },

		{ "<leader>o", group = "open", desc = "open external references, pull requests, etc" },
		{ "<leader>op", group = "pull requests" },
		{
			"<leader>opn",
			"<cmd>Octo review start<CR>",
			desc = "Open new pull request",
		},
		{
			"<leader>ops",
			"<cmd>Octo review start<CR>",
			desc = "start review",
		},
		{
			"<leader>opc<enter>",
			"<cmd>Octo review comments<CR>",
			desc = "view pending review comments",
		},
		{
			"<leader>opx<enter>",
			"<cmd>Octo review submit<CR>",
		},
		{
			"<leader>opo",
			":Octo ",
			desc = "open pr prompt",
		},

		-- Quickfix
		{ "<leader>q", group = "quickfix" },
		{ "<leader>qq", "<cmd>ToggleQuickFix<cr>", desc = "toggle quickfix", mode = { "n", "i" } },
		{
			"<leader>qr",
			function()
				require("replacer").run()
			end,
			desc = "start replacer.nvim to replace text ocurrences in quickfix",
		},
		{
			"<leader>q<enter>",
			function()
				require("replacer").run()
			end,
			desc = "replace text in quickfix",
		},

		-- Rewrite/Replace text
		{ "<leader>r", group = "rewrite/replace" },
		{
			"<leader>rl",
			function()
				require("config.nvim.funky-plugins.vim-dotfiles.lua.vim-dotfiles.init").replace_bulleted_inline_snippet()
			end,
			desc = "Rewrite line in inline code example format",
		},

		-- Search & Replaces
		-- Question: what is the difference between find, search, list? Search and Replace
		{ "<leader>s", group = "search" },
		{ '<leader>s"', "<cmd>Telescope registers<CR>", desc = "Registers" },
		{ "<leader>sa", "<cmd>Telescope autocommands<CR>", desc = "Auto Commands" },
		{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
		{ "<leader>sc", "<cmd>Telescope command_history<CR>", desc = "Command History" },
		{ "<leader>sC", "<cmd>Telescope commands<CR>", desc = "Commands" },
		{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Document Diagnostics" },
		{ "<leader>sD", "<cmd>Telescope diagnostics<CR>", desc = "Workspace Diagnostics" },
		--{ "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
		--{ "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
		--{ "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
		{ "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help Pages" },
		{ "<leader>sH", "<cmd>Telescope highlights<CR>", desc = "Search Highlight Groups" },
		{ "<leader>sj", "<cmd>Telescope jumplist<CR>", desc = "Jumplist" },
		{ "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Key Maps" },
		{ "<leader>sl", "<cmd>Telescope loclist<CR>", desc = "Location List" },
		{ "<leader>sM", "<cmd>Telescope man_pages<CR>", desc = "Man Pages" },
		{ "<leader>sm", "<cmd>Telescope marks<CR>", desc = "Jump to Mark" },
		{ "<leader>so", "<cmd>Telescope vim_options<CR>", desc = "Options" },
		{ "<leader>sR", "<cmd>Telescope resume<CR>", desc = "Resume" },
		{ "<leader>sq", "<cmd>Telescope quickfix<CR>", desc = "Quickfix List" },
		--{ "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
		--{ "<leader>sW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
		--{ "<leader>sw", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
		--{ "<leader>sW", LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
		--{ "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
		--{
		--"<leader>ss",
		--function()
		--require("telescope.builtin").lsp_document_symbols({
		--symbols = LazyVim.config.get_kind_filter(),
		--})
		--end,
		--desc = "Goto Symbol",
		--},
		--{
		--"<leader>sS",
		--function()
		--require("telescope.builtin").lsp_dynamic_workspace_symbols({
		--symbols = LazyVim.config.get_kind_filter(),
		--})
		--end,
		--desc = "Goto Symbol (Workspace)",
		--},
		--

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
			"<leader>yb",
			"<cmd>CopyBufferToClipboard<cr>",
			desc = "copy buffer to clipboard",
		},
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

		-- Puts & Pastes
		{ "<leader>p", group = "put/paste" },
		{
			"<leader>pp",
			'"0p',
			desc = "paste from yank register 0",
			mode = { "i", "n", "v" },
		},
		{
			"<leader>pi",
			"<cmd>PasteImage<cr>",
			desc = "Paste image from system clipboard",
			mode = { "i", "n", "v" },
		},

		-- AI/ML
		{ "<leader>a", group = "ai/ml/copilot" },
		{
			"<leader>aa",
			"<cmd>:CodeCompanionActions<CR>",
			desc = "agent actions",
			mode = { "i", "n", "v" },
		},
		{
			"<leader>ac",
			--"<cmd>:CopilotChatToggle<CR>",
			"<cmd>:CodeCompanionChat<CR>",
			desc = "toggle chat",
			mode = { "i", "n", "v" },
		},
		{
			"<leader>aC",
			"<cmd>:CopilotChatToggle<CR>",
			desc = "toggle chat",
			mode = { "i", "n", "v" },
		},
		{
			"<leader>ar",
			"<cmd>:CopilotChatReset<CR>",
			desc = "reset copilot chat",
			mode = { "i", "n", "v" },
		},
		{
			"<leader>am",
			"<cmd>:CopilotChatModels<CR>",
			desc = "copilot chat models",
			mode = { "i", "n", "v" },
		},
		{
			"<leader>ae",
			"<cmd>:Copilot enable<CR>",
			desc = "enable copilot",
			mode = { "i", "n", "v" },
		},
		{
			"<leader>ah",
			"<cmd>:MCPHub<CR>",
			desc = "MCPHub",
			mode = { "i", "n", "v" },
		},
		{
			"<leader>ar",
			"<cmd>:CopilotChatReset<CR>",
			desc = "reset copilot chat",
			mode = { "i", "n", "v" },
		},
	}

	local meta_keys = {
		-- HACK: vim-markdown isn't mapping `ge`, so we'll do it ourselves, since `ge` is used to trigger g:vim_markdown_autowrite
		{
			"ge",
			"<Plug>Markdown_EditUrlUnderCursor",
			mode = { "n" },
		},

		-- AI/Copilot
		{
			"<M-c>",
			"<cmd>:CopilotChatToggle<CR>",
			desc = "toggle copilot chat",
			mode = { "n", "v" },
		},
		{
			"<M-e>",
			"<cmd>:Copilot enable<CR>",
			desc = "enable copilot",
			mode = { "i", "n", "v" },
		},
		{
			"<M-r>",
			"<cmd>:CopilotChatReset<CR>",
			desc = "reset copilot chat",
			mode = { "i", "n", "v" },
		},
	}

	local wk = require("which-key")
	wk.add(leader_keys)
	wk.add(meta_keys)

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
	--vim.keymap.set("n", "<Leader>lp", function()
	--require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	--end)
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
