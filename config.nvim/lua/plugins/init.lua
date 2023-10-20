return {
	"folke/neodev.nvim",
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enabled = false -- disable by default
		end,
	},
	{ "nvim-telescope/telescope.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "nvim-treesitter/nvim-treesitter" }, -- {'do': ':TSUpdate'} " call `:TSInstall go` after},

	-- dap
	{ "nvim-telescope/telescope-dap.nvim" },
	{ "mfussenegger/nvim-dap" },
	{ "leoluz/nvim-dap-go" },
	{ "rcarriga/nvim-dap-ui" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "github/copilot.vim" },
	{ "folke/trouble.nvim" }, -- error helpers

	-- color/style
	{ "jonathanfilip/vim-lucius" },
}

-- nvim-dap --------------------------------------------------------------------
--
--local ok, dap = pcall(require, "dap")
--if not ok then
--return
--end

--require("dap").set_log_level("DEBUG")
--require("dapui").setup()
--require("dap-go").setup()
--require("nvim-dap-virtual-text").setup()
----require("dapui").open()
----require("dapui").close()
----require("dapui").toggle()
---- events
--local dap, dapui = require("dap"), require("dapui")
--dap.listeners.after.event_initialized["dapui_config"] = function()
--dapui.open()
--end
--dap.listeners.before.event_terminated["dapui_config"] = function()
--dapui.close()
--end
--dap.listeners.before.event_exited["dapui_config"] = function()
--dapui.close()
--end

---- nvim-dap END ----------------------------------------------------------------
---- telescope
--require("telescope").setup()
--require("telescope").load_extension("dap")

--require("trouble").setup({
---- your configuration comes here
---- or leave it empty to use the default settings
---- refer to the configuration section below
--})
