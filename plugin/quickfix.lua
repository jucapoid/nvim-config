local group = vim.api.nvim_create_augroup("Quickfix", { clear = true })

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	group = group,
	pattern = "make",
	callback = function()
		local qflist = vim.fn.getqflist()

		if vim.tbl_isempty(qflist) then
			return
		end

		vim.cmd("copen")

		for _, item in ipairs(qflist) do
			if item.valid == 1 then
				vim.cmd("cc")
				return
			end
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = group,
	pattern = "quickfix",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.wrap = false

		local opts = { buffer = true, silent = true }

		vim.keymap.set("n", "q", "<cmd>cclose<CR>", opts)
		vim.keymap.set("n", "<CR>", "<CR><C-w>p", opts)
	end,
})
