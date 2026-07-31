local Project = require("esp.project")

local M = {}

local projects = {}
local initialized_buffers = {}

local markers = {
	"sdkconfig",
	"sdkconfig.defaults",
	"CMakeLists.txt",
}

local function find_root(bufnr)
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
	bufnr = bufnr or 0

	local root = find_root(bufnr)
	local project = M.get(root)

	if not project then
		return nil
	end

	if not initialized_buffers[bufnr] then
		project:setup(bufnr)
		initialized_buffers[bufnr] = true
	end

	return project
end

function M.clear(root)
	projects[root] = nil
end

function M.clear_all()
	projects = {}
	initialized_buffers = {}
end

return M
