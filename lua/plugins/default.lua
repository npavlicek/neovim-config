return {
	"NMAC427/guess-indent.nvim",
	"lewis6991/gitsigns.nvim",
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		opts = {}
	},
	{
		"folke/which-key.nvim",
		opts = {},
		event = "VeryLazy",
		keys = {
			{
				"<leader>",
				function()
					require('which-key').show({ global = false })
				end,
				"Telescope keybinds",
			}
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{ 
				"nvim-tree/nvim-web-devicons",
				enabled = true,
			}
		},
		opts = {},
	},
	{
		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch='master',
		lazy = false,
		build = ":TSUpdate"
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-buffer" },
		},
		config = function(opts)
			local cmp = require('cmp')

			cmp.setup {
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
				})
			}

			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{name = 'path'}
				},
				{
					{ name = 'cmdline' }
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})

			local configs = {
				lua_ls = {
					settings = {
						Lua = {
							 workspace = {
							 	library = vim.api.nvim_get_runtime_file("", true),
							 },
						}
					}
				}
			}

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			for key, value in pairs(configs) do
				vim.lsp.enable(key)
				vim.lsp.config(key,
				vim.tbl_extend('error', value, {
					capabilities = capabilities,
				}))
			end
		end
	},
}
