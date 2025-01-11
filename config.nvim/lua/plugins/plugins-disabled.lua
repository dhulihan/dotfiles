return {
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
}
