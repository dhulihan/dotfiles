return {
	"folke/neodev.nvim",
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
		branch = "main",
		event = "BufEnter",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			--debug = true, -- Enable debugging
			-- See Configuration section for rest
			model = "claude-3.5-sonnet",
			window = {
				layout = "float",
				border = "rounded",
			},
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					file_browser = { layout_strategy = "horizontal", sorting_strategy = "ascending" },
					heading = { treesitter = true },
					["ui-select"] = { require("telescope.themes").get_dropdown({}) },
				},
				defaults = {
					--preview = false,
					cache_picker = { num_pickers = 10 },
					dynamic_preview_title = true,
					layout_strategy = "vertical",
					layout_config = {
						vertical = { width = 0.9, height = 0.9, preview_height = 0.7, preview_cutoff = 0 },
					},
					--path_display = { "smart", shorten = { len = 5 } },
					path_display = { "absolute" },
					wrap_results = true,
				},
				pickers = {
					buffers = {
						--show_all_buffers = true,
						--sort_lastused = true,
						--theme = "dropdown",
						--previewer = false,
						mappings = {
							i = {
								["<c-d>"] = "delete_buffer",
							},
						},
						-- Add this line to hide line numbers (not yet supported)
						disable_coordinates = true,
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"html",
				"go", -- you may need to `:TSInstall go`
				"markdown",
				"xml",
				"proto",
				"lua",
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

	-- Completion
	--{ "inkarkat/vim-CompleteHelper" },
	{
		"hrsh7th/nvim-cmp",
		--enabled = false, -- i can't get to work at all
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-cmdline",
			--"uga-rosa/cmp-dictionary",
			--"quangnguyen30192/cmp-nvim-ultisnips",
		},

		opts = function()
			local cmp = require("cmp")
			local types = require("cmp.types")
			local luasnip = require("luasnip")

			local kind_icons = {
				Text = "",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰇽",
				Variable = "󰂡",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			}

			return {
				preselect = "item",
				completion = {
					-- do not insert automatically,
					--completeopt = "menu,menuone,noinsert",

					--autocomplete = false, -- disable autocomplete, wait for user to request completion. you must remove/comment this line completely instead of setting to `true`.
				},
				snippet = {
					expand = function(args)
						--vim.fn["UltiSnips#Anon"](args.body)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				--mapping = cmp.mapping.preset.insert({
				-- start from scratch since nvim-cmp hijacks up/dn keys
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
					--["<C-y>"] = {
					--i = mapping.confirm({ select = false }),
					--},
					["<C-e>"] = cmp.mapping.abort(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- If true, accept first item in list on enter. Set `select` to `false` to only confirm explicitly selected items.

					-- luasnip
					--["<CR>"] = cmp.mapping(function(fallback)
					--if cmp.visible() then
					--if luasnip.expandable() then
					--luasnip.expand()
					--else
					--cmp.confirm({
					--select = true,
					--})
					--end
					--else
					--fallback()
					--end
					--end),

					-- dave custom <Tab>, expand snippet, jump inside snippet, or select first completion suggestion
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expandable() then
							luasnip.expand()
							return
						end

						if luasnip.locally_jumpable(1) then
							luasnip.jump(1)
							return
						end

						if cmp.visible() then
							cmp.confirm({
								select = true,
							})
							return
						end

						fallback()
					end, { "i", "s" }),
					--["<Tab>"] = cmp.mapping(function(fallback)
					--if cmp.visible() then
					--cmp.select_next_item()
					--elseif luasnip.locally_jumpable(1) then
					--luasnip.jump(1)
					--else
					--fallback()
					--end
					--end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				-- })
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
						--vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
						--vim_item.kind_hl_group = "Comment"

						vim_item.menu = entry.source.name
						vim_item.menu_hl_group = "Comment"
						return vim_item
					end,
				},
				sources = {
					{ name = "luasnip" },
					{
						name = "buffer",
						-- just visible buffers
						option = {
							get_bufnrs = function()
								local bufs = {}
								for _, win in ipairs(vim.api.nvim_list_wins()) do
									bufs[vim.api.nvim_win_get_buf(win)] = true
								end
								return vim.tbl_keys(bufs)
							end,
						},
					},
					-- 2025-04-09 disabling, too noisy
					--{
					--name = "dictionary",
					--paths = { "/usr/share/dict/words" },
					--keyword_length = 2,
					--},
					{ name = "emoji" },
					{ name = "path" },
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				},
			}
		end,
	},

	-- Vim itself
	{ "mhinz/vim-startify" },
	{ "jeanCarloMachado/vim-toop" }, -- fancy text-object functions
	--{ 'Yggdroot/indentLine' " don't need this, use list
	--{ 'machakann/vim-highlightedyank' " cool but annoying after a while
	--{ 'chrisbra/Recover.vim' },
	--{ 'unblevable/quick-scope' " cool but I don't use much
	--{ "dstein64/vim-startuptime" }, -- enable as needed
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			keymaps = {
				["<Leader>5"] = { "actions.close", mode = "n" },
				["<C-c>"] = { "actions.close", mode = "n" },
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
		},
		-- Optional dependencies
		dependencies = {
			{ "echasnovski/mini.icons", opts = {} },
			{ "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		},
	},

	-- External Tools
	{
		"williamboman/mason.nvim",
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		desc = "auto installs mason tools",
		opts = {
			ensure_installed = {
				"lua_ls",
				"gopls",
				--"ts_ls",
				"json-lsp",
			},
		},
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},

	-- LSP
	{
		"williamboman/mason-lspconfig.nvim",
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- json
			lspconfig.jsonls.setup({})

			-- typescript
			-- note: tsserver has been renamed to ts_ls, because it is a wrapper around tsserver
			--lspconfig.ts_ls.setup({})
			-- 2025-01-30 disabling to try typescript-tools.nvim

			-- golang
			--lspconfig.templ.setup({})
			--lspconfig.gopls.setup({}) -- crazy slow on startup

			-- lua
			lspconfig["lua_ls"].setup({
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"SmiteshP/nvim-navic",
		desc = "code context from lsp",
		opts = {
			click = true,
		},
		config = function(_, opts)
			local navic = require("nvim-navic")

			require("lspconfig").jsonls.setup({
				on_attach = function(client, bufnr)
					navic.attach(client, bufnr)
				end,
			})

			navic.setup(opts)
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},

	-- Version Control
	{ "tpope/vim-fugitive" },
	--{ 'junegunn/gv.vim' " not needed
	--{ 'junkblocker/git-time-lapse' " using :0Gclog instead
	{ "tpope/vim-rhubarb" },
	--{ 'airblade/vim-gitgutter' " performance issues 2021-08-24, try to update
	{
		"pwntester/octo.nvim",
		enabled = false, -- 2024-10-21 disable for now, not using much
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

	-- General Syntax
	--{ 'jiangmiao/auto-pairs' },
	{ "tpope/vim-endwise" },
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	--{ 'tpope/vim-repeat' },
	--{ 'Valloric/YouCompleteMe' " no ruby support, gocode is better for go, slow
	{ "preservim/nerdcommenter" },
	--{ 'ludovicchabant/vim-gutentags' " blocking too much
	{ "vitalk/vim-shebang" },
	-- { 'junegunn/vim-easy-align' " TODO: fix = mapping
	{ "ntpeters/vim-better-whitespace" },
	{ "rhysd/clever-f.vim" },
	{ "bogado/file-line", enabled = false, desc = "open file:line. disabling for now since I never use. cool though." },
	-- { 'vim-test/vim-test' }, -- not needed atm
	-- { 'wellle/context.vim' },-- cool but slow
	--{ "SirVer/ultisnips", event = { "InsertEnter" } }, -- slow
	--{ "honza/vim-snippets" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			--require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/luasnippets" })
			--require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.ultisnips" })

			local ls = require("luasnip")

			vim.keymap.set({ "i" }, "<C-K>", function()
				ls.expand()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-L>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-J>", function()
				ls.jump(-1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
	{ "yssl/QFEnter" }, -- quickfix helpers
	{ "godlygeek/tabular" },
	{
		"folke/which-key.nvim",
		enabled = true, -- this is fine but noisy and I don't use often
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			local wk = require("which-key")

			local opts = {
				win = {
					border = "single",
				},
			}

			wk.setup(opts)
		end,
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
			vim.g.vim_markdown_no_default_key_mappings = 1
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
	{ "kamailio/vim-kamailio-syntax", enabled = false },
	{ "bufbuild/vim-buf" },
	--{ "trayo/vim-ginkgo-snippets" },
	{ "buoto/gotests-vim" },
	{ "mracos/mermaid.vim", enabled = false },
	{ "direnv/direnv.vim" },
	--{ "pmizio/typescript-tools.nvim" },
	{ "joerdav/templ.vim" },
	{
		"phelipetls/jsonpath.nvim",
		enabled = false, -- can't get to work
	},

	-- Lint
	{
		"w0rp/ale",
		config = function()
			vim.g.ale_virtualtext_cursor = "current" -- only show virtualtext on current line
			--vim.g.ale_use_neovim_diagnostics_api = 0 -- disable diagnostic mode, affects other settings.
		end,
	},
	--{ "maximbaz/lightline-ale" },

	-- Testing
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

	-- Utility
	{ "tpope/tpope-vim-abolish" },
	{
		"gabrielpoca/replacer.nvim", -- replace using quickfix!
		--opts = {rename_files = false},
	},
	{ "mileszs/ack.vim" },
	{ "jremmen/vim-ripgrep" },
	{ "tpope/vim-eunuch" },
	--{ "tmhedberg/matchit" },
	{ "andymass/vim-matchup" },
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{ "junegunn/fzf.vim" },
	{ "stsewd/fzf-checkout.vim" },
	{ "dhulihan/vim-gtfo" }, -- dave's fork for horizontal splits
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

	-- Productivity
	{
		"epwalsh/pomo.nvim",
		enabled = false, -- cool but I don't use
		version = "*", -- Recommended, use latest release instead of latest commit
		lazy = true,
		cmd = { "TimerStart", "TimerRepeat" },
		dependencies = {
			-- Optional, but highly recommended if you want to use the "Default" timer
			"rcarriga/nvim-notify",
		},
		opts = {
			-- See below for full list of options 👇
		},
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
	{
		"NTBBloodbath/doom-one.nvim",
		config = function()
			--vim.g.doom_one_italic_comments = true
		end,
	},
	{ "rafi/awesome-vim-colorschemes" },
	{ "baskerville/bubblegum" },

	-- Files & Buffers
	{ "ton/vim-bufsurf" },
	{ "qpkorr/vim-bufkill" },
	--{ "gcmt/taboo.vim" }, -- interfering with bufferline tabs

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
				lualine_b = { "diff", { "diagnostics", sources = { "ale", "nvim_diagnostic" } } },
				lualine_c = { "filename" },
				lualine_x = {
					function()
						return require("copilot_status").status_string()
					end,
					"filetype",
				},
				lualine_y = {},
				lualine_z = { "progress", "location" },
			},
			inactive_sections = {
				--lualine_a = {},
				--lualine_b = {},
				lualine_c = { "filename" },
				--lualine_x = { "location" },
				--lualine_y = {},
				--lualine_z = {},
			},
			tabline = {},
			winbar = {
				lualine_c = {
					"navic",
					color_correction = nil,
					navic_opts = nil,
				},
			},
			inactive_winbar = {},
			extensions = {},
		},
	},
	{
		"nanozuki/tabby.nvim",
		-- event = 'VimEnter', -- if you want lazy load, see below
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local api = require("tabby.module.api")
			local win_name = require("tabby.feature.win_name")

			local theme = {
				fill = "TabLineFill",
				-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
				head = "TabLine",
				current_tab = "TabLineSel",
				tab = "TabLine",
				win = "TabLine",
				tail = "TabLine",
			}

			local window_count_icons = {
				[1] = "⠁",
				[2] = "⠃",
				[3] = "⠋",
				[4] = "⠛",
				[5] = "⠟",
				[6] = "⠿",
				[7] = "⠿⠁",
				[8] = "⠿⠃",
				[9] = "⠿⠋",
				[10] = "⠿⠛",
				[11] = "⠿⠟",
				[12] = "⠿⠿",
			}

			require("tabby").setup({
				--preset = "active_tab_with_wins",
				preset = "tab_only",
				line = function(line)
					return {
						{
							--{ "  ", hl = theme.head },
							{ "  ", hl = theme.head },
							line.sep("", theme.head, theme.fill),
						},
						line.tabs().foreach(function(tab)
							local hl = tab.is_current() and theme.current_tab or theme.tab
							local win = tab.current_win()
							return {
								line.sep("", hl, theme.fill),
								tab.is_current() and "" or "",
								win.file_icon(),
								tab.number(),
								tab.name(),
								tab.close_btn(""),
								--line.sep("", hl, theme.fill),
								line.sep("", hl, theme.fill),
								hl = hl,
								margin = " ",
							}
						end),
						-- right bar
						--line.spacer(),
						--line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
						--return {
						--line.sep("", theme.win, theme.fill),
						--win.is_current() and "" or "",
						--win.buf_name(),
						--line.sep("", theme.win, theme.fill),
						--hl = theme.win,
						--margin = " ",
						--}
						--end),
						--{
						--line.sep("", theme.tail, theme.fill),
						--{ "  ", hl = theme.tail },
						--},
						hl = "red",
					}
				end,
				option = {
					--theme = {
					--fill = "TabLineFill", -- tabline background
					--head = "TabLine", -- head element highlight
					--current_tab = "TabLineSel", -- current tab label highlight
					--tab = "TabLine", -- other tab label highlight
					--win = "TabLine", -- window highlight
					--tail = "TabLine", -- tail element highlight
					--},
					--nerdfont = true, -- whether use nerdfont
					lualine_theme = "doom-one", -- lualine theme name
					tab_name = {
						name_fallback = function(tabid)
							local wins = api.get_tab_wins(tabid)
							local cur_win = api.get_tab_current_win(tabid)
							local name = ""
							if api.is_float_win(cur_win) then
								name = "[Floating]"
							else
								name = win_name.get(cur_win)
							end

							--if #wins > 1 then
							--name = string.format("%s [%d]", name, #wins - 1)
							if #wins > 1 then
								name = string.format("%s %s", name, window_count_icons[#wins] or "?")
							end
							return name
						end,
					},
					buf_name = {
						--mode = "'unique'|'relative'|'tail'|'shorten'",
						mode = "unique",
					},
				},
			})

			---- call vim command
			--vim.cmd("tabby rename_tab " .. name)
			--end, { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>r", ":Tabby rename_tab ", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>g", ":Tabby jump_to_tab<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>w", ":Tabby pick_window<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>t", ":tabnew<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>c", ":tabclose<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>n", ":tabn<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>p", ":tabp<CR>", { noremap = true })

			-- move current tab to previous position
			vim.api.nvim_set_keymap("n", "<Tab>mp", ":-tabmove<CR>", { noremap = true })
			-- move current tab to next position
			vim.api.nvim_set_keymap("n", "<Tab>mn", ":+tabmove<CR>", { noremap = true })

			vim.api.nvim_set_keymap("n", "<Tab>1", ":1tabnext<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>2", ":2tabnext<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>3", ":3tabnext<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>5", ":5tabnext<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>6", ":6tabnext<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>7", ":7tabnext<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>8", ":8tabnext<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<Tab>9", ":9tabnext<CR>", { noremap = true })
		end,
	},
	{
		"akinsho/bufferline.nvim",
		enabled = false, -- cannot change tab name, no smart buffer nav
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				mode = "tabs",
				numbers = "buffer_id",
				--numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				separator_style = "slant",
				show_duplicate_prefix = false, -- don't show (Duplicate)
				show_close_icon = false, -- this is the close icon way to the right
				show_buffer_close_icons = false, -- for each tab
				show_tab_indicators = false, -- numbered icons way right side
				groups = {
					items = {
						{
							name = "Tests", -- Mandatory
							--highlight = { underline = false, sp = "blue" }, -- Optional
							priority = 2, -- determines where it will appear relative to other groups (Optional)
							icon = "", -- Optional
							matcher = function(buf) -- Mandatory
								--vim.print(buf)
								return buf.path:match("%_test") or buf.path:match("%_spec")
							end,
						},
					},
				},
			},

			--highlights = {
			--fill = {
			--bg = "blue",
			--},
			--background = {
			--bg = "green",
			--fg = "black",
			--},
			--tab_separator = {
			--bg = "green",
			--},
			--tab = {
			--bg = "red",
			--},
			--tab_selected = {
			--bg = "blue",
			--},
			--},
		},
	},
	{ "tyru/open-browser.vim" },
	--{ "majutsushi/tagbar" }, -- super slow in nvim, decent in nvim
	{
		"stevearc/aerial.nvim",
		opts = {
			--close_on_select = true, -- close when symbol selected
			layout = {
				resize_to_content = true,
				--default_direction = "right", -- always keep on right side
				default_direction = "float", -- floating window
				placement = "edge",
				min_width = 30,
				-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
				--max_width = { 100, 0.5 },
				--width = 40,
				win_opts = {
					wrap = true,
				},
			},
			float = {
				max_height = 0.7,
				relative = "win",
				override = function(conf)
					local padding = 1
					conf.anchor = "NE"
					conf.row = padding
					conf.col = vim.api.nvim_win_get_width(0) - padding
					return conf
				end,
			},
			--open_automatic_events = { "BufEnter", "InsertEnter", "FocusLost" },
			close_automatic_events = { "switch_buffer", "unfocus" }, -- close when you switch buffers
		},
		config = function(_, opts)
			local aerial = require("aerial")
			opts.open_automatic = function(bufnr)
				-- List of filetypes you want Aerial to open automatically for
				local auto_open_filetypes = {
					"markdown",
					"go",
					"lua",
				}

				-- Get the filetype of the buffer
				local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

				-- Check if the filetype is in the auto_open_filetypes list
				return vim.tbl_contains(auto_open_filetypes, filetype)
					-- Enforce a minimum line count
					and vim.api.nvim_buf_line_count(bufnr) > 40
					-- Enforce a minimum symbol count
					and aerial.num_symbols(bufnr) > 4
					-- A useful way to keep aerial closed when closed manually
					and not aerial.was_closed()
			end

			aerial.setup(opts)
		end,
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"wfxr/minimap.vim", -- sublime-style minimap
		config = function()
			--vim.g.minimap_width = 10
			--vim.g.minimap_auto_start = 1
			--vim.g.minimap_auto_start_win_enter = 1
			vim.g.minimap_highlight_search = 1 -- highlight search patterns
		end,
	}, -- requires code-minimap to be installed separately
	{ "ryanoasis/vim-devicons" },

	-- Build
	{ "tpope/vim-dispatch" },

	-- Local
	{ "vim-dotfiles", dev = true },
	{ "vim-conceal-secrets", dev = true },
	{ dir = "~/.private-vim-plugin" }, -- private plugin(s), `ln -s <plugin-dir> ~/.private-plugin.vim
}
