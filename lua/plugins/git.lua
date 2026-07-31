return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,

			current_line_blame_opts = {
				delay = 300,
			},

			signs_staged_enable = true,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, {
						buffer = bufnr,
						desc = desc,
					})
				end

				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Previous Hunk")

				map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")

				map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")

				map("n", "<leader>hb", gs.blame_line, "Blame Line")
			end,
		},
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"sindrets/diffview.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		opts = {},
	},
}
