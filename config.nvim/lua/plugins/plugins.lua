return {
	"folke/neodev.nvim",
	{
		"github/copilot.vim",
		enabled = true,
		config = function()
			vim.g.copilot_enabled = false -- disable by default
		end,
		keys = {
			{
				"<F1>",
				"<cmd>Copilot enable<cr>",
			},
		},
	},
	{ "nvim-telescope/telescope.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"html",
				"xml",
			},
			conf = function()
				require("nvim-treesitter.configs").setup({
					autotag = {
						enable = true,
					},
				})
			end,
		},
	}, -- {'do': ':TSUpdate'} " call `:TSInstall go` after},

	-- dap
	{ "theHamsta/nvim-dap-virtual-text" },
	{
		"folke/trouble.nvim",
		opts = {
			mode = "quickfix", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
		},
	}, -- error helpers
	--{ "benmills/vimux" }, -- not using recently

	-- Vim itself
	{ "mhinz/vim-startify" },
	{ "jeanCarloMachado/vim-toop" }, -- fancy text-object functions
	--{ 'Yggdroot/indentLine' " don't need this, use list
	--{ 'machakann/vim-highlightedyank' " cool but annoying after a while
	--{ 'chrisbra/Recover.vim' },
	{ "inkarkat/vim-CompleteHelper" },
	--{ 'unblevable/quick-scope' " cool but I don't use much
	--{ "dstein64/vim-startuptime" }, -- enable as needed

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
			require("octo").setup({
				-- disable default mappings
				mappings_disable_default = true,
			})
		end,
		keys = {
			{
				"<leader>ps",
				"<cmd>Octo review start<cr>",
			},
			{
				"<leader>pc<enter>",
				"<cmd>Octo review comments<cr>",
				desc = "view pending review comments",
			},
			{
				"<leader>p<enter>",
				"<cmd>Octo review submit<cr>",
			},
			{
				"<leader>po",
				":Octo ",
				desc = "open pr prompt",
			},
		},
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
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

	-- General Syntax
	--{ 'jiangmiao/auto-pairs' },
	{ "tpope/vim-endwise" },
	{ "tpope/vim-surround" },
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
	{ "godlygeek/tabular" },
	{
		"folke/which-key.nvim",
		enabled = false, -- this is fine but noisy and I don't use often
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	-- Language-specific
	{ "vim-scripts/dbext.vim" },
	{ "sebdah/vim-delve" },
	{ "hashivim/vim-terraform" },
	{ "ekalinin/Dockerfile.vim" },
	{ "cespare/vim-toml" },
	{
		"preservim/vim-markdown",
		config = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_override_foldtext = 0
			vim.g.vim_markdown_conceal = 0 -- disable syntax concealing
			vim.g.vim_markdown_conceal_code_blocks = 0 -- disable conceal for fences
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
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
			--vim.g.ale_use_neovim_diagnostics_api = 0 -- disable diagnostic mode, affects other settings.
		end,
	},
	--{ "maximbaz/lightline-ale" },

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
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
			enable = true
			filetypes = { "html", "xml" }
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- Colors
	{ "fenetikm/falcon" },
	{ "guns/xterm-color-table.vim" },
	{ "catppuccin/nvim", priority = 1000 },
	{ "rebelot/kanagawa.nvim", priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "jonathanfilip/vim-lucius" },
	{ "morhetz/gruvbox" },
	{ "Mofiqul/dracula.nvim" },
	{ "tomasiser/vim-code-dark" },
	{ "hzchirs/vim-material" },
	{ "cocopon/iceberg.vim" },
	{ "bluz71/vim-moonfly-colors" },

	-- Files & Buffers
	{ "ton/vim-bufsurf" },
	{ "qpkorr/vim-bufkill" },
	--{ "gcmt/taboo.vim" },

	-- Layout
	--{ "itchyny/lightline.vim" }, -- takes over tabbar
	--
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				--theme = "auto",
				--theme = "dracula",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				--lualine_b = { "branch", "diff", { "diagnostics", sources = { "ale" } } },
				lualine_b = { "diff", { "diagnostics", sources = { "ale" } } },
				lualine_c = { "filename" },
				lualine_x = { "filetype" },
				lualine_y = {},
				lualine_z = { "progress", "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				mode = "tabs",
				separator_style = "slant",
				show_duplicate_prefix = false, -- don't show (Duplicate)
			},
		},
	},
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
	{ "ryanoasis/vim-devicons" },

	-- Build
	{ "tpope/vim-dispatch" },

	-- Testing
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-go",
		},
		opts = {
			adapters = {
				["neotest-go"] = {
					--args = { "-tags=integration" },
				},
			},
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					if require("lazyvim.util").has("trouble.nvim") then
						require("trouble").open({ mode = "quickfix", focus = false })
					else
						vim.cmd("copen")
					end
				end,
			},
		},
		config = function(_, opts)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						-- Replace newline and tab characters with space for more compact diagnostics
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			if opts.adapters then
				local adapters = {}
				for name, config in pairs(opts.adapters or {}) do
					if type(name) == "number" then
						if type(config) == "string" then
							config = require(config)
						end
						adapters[#adapters + 1] = config
					elseif config ~= false then
						local adapter = require(name)
						if type(config) == "table" and not vim.tbl_isempty(config) then
							local meta = getmetatable(adapter)
							if adapter.setup then
								adapter.setup(config)
							elseif meta and meta.__call then
								adapter(config)
							else
								error("Adapter " .. name .. " does not support setup")
							end
						end
						adapters[#adapters + 1] = adapter
					end
				end
				opts.adapters = adapters
			end

			require("neotest").setup(opts)
		end,
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run File",
			},
			{
				"<leader>tT",
				function()
					require("neotest").run.run(vim.loop.cwd())
				end,
				desc = "Run All Test Files",
			},
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Run Nearest",
			},
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
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle Output Panel",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop",
			},
		},
	},
	{ "nvim-neotest/neotest-go" },
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

	-- Local
	{ "vim-dotfiles", dev = true },
	{ "vim-conceal-secrets", dev = true },
	{ dir = "~/.private-vim-plugin" }, -- private plugin(s), `ln -s <plugin-dir> ~/.private-plugin.vim
}
