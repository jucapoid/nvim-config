local map = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(event)
		local bufmap = function(keys, func, desc)
			map("n", keys, func, { buffer = event.buf, desc = desc })
		end

		bufmap("gd", vim.lsp.buf.definition, "Go to Definition")
		bufmap("gD", vim.lsp.buf.declaration, "Go to Declaration")
		bufmap("gr", vim.lsp.buf.references, "Go to References")
		bufmap("gi", vim.lsp.buf.implementation, "Go to Implementation")
		bufmap("K", vim.lsp.buf.hover, "Hover")
		bufmap("<leader>cr", vim.lsp.buf.rename, "Rename")
		bufmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		bufmap("<leader>cf", function()
			require("conform").format({ bufnr = event.buf, async = false, lsp_fallback = true })
		end, "Format Buffer")
	end,
})

map("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous Diagnostic" })

map("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic" })
