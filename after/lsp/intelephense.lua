---@type vim.lsp.Config
return {
	settings = {
		intelephense = {
			files = {
				associations = { "*.php", "*.blade.php" },
			},
			environment = {
				includePaths = { "vendor/laravel/framework" },
			},
		},
	},
}
