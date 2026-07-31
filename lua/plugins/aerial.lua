return {
	{
		"stevearc/aerial.nvim",

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			backends = {
				"lsp",
				"treesitter",
				"markdown",
				"man",
			},

			layout = {
				min_width = 30,
				default_direction = "right",
			},

			attach_mode = "global",

			show_guides = true,

			filter_kind = false,
		},

		keys = {
			{
				"<leader>a",
				"<cmd>AerialToggle!<CR>",
				desc = "Toggle Outline",
			},
			{
				"{",
				"<cmd>AerialPrev<CR>",
				desc = "Previous Symbol",
			},
			{
				"}",
				"<cmd>AerialNext<CR>",
				desc = "Next Symbol",
			},
		},
	},
}
