return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				-- Language servers
				"clangd",
				"lua-language-server",
				"phpactor",
				"pyright",

				-- Formatters
				"clang-format",
				"prettierd",
				"stylua",

				-- Debugger
				"codelldb",
			},

			auto_update = false,
			run_on_start = true,
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"bashls",
				"clangd",
				"cssls",
				"html",
				"jsonls",
				"lua_ls",
				"phpactor",
				"pyright",
				"ts_ls",
				"yamlls",
			},

			automatic_enable = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
	},

	{
		"j-hui/fidget.nvim",
		opts = {},
	},
}
