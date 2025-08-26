return {
	{
		"folke/flash.nvim",
    desc = "",
		enabled = false, -- not sure if I want to use this yet
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
	},
	{
		"yetone/avante.nvim",
		enabled = false, -- disabling this to shut off persistent node process connected to github
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		config = function()
			require("avante").setup({
				---- add any opts here
				---- for example
				provider = "copilot",
				----provider = "gemini",
				--openai = {
				--endpoint = "https://api.openai.com/v1",
				--model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
				--timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
				--temperature = 0,
				--max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
				----reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
				--},
				--},
				--
				-- other config
				-- The system_prompt type supports both a string and a func that returns a string. Using a func here allows dynamically updating the prompt with mcphub
				system_prompt = function()
					local hub = require("mcphub").get_hub_instance()
					return hub:get_active_servers_prompt()
				end,
				-- The custom_tools type supports both a list and a func that returns a list. Using a func here prevents requiring mcphub before it's loaded
				custom_tools = function()
					return {
						require("mcphub.extensions.avante").mcp_tool(),
					}
				end,
			})
		end,
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"ravitemer/mcphub.nvim",
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "Avante" },
					--file_types = { "markdown", "Avante" },
				},
				ft = { "Avante" },
				--ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"github/copilot.vim",
		enabled = false,
		config = function()
			vim.g.copilot_enabled = false -- disable by default
		end,
		keys = {
			{
				"<F1>",
				"<cmd>Copilot enable<cr>",
			},
			{
				"<F1>",
				"<C-o><cmd>Copilot enable<cr>",
				mode = "i",
			},
		},
	},
	--{ "ofseed/copilot-status.nvim" },
	{
		"romgrk/barbar.nvim",
		enabled = false, -- need to deal with sessions
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
			animation = false,
			preset = "slanted",
			icons = {
				buffer_index = true,
				buffer_number = "subscript",
			},
		},
		--keys = {},

		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		enabled = false, -- does not support setting numbered-harpoon slots
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon"):list():add()
				end,
				desc = "harpoon file",
			},
			{
				"<leader>hl",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "harpoon quick menu",
			},
			{
				"<leader>h1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "harpoon to file 1",
			},
			{
				"<leader>h2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "harpoon to file 2",
			},
			{
				"<leader>h3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "harpoon to file 3",
			},
			{
				"<leader>h4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "harpoon to file 3",
			},
			{
				"<leader>hn",
				function()
					require("harpoon"):list():next()
				end,
				desc = "next buffer",
			},
			{
				"<leader>hp",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "prev buffer",
			},
		},
	},
	{ "tiagovla/scope.nvim" }, -- scoped buffers. didn't end up using.

	{
		"chrishrb/gx.nvim", -- replacement for netrw gx
		enabled = false, -- not needed, doing it myself
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" }, -- Required for Neovim < 0.10.0
		keys = {
			{ "gx", "<cmd>Browse<cr>", mode = { "n", "x" } },
			{ "<leader>xo", "<cmd>Browse<cr>", mode = { "n", "x" } },
		},
	},
}
