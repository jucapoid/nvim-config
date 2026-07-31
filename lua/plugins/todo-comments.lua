return {
	{
		"folke/todo-comments.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		opts = {},

		keys = {
			{
				"<leader>ft",
				"<cmd>TodoTelescope<CR>",
				desc = "Todo Comments",
			},
			{
				"<leader>xt",
				"<cmd>TodoTrouble<CR>",
				desc = "Todo Trouble",
			},
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next Todo",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous Todo",
			},
		},
	},
}
