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

	{ "benmills/vimux" },
	-- Vim itself
	{ "mhinz/vim-startify" },
	{ "jeanCarloMachado/vim-toop" },
	--{ 'Yggdroot/indentLine' " don't need this, use list
	--{ 'machakann/vim-highlightedyank' " cool but annoying after a while
	--{ 'chrisbra/Recover.vim' },
	{ "inkarkat/vim-CompleteHelper" },
	--{ 'unblevable/quick-scope' " cool but I don't use much

	-- Version Control
	{ "tpope/vim-fugitive" },
	--{ 'junegunn/gv.vim' " not needed
	--{ 'junkblocker/git-time-lapse' " using :0Gclog instead
	{ "tpope/vim-rhubarb" },
	--{ 'airblade/vim-gitgutter' " performance issues 2021-08-24, try to update
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},

	-- General Syntax
	--{ 'jiangmiao/auto-pairs' },
	{ "tpope/vim-endwise" },
	--{ 'tpope/vim-surround' },
	--{ 'tpope/vim-repeat' },
	--{ 'Valloric/YouCompleteMe' " no ruby support, gocode is better for go, slow
	{ "preservim/nerdcommenter" },
	--{ 'ludovicchabant/vim-gutentags' " blocking too much
	{ "vitalk/vim-shebang" },
	-- { 'junegunn/vim-easy-align' " TODO: fix = mapping
	{ "ntpeters/vim-better-whitespace" },
	{ "rhysd/clever-f.vim" },
	{ "bogado/file-line" }, -- " open file:line
	-- { 'vim-test/vim-test' }, -- not needed atm
	-- { 'wellle/context.vim' },-- cool but slow
	{ "SirVer/ultisnips" },
	{ "honza/vim-snippets" },
	{ "yssl/QFEnter" }, -- quickfix helpers

	-- Language-specific
	{ "sebdah/vim-delve" },
	{ "hashivim/vim-terraform" },
	{ "ekalinin/Dockerfile.vim" },
	{ "cespare/vim-toml" },
	{ "plasticboy/vim-markdown" },
	{ "iamcco/markdown-preview.nvim" }, -- :call mkdp#util#install() afterwards
	{ "img-paste-devs/img-paste.vim" },
	{ "chrisbra/csv.vim" },
	{ "dhulihan/vim-rfc" },
	{ "kamailio/vim-kamailio-syntax" },
	{ "bufbuild/vim-buf" },
	{ "trayo/vim-ginkgo-snippets" },
	{ "buoto/gotests-vim" },
	{ "mracos/mermaid.vim" },
	{ "direnv/direnv.vim" },

	-- Lint
	{
		"w0rp/ale",
		config = function()
			vim.g.ale_virtualtext_cursor = "current" -- only show virtualtext on current line
			vim.g.ale_use_neovim_diagnostics_api = 0 -- disable diagnostic mode, affects other settings.
		end,
	},
	{ "maximbaz/lightline-ale" },

	-- Utility
	{ "tpope/tpope-vim-abolish" },
	{
		"gabrielpoca/replacer.nvim", -- replace using quickfix!
		--opts = {rename_files = false},
		keys = {
			{
				"<leader>h",
				function()
					require("replacer").run()
				end,
				desc = "run replacer.nvim",
			},
		},
	},
	{ "mileszs/ack.vim" },
	{ "jremmen/vim-ripgrep" },
	{ "tpope/vim-eunuch" },
	--{ "tmhedberg/matchit" },
	{ "andymass/vim-matchup" },
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{ "junegunn/fzf.vim" },
	{ "stsewd/fzf-checkout.vim" },
	{ "dhulihan/vim-gtfo" },

	-- Colors
	{ "fenetikm/falcon" },
	{ "guns/xterm-color-table.vim" },
	{ "catppuccin/nvim", priority = 1000 },
	{ "rebelot/kanagawa.nvim", priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "jonathanfilip/vim-lucius" },

	-- Files & Buffers
	{ "ton/vim-bufsurf" },
	{ "qpkorr/vim-bufkill" },
	{ "gcmt/taboo.vim" },

	-- Layout
	{ "itchyny/lightline.vim" },
	{ "godlygeek/tabular" },
	{ "tyru/open-browser.vim" },
	{ "majutsushi/tagbar" },
	{
		"wfxr/minimap.vim", -- sublime-style minimap
		config = function()
			--vim.g.minimap_width = 10
			--vim.g.minimap_auto_start = 1
			--vim.g.minimap_auto_start_win_enter = 1
			vim.g.minimap_highlight_search = 1 -- highlight search patterns
		end,
		keys = {
			{ "<F3>", "<cmd>MinimapToggle<cr>", mode = { "n", "i" } },
		},
	}, -- requires code-minimap to be installed separately
	--{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" }, -- maybe later
	{ "ryanoasis/vim-devicons" },

	-- Build
	{ "tpope/vim-dispatch" },

	-- Local
	{ "vim-dotfiles", dev = true },
	{ "vim-conceal-secrets", dev = true },
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
