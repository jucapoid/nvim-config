return {
	{
		"stevearc/oil.nvim",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			default_file_explorer = true,

			view_options = {
				show_hidden = true,
			},

			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
			},
		},

		keys = {
			{
				"<leader>e",
				"<cmd>Oil<CR>",
				desc = "Explorer",
			},
			{
				"-",
				"<cmd>Oil<CR>",
				desc = "Parent Directory",
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",

			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},

		opts = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",

					sorting_strategy = "ascending",

					layout_config = {
						prompt_position = "top",
					},

					mappings = {
						i = {
							["<Esc>"] = actions.close,
						},
					},
				},

				pickers = {
					find_files = {
						hidden = true,
					},
				},

				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			telescope.load_extension("fzf")

			return {
				keys = {
					{
						"<leader>ff",
						builtin.find_files,
						desc = "Find Files",
					},
					{
						"<leader>fg",
						builtin.live_grep,
						desc = "Live Grep",
					},
					{
						"<leader>fb",
						builtin.buffers,
						desc = "Buffers",
					},
					{
						"<leader>fr",
						builtin.oldfiles,
						desc = "Recent Files",
					},
					{
						"<leader>fh",
						builtin.help_tags,
						desc = "Help",
					},
					{
						"<leader>fc",
						builtin.commands,
						desc = "Commands",
					},
					{
						"<leader>fk",
						builtin.keymaps,
						desc = "Keymaps",
					},
					{
						"<leader>fs",
						builtin.lsp_document_symbols,
						desc = "Document Symbols",
					},
					{
						"<leader>fS",
						builtin.lsp_workspace_symbols,
						desc = "Workspace Symbols",
					},
					{
						"<leader>fd",
						builtin.diagnostics,
						desc = "Diagnostics",
					},
					{
						"<leader>fw",
						builtin.grep_string,
						desc = "Find Word Under Cursor",
					},
				},
			}
		end,
	},
}
