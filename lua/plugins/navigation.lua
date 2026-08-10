local function select_close(opts)
	return {
		callback = function()
			require("oil").select(vim.tbl_extend("force", { close = true }, opts or {}))
		end,
		mode = "n",
	}
end

return {
	{
		"stevearc/oil.nvim",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			default_file_explorer = true,

			columns = {
				"icon",
				"size",
				"mtime",
			},

			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,

			float = {
				padding = 2,
				max_width = 100,
				max_height = 30,
				border = "rounded",
			},

			view_options = {
				show_hidden = true,
			},

			use_default_keymaps = false,

			keymaps = {
				["g?"] = { "actions.show_help", mode = "n", desc = "Help" },
				["q"] = { "actions.close", mode = "n", desc = "Close" },
				["<Esc>"] = { "actions.close", mode = "n", desc = "Close" },
				["<CR>"] = vim.tbl_extend("force", select_close(), { desc = "Open" }),
				["<C-s>"] = vim.tbl_extend("force", select_close({ vertical = true }), { desc = "Open VSplit" }),
				["<C-h>"] = vim.tbl_extend("force", select_close({ horizontal = true }), { desc = "Open HSplit" }),
				["<C-t>"] = vim.tbl_extend("force", select_close({ tab = true }), { desc = "Open Tab" }),
				["<C-p>"] = { "actions.preview", desc = "Preview" },
				["<C-c>"] = { "actions.close", mode = "n", desc = "Close" },
				["<C-l>"] = { "actions.refresh", desc = "Refresh" },
				["-"] = { "actions.parent", mode = "n", desc = "Parent Directory" },
				["_"] = { "actions.open_cwd", mode = "n", desc = "Open CWD" },
				["`"] = { "actions.cd", mode = "n", desc = "Cd Here" },
				["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n", desc = "Cd Here (Tab)" },
				["gs"] = { "actions.change_sort", mode = "n", desc = "Change Sort" },
				["gx"] = { "actions.open_external", desc = "Open Externally" },
				["g."] = { "actions.toggle_hidden", mode = "n", desc = "Toggle Hidden" },
				["g\\"] = { "actions.toggle_trash", mode = "n", desc = "Toggle Trash" },
			},
		},

		keys = {
			{
				"<leader>no",
				function()
					require("oil").open()
				end,
				desc = "Open Files",
			},
			{
				"<leader>nf",
				function()
					require("oil").toggle_float()
				end,
				desc = "Float Files",
			},
			{
				"<leader>ns",
				"<cmd>leftabove vsplit | Oil<CR>",
				desc = "Files Sidebar",
			},
			{
				"<leader>nc",
				function()
					require("oil").open(vim.fn.getcwd())
				end,
				desc = "Open CWD",
			},
			{
				"<leader>np",
				function()
					local path = vim.api.nvim_buf_get_name(0)
					if path == "" then
						require("oil").open()
						return
					end
					require("oil").open(vim.fs.dirname(path))
				end,
				desc = "Open Parent",
			},
			{
				"<leader>nh",
				function()
					local config = require("oil.config")
					config.view_options.show_hidden = not config.view_options.show_hidden
					require("oil").open()
				end,
				desc = "Toggle Hidden",
			},
			{
				"-",
				function()
					require("oil").open()
				end,
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
