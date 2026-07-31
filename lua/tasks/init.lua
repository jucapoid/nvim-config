local M = {}

local terminal = require("tasks.terminal")

local markers = {
	"CMakeLists.txt",
	"composer.json",
	"package.json",
	".git",
}

function M.project_root()
	local path = vim.api.nvim_buf_get_name(0)

	if path == "" then
		return vim.uv.cwd()
	end

	local dir = vim.fs.dirname(path)

	local root = vim.fs.find(markers, {
		path = dir,
		upward = true,
	})[1]

	if root then
		return vim.fs.dirname(root)
	end

	return vim.uv.cwd()
end

function M.run(command)
	terminal.send(command, M.project_root())
end

M.terminal = terminal

return M
