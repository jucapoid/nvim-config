local diagnostic_signs = {
	Error = "󰅚 ",
	Warn = "󰀪 ",
	Hint = "󰌶 ",
	Info = "󰋽 ",
}

for severity, icon in pairs(diagnostic_signs) do
	local hl = "DiagnosticSign" .. severity

	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = "",
	})
end

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = "if_many",
	},

	float = {
		border = "rounded",
		source = "if_many",
	},

	severity_sort = true,

	signs = true,

	underline = true,

	update_in_insert = false,
})
