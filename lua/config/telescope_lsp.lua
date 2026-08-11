local M = {}

local function telescope()
	return require("telescope.builtin")
end

local function client_buffers(client)
	if client.attached_buffers then
		return vim.tbl_keys(client.attached_buffers)
	end

	if vim.lsp.get_buffers_by_client_id then
		return vim.lsp.get_buffers_by_client_id(client.id)
	end

	return {}
end

---@param method string
---@param prefer_current? boolean
---@return integer|nil bufnr
function M.bufnr_with_method(method, prefer_current)
	local current = vim.api.nvim_get_current_buf()

	if prefer_current ~= false then
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = current })) do
			if client:supports_method(method, current) then
				return current
			end
		end
	end

	for _, client in ipairs(vim.lsp.get_clients()) do
		if client:supports_method(method) then
			for _, bufnr in ipairs(client_buffers(client)) do
				if client:supports_method(method, bufnr) then
					return bufnr
				end
			end
		end
	end

	return nil
end

function M.notify_missing(feature)
	vim.notify(
		("No LSP client for %s. Open a source file in the project first."):format(feature),
		vim.log.levels.WARN
	)
end

---@param feature string
---@param method string
---@param picker fun(opts: table)
---@param opts? table
---@param prefer_current? boolean
function M.pick(feature, method, picker, opts, prefer_current)
	local bufnr = M.bufnr_with_method(method, prefer_current)
	if not bufnr then
		M.notify_missing(feature)
		return
	end

	picker(vim.tbl_extend("force", { bufnr = bufnr }, opts or {}))
end

function M.workspace_symbols(opts)
	M.pick("workspace symbols", "workspace/symbol", telescope().lsp_workspace_symbols, opts, false)
end

function M.document_symbols(opts)
	M.pick("document symbols", "textDocument/documentSymbol", telescope().lsp_document_symbols, opts, true)
end

function M.type_definitions(opts)
	M.pick("type definitions", "textDocument/typeDefinition", telescope().lsp_type_definitions, opts, true)
end

function M.references(opts)
	M.pick("references", "textDocument/references", telescope().lsp_references, opts, true)
end

function M.implementations(opts)
	M.pick("implementations", "textDocument/implementation", telescope().lsp_implementations, opts, true)
end

return M
