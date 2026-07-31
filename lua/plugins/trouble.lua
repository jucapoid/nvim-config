return {
	{
		"folke/trouble.nvim",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			focus = true,
			warn_no_results = false,
			open_no_results = false,
		},

		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<CR>",
				desc = "Workspace Diagnostics",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false<CR>",
				desc = "Symbols",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
				desc = "LSP",
			},
			{
				"<leader>xq",
				"<cmd>Trouble qflist toggle<CR>",
				desc = "Quickfix",
			},
			{
				"<leader>xr",
				"<cmd>Trouble loclist toggle<CR>",
				desc = "Location List",
			},
		},
	},
}
