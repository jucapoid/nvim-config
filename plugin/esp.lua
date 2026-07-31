local group = vim.api.nvim_create_augroup("EspIdfProject", { clear = true })

local Manager = require("esp.manager")

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = group,
	callback = function(args)
		Manager.current(args.buf)
	end,
})
