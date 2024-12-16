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
}
