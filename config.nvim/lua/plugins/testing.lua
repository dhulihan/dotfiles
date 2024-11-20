return {
	"quolpr/quicktest.nvim",
	config = function()
		local qt = require("quicktest")

		qt.setup({
			-- Choose your adapter, here all supported adapters are listed
			adapters = {
				require("quicktest.adapters.golang")({}),
				--require("quicktest.adapters.vitest")({}),
				--require("quicktest.adapters.playwright")({}),
				--require("quicktest.adapters.elixir"),
				--require("quicktest.adapters.criterion"),
				--require("quicktest.adapters.dart"),
			},
			-- split or popup mode, when argument not specified
			default_win_mode = "split",
			use_experimental_colorizer = true,
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>tl",
			function()
				local qt = require("quicktest")
				-- current_win_mode return currently opened panel, split or popup
				--qt.run_line()
				-- You can force open split or popup like this:
				--qt.run_line("split")
				qt.run_line("popup")
			end,
			desc = "[T]est Run [L]line",
		},
		{
			"<leader>tf",
			function()
				local qt = require("quicktest")

				qt.run_file()
			end,
			desc = "[T]est Run [F]ile",
		},
		{
			"<leader>td",
			function()
				local qt = require("quicktest")

				qt.run_dir()
			end,
			desc = "[T]est Run [D]ir",
		},
		{
			"<leader>ta",
			function()
				local qt = require("quicktest")

				qt.run_all()
			end,
			desc = "[T]est Run [A]ll",
		},
		{
			"<leader>tp",
			function()
				local qt = require("quicktest")

				qt.run_previous()
			end,
			desc = "[T]est Run [P]revious",
		},
		{
			"<leader>tt",
			function()
				local qt = require("quicktest")

				qt.toggle_win("split")
			end,
			desc = "[T]est [T]oggle Window",
		},
		{
			"<leader>tc",
			function()
				local qt = require("quicktest")

				qt.cancel_current_run()
			end,
			desc = "[T]est [C]ancel Current Run",
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
			"olimorris/neotest-rspec",

			"nvim-neotest/nvim-nio",
		},
		config = function(_, opts)
			-- get neotest namespace (api call creates or returns namespace)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						--vim.print(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			opts = {
				--output = { open_on_run = true },
				--diagnostic = { enabled = true, severity = 1 },
				--output_panel = { open_on_run = true },
				status = {
					enabled = true,
					--virtual_text = true,
				},
				--strategies = {
				--integrated = {
				--height = 40,
				--width = 120,
				--},
				--},
				--summary = {
				--enabled = true,
				--expand_errors = true,
				--follow = true,
				--mappings = {
				--attach = "a",
				--expand = { "<CR>", "<2-LeftMouse>" },
				--expand_all = "e",
				--jumpto = "i",
				--output = "o",
				--run = "r",
				--short = "O",
				--stop = "u",
				--},
				--},

				adapters = {
					require("neotest-rspec")({
						rspec_cmd = function()
							return vim.tbl_flatten({
								"bundle",
								"exec",
								"rspec",
							})
						end,
					}),
					require("neotest-golang")({
						runner = "gotestsum",
					}),
				},
			}

			-- consumers
			--opts.consumers = opts.consumers or {}
			--opts.consumers.trouble = function(client)
			--client.listeners.results = function(adapter_id, results, partial)
			--if partial then
			--return
			--end
			--local tree = assert(client:get_position(nil, { adapter = adapter_id }))

			--local failed = 0
			--for pos_id, result in pairs(results) do
			--if result.status == "failed" and tree:get_key(pos_id) then
			--failed = failed + 1
			--end
			--end
			--vim.schedule(function()
			--local trouble = require("trouble")
			--if trouble.is_open() then
			--trouble.refresh()
			--if failed == 0 then
			--trouble.close()
			--end
			--end
			--end)
			--return {}
			--end
			--end

			require("neotest").setup(opts)
		end,
		keys = {
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle Summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "Show Output",
			},
			{
				"<leader>tp",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle Output Panel",
			},
			{
				"<leader>tt",
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
					require("neotest").summary.open()
				end,
				desc = "Run All Test Files",
			},
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
					require("neotest").summary.open()
				end,
				desc = "Run Nearest",
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
		},
	},
	{
		"mfussenegger/nvim-dap",
		keys = {
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
		},
		config = function()
			local dap = require("dap")
			--require("dap").set_log_level("DEBUG")

			-- prettier signs
			vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
		end,
	},
	{
		"leoluz/nvim-dap-go",
		config = true,
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"rcarriga/nvim-dap-ui",
		keys = {
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
		},
		opts = {},
		config = function(_, opts)
			-- setup dap config by VsCode launch.json file
			-- require("dap.ext.vscode").load_launchjs()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.before.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},
	{ "theHamsta/nvim-dap-virtual-text" },
	--{ "nvim-telescope/telescope-dap.nvim" },
}
