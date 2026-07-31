local M = {}

local markers = {
	"sdkconfig",
	"sdkconfig.defaults",
	"CMakeLists.txt",
}

function M.root(bufnr)
	bufnr = bufnr or 0

	local name = vim.api.nvim_buf_get_name(bufnr)

	if name == "" then
		return nil
	end

	local dir = vim.fs.dirname(name)

	local found = vim.fs.find(markers, {
		path = dir,
		upward = true,
	})[1]

	if not found then
		return nil
	end

	local root = vim.fs.dirname(found)

	if vim.fn.isdirectory(root .. "/main") == 0 then
		return nil
	end

	return root
end

function M.is_project(bufnr)
	return M.root(bufnr) ~= nil
end

function M.setup(bufnr)
	bufnr = bufnr or 0

	local root = M.root(bufnr)

	if not root then
		return
	end

	vim.bo[bufnr].makeprg = "idf.py build"
end

return M
