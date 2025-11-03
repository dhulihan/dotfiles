return {
	{
		"olimorris/codecompanion.nvim",
		enabled = false, -- disabling for now, mcphub using crazy amount of memory
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				ft = { "codecompanion" },
			},
			{
				"OXY2DEV/markview.nvim",
				enabled = false, -- modifies rtp if treesitter loaded first, wtf... breaking clipboard (see https://github.com/neovim/neovim/issues/7114)
				lazy = false,
				opts = {
					preview = {
						filetypes = { "codecompanion" },
						ignore_buftypes = {},
					},
				},
			},
		},
		config = function(_, opts)
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "copilot",
					},
					inline = {
						adapter = "copilot",
					},
					cmd = {
						adapter = "copilot",
					},
				},
				extensions = {
					mcphub = {
						callback = "mcphub.extensions.codecompanion",
						opts = {
							-- MCP Tools
							make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
							show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
							add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
							show_result_in_chat = true, -- Show tool results directly in chat buffer
							format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
							-- MCP Resources
							make_vars = true, -- Convert MCP resources to #variables for prompts
							-- MCP Prompts
							make_slash_commands = true, -- Add MCP prompts as /slash commands
						},
					},
				},
			})
		end,
	},
	{
		"ravitemer/mcphub.nvim",
		enabled = false, -- leaving orphaned node server process on neovim exit
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		-- comment the following line to ensure hub will be ready at the earliest
		cmd = "MCPHub", -- lazy load by default
		build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
		-- uncomment this if you don't want mcp-hub to be available globally or can't use -g
		-- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
		config = function()
			require("mcphub").setup({
				log = {
					--level = vim.log.levels.TRACE,
					level = vim.log.levels.WARN,
					to_file = false,
					file_path = nil,
					prefix = "MCPHub",
				},

				-- This sets vim.g.mcphub_auto_approve to true by default (can also be toggled from the HUB UI with `ga`)
				auto_approve = true,
				--extensions = {
				----avante = {
				----make_slash_commands = true, -- make /slash commands from MCP server prompts
				----},
				--},
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		--enabled = false, -- cannot turn off with :Copilot disable
		event = "InsertEnter",
		cmd = "Copilot", -- lazy load on command
		config = {
			panel = {
				enabled = false, -- disable by default
				auto_trigger = false,
			},
			suggestion = {
				enabled = true, -- disable by default
				auto_trigger = true, -- start suggesting as soon as you start typing
				auto_refresh = true,
				keymap = {
					--accept = "<Tab>", -- conflicts with ultisnips
					--accept = "<M-l>",
					accept = "<M-Tab>",
					--accept = "<Leader><Tab>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				sh = function()
					if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
						-- disable for .env files
						return false
					end
					return true
				end,

				--json = false,
			},
		},
	},
	{
		"jonahgoldwastaken/copilot-status.nvim",
		--enabled = false, -- doesn't work
		lazy = true,
		event = "BufReadPost",
		dependencies = { "zbirenbaum/copilot.lua" },
		opts = {
			icons = {
				idle = "idle",
				error = "uh-oh",
				offline = "off",
				warning = "warning",
				loading = "loading",
			},
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		--enabled = false,
		branch = "main",
		event = "BufEnter",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			--debug = true, -- Enable debugging
			-- See Configuration section for rest
			model = "claude-sonnet-4.5",
			window = {
				layout = "float",
				border = "rounded",
			},
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
}
