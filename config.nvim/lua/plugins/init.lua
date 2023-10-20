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
	{ "w0rp/ale" },
	{ "maximbaz/lightline-ale" },

	-- Utility
	{ "tpope/tpope-vim-abolish" },
	{ "mileszs/ack.vim" },
	{ "jremmen/vim-ripgrep" },
	{ "tpope/vim-eunuch" },
	{ "tmhedberg/matchit" },
	{ "junegunn/fzf.vim" },
	{ "stsewd/fzf-checkout.vim" },
	{ "dhulihan/vim-gtfo" },

	-- Colors
	{ "fenetikm/falcon" },
	{ "guns/xterm-color-table.vim" },

	-- Files & Buffers
	{ "ton/vim-bufsurf" },
	{ "qpkorr/vim-bufkill" },
	{ "gcmt/taboo.vim" },

	-- Layout
	{ "itchyny/lightline.vim" },
	{ "godlygeek/tabular" },
	{ "tyru/open-browser.vim" },
	{ "majutsushi/tagbar" },

	-- Build
	{ "tpope/vim-dispatch" },
	{ "ryanoasis/vim-devicons" },
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
