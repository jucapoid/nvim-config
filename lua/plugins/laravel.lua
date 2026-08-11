local function laravel()
	return _G.Laravel
end

return {
	{
		"adalessa/laravel.nvim",

		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
		},

		ft = { "php", "blade" },

		event = {
			"BufEnter composer.json",
			"VeryLazy",
		},

		keys = {
			{
				"<leader>ll",
				function()
					laravel().pickers.laravel()
				end,
				desc = "Laravel Picker",
			},
			{
				"<leader>la",
				function()
					laravel().pickers.artisan()
				end,
				desc = "Artisan Picker",
			},
			{
				"<leader>lr",
				function()
					laravel().pickers.routes()
				end,
				desc = "Routes Picker",
			},
			{
				"<leader>lm",
				function()
					laravel().pickers.make()
				end,
				desc = "Make Picker",
			},
			{
				"<leader>lc",
				function()
					laravel().pickers.commands()
				end,
				desc = "Custom Commands Picker",
			},
			{
				"<leader>lo",
				function()
					laravel().pickers.resources()
				end,
				desc = "Resources Picker",
			},
			{
				"<leader>lf",
				function()
					laravel().pickers.related()
				end,
				desc = "Related Files",
			},
			{
				"<leader>lv",
				function()
					laravel().commands.run("view:finder")
				end,
				desc = "View Finder",
			},
			{
				"<leader>lt",
				function()
					laravel().commands.run("actions")
				end,
				desc = "Code Actions",
			},
			{
				"<leader>lu",
				function()
					laravel().commands.run("hub")
				end,
				desc = "Artisan Hub",
			},
			{
				"<leader>lp",
				function()
					laravel().commands.run("command_center")
				end,
				desc = "Command Center",
			},
			{
				"<leader>lh",
				function()
					laravel().run("artisan docs")
				end,
				desc = "Documentation",
			},
			{
				"<C-g>",
				function()
					laravel().commands.run("view:finder")
				end,
				desc = "View Finder",
			},
			{
				"gf",
				function()
					local lv = laravel()
					if not lv then
						return "gf"
					end
					if lv.app("gf").cursorOnResource() then
						return "<cmd>lua Laravel.commands.run('gf')<cr>"
					end
					return "gf"
				end,
				expr = true,
				noremap = true,
				desc = "Go to Resource",
			},
		},

		opts = {
			features = {
				pickers = {
					provider = "telescope",
				},
			},
		},
	},
}
