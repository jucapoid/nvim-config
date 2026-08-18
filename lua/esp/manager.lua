local Project = require("esp.project")

local M = {}

local projects = {}

local function is_project_root(dir)
	if vim.fn.isdirectory(dir .. "/main") ~= 1 then
		return false
	end

	return vim.fn.filereadable(dir .. "/CMakeLists.txt") == 1
		or vim.fn.filereadable(dir .. "/sdkconfig") == 1
		or vim.fn.filereadable(dir .. "/sdkconfig.defaults") == 1
end

local function find_root(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if bufnr == 0 then
		bufnr = vim.api.nvim_get_current_buf()
	end

	local name = vim.api.nvim_buf_get_name(bufnr)
	local dir = name ~= "" and vim.fs.dirname(name) or vim.uv.cwd()

	while dir and dir ~= "" do
		if is_project_root(dir) then
			return vim.fs.normalize(dir)
		end

		local parent = vim.fs.dirname(dir)
		if parent == dir then
			break
		end
		dir = parent
	end

	return nil
end

function M.get(root)
	if not root then
		return nil
	end

	if not projects[root] then
		projects[root] = Project.new(root)
	end

	return projects[root]
end

function M.current(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if bufnr == 0 then
		bufnr = vim.api.nvim_get_current_buf()
	end

	local root = find_root(bufnr)

	if not root then
		local cwd = vim.fs.normalize(vim.uv.cwd())
		if is_project_root(cwd) then
			root = cwd
		end
	end

	local project = M.get(root)

	if project then
		project:setup(bufnr)
	end

	return project
end

function M.clear(root)
	projects[root] = nil
end

function M.clear_all()
	projects = {}
end

return M
