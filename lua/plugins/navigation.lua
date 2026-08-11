local function select_close(opts)
	return {
		callback = function()
			require("oil").select(vim.tbl_extend("force", { close = true }, opts or {}))
		end,
		mode = "n",
	}
end

local function current_file_dir()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		return vim.fn.getcwd()
	end
	return vim.fs.dirname(path)
end

local function telescope_builtin()
	return require("telescope.builtin")
end

local function telescope_lsp()
	return require("config.telescope_lsp")
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

		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

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
		end,

		keys = {
			{
				"<leader>ff",
				function()
					telescope_builtin().find_files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>f.",
				function()
					telescope_builtin().find_files({ cwd = current_file_dir() })
				end,
				desc = "Find Nearby Files",
			},
			{
				"<leader>fF",
				function()
					telescope_builtin().find_files({
						hidden = true,
						no_ignore = true,
						no_ignore_parent = true,
					})
				end,
				desc = "Find All Files",
			},
			{
				"<leader>fB",
				function()
					telescope_builtin().current_buffer_fuzzy_find()
				end,
				desc = "Fuzzy Buffer",
			},
			{
				"<leader>fg",
				function()
					telescope_builtin().live_grep()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>fb",
				function()
					telescope_builtin().buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fr",
				function()
					telescope_builtin().oldfiles()
				end,
				desc = "Recent Files",
			},
			{
				"<leader>fh",
				function()
					telescope_builtin().help_tags()
				end,
				desc = "Help",
			},
			{
				"<leader>f:",
				function()
					telescope_builtin().commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>fk",
				function()
					telescope_builtin().keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>fc",
				function()
					telescope_lsp().workspace_symbols({
						symbols = { "class", "interface", "enum", "struct", "type" },
					})
				end,
				desc = "Find Class",
			},
			{
				"<leader>fm",
				function()
					telescope_lsp().workspace_symbols({
						symbols = { "method", "function", "constructor" },
					})
				end,
				desc = "Find Method",
			},
			{
				"<leader>fs",
				function()
					telescope_lsp().document_symbols()
				end,
				desc = "Document Symbols",
			},
			{
				"<leader>fS",
				function()
					telescope_lsp().workspace_symbols()
				end,
				desc = "Workspace Symbols",
			},
			{
				"<leader>fT",
				function()
					telescope_lsp().type_definitions()
				end,
				desc = "Find Type",
			},
			{
				"<leader>fR",
				function()
					telescope_lsp().references()
				end,
				desc = "Find References",
			},
			{
				"<leader>fI",
				function()
					telescope_lsp().implementations()
				end,
				desc = "Find Implementations",
			},
			{
				"<leader>fd",
				function()
					telescope_builtin().diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>fw",
				function()
					telescope_builtin().grep_string()
				end,
				desc = "Find Word Under Cursor",
			},
		},
	},
}
