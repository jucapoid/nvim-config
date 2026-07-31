local group = vim.api.nvim_create_augroup("EspIdfProject", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = group,
	callback = function(args)
		local project = require("esp.project").current(args.buf)
		if not project then
			return
		end

		project:setup(args.buf)
	end,
})
