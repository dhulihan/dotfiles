-- Testing
return {
	{
		"quolpr/quicktest.nvim",
		--enabled = false -- 2025-02-26 trouble with buffer numbers on session restore
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
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"fredrikaverpil/neotest-golang",
				version = "*",
				dependencies = {
					"andythigpen/nvim-coverage",
				},
			}, -- Installation
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

			local neotest_golang_opts = {
				-- To improve reliability, you can choose to set gotestsum as the test runner. This tool allows the adapter to write test command output directly to a JSON file without having to go through stdout.
				--runner = "gotestsum",

				runner = "go",
				go_test_args = {
					"-v",
					"-race",
					"-count=1",
					"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
				},
			}

			opts = {
				output = { -- Displays output of tests
					--open_on_run = true,
					auto_close = false,

					enter = false,
					win_options = {
						split = "botright",
						winheight = 15,
						wrap = false,
					},
				},
				diagnostic = { enabled = true, severity = 1 },
				--output_panel = { open_on_run = true }, -- Records all output of tests over time in a single window
				status = { -- Displays the status of a test/namespace beside the beginning of the definition
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
				floating = {
					border = "rounded",
					--max_height = 0.6,
					max_height = 0.9,
					max_width = 0.6,

					options = {
						wrap = false,
					},
				},

				adapters = {
					-- disabling since I don't use ruby much lately
					--require("neotest-rspec")({
					--rspec_cmd = function()
					--return vim.tbl_flatten({
					--"bundle",
					--"exec",
					--"rspec",
					--})
					--end,
					--}),
					require("neotest-golang")(neotest_golang_opts),
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
	},
	{
		"mfussenegger/nvim-dap",
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
	{
		"andythigpen/nvim-coverage",
		version = "*",
		config = function()
			require("coverage").setup({
				auto_reload = true,
			})
		end,
	},
}
