local group = vim.api.nvim_create_augroup("Quickfix", {})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	group = group,
	pattern = "make",
	callback = function()
		local qf = vim.fn.getqflist()

		if #qf == 0 then
			return
		end

		vim.cmd("copen")

		for _, item in ipairs(qf) do
			if item.valid == 1 then
				vim.cmd("cc")
				return
			end
		end
	end,
})
