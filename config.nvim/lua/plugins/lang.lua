-- Language-specific
return {
	-- LSP
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_enable = {
				exclude = { "gopls" }, -- do not run gopls by default
			},
		},
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
			--local lspconfig = require("lspconfig")

			-- json
			-- install with `npm i -g vscode-langservers-extracted`
			vim.lsp.config("jsonls", {})
			vim.lsp.enable("jsonls") -- enable ty lsp

			-- typescript
			-- note: tsserver has been renamed to ts_ls, because it is a wrapper around tsserver
			--lspconfig.ts_ls.setup({})
			-- 2025-01-30 disabling to try typescript-tools.nvim

			-- eslint for js/ts linting
			-- 2025-02-03 not working, need to fix
			--lspconfig.eslint.setup({
			--cmd = { "vscode-eslint-language-server", "--stdio" },
			--})

			-- golang
			--lspconfig.templ.setup({})
			--lspconfig.gopls.setup({}) -- crazy slow on startup

			-- lua
			vim.lsp.config("lua_ls", {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			})

			-- python
			vim.lsp.config("ty", {
				cmd = { "uvx", "ty", "server" },
				filetypes = { "python" },
				root_markers = { "ty.toml", "pyproject.toml", ".git" },
			})
			vim.lsp.enable("ty") -- enable ty lsp
			--vim.lsp.enable("ty")
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		enabled = false, -- disable when not performing active development, resource hog
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup({
				-- Only attach in directories with a package.json or tsconfig.json
				root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json"),
			})
		end,
	},
	{
		"SmiteshP/nvim-navic",
		desc = "code context from lsp, used for json navigration toolbar",
		opts = {
			click = true,
		},
		config = function(_, opts)
			local navic = require("nvim-navic")

			vim.lsp.config("jsonls", {
				on_attach = function(client, bufnr)
					navic.attach(client, bufnr)
				end,
			})

			navic.setup(opts)
		end,
	},
	{
		"j-hui/fidget.nvim", -- show lsp progress
		enabled = false, -- annoying in ts_ls
		opts = {
			-- options
		},
	},
	-- Lint
	{
		"w0rp/ale",
		config = function()
			vim.g.ale_linters = {
				go = {
					"golangci-lint",
					"gobuild",
					--"govet",
					--"golint",
				},
				proto = { "buf-check-lint" },
				ruby = { "rails_best_practices", "ruby", "rubocop" },
				terraform = { "tflint" },
				sql = { "sqlfluff" },
			}

			-- fixers
			vim.g.ale_fixers = {
				go = {
					"goimports",
					"gofmt",
				},
				lua = { "stylua" },
				json = { "prettier" },
				terraform = { "terraform" },
				sql = { "pgformatter" },
				javascript = { "prettier" },
				typescriptreact = { "prettier" },
				typescript = { "prettier" },
				python = { "autopep8", "isort" },
			}

			vim.g.disabled_ale_fixers = {
				python = { "black" },
				ruby = { "rufo" },
				sql = { "sqlint", "sqlfluff" },
			}

			vim.g.ale_virtualtext_cursor = "current" -- only show virtualtext on current line

			vim.g.ale_hover_to_floating_preview = 1
			vim.g.ale_floating_preview = 1

			--vim.g.ale_use_neovim_diagnostics_api = 0 -- disable diagnostic mode, affects other settings.
		end,
	},
	--{ "maximbaz/lightline-ale" },
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
			-- also can do :call mkdp#util#install()
			vim.fn["mkdp#util#install"]()
		end,
	},
	--{ "img-paste-devs/img-paste.vim" }, -- disabling in favor of img-clip
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		desc = "requires pngpaste",
		opts = {
			default = {
				relative_to_current_file = true,
				dir_path = function()
					--return vim.fn.expand("%:t:r") -- use relative dir
					return "." -- use relative dir
				end,
			},
		},
		keys = {},
	},
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
		config = function()
			require("jsonpath").setup({
				show_on_winbar = true,
			})
		end,
		enabled = false, -- can't get to work, using nvim-navic instead
	},
}
