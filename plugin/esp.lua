local group = vim.api.nvim_create_augroup("EspIdfProject", {})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = group,
	callback = function(args)
		require("esp.project").setup(args.buf)
	end,
})
