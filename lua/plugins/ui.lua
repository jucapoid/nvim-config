return {
	{
		"folke/which-key.nvim",

		event = "VeryLazy",

		opts = {
			preset = "modern",

			delay = 200,

			icons = {
				mappings = true,
			},

			spec = {
				{ "<leader>c", group = "Code" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>e", group = "ESP-IDF" },
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>l", group = "Laravel" },
				{ "<leader>n", group = "Files" },
				{ "<leader>r", group = "Refactor" },
				{ "<leader>w", group = "Workspace" },
				{ "<leader>x", group = "Diagnostics" },
			},
		},
	},
}
