local M = {}

local function current_project()
	return require("esp.project").current()
end

local function with_project(fn)
	local project = current_project()
	if not project then
		vim.notify("ESP-IDF project not detected", vim.log.levels.WARN)
		return
	end

	fn(project)
end

function M.build()
	vim.cmd.make()
end

function M.flash()
	with_project(function(project)
		project:flash()
	end)
end

function M.monitor()
	with_project(function(project)
		project:monitor()
	end)
end

function M.clean()
	with_project(function(project)
		project:clean()
	end)
end

function M.menuconfig()
	with_project(function(project)
		project:menuconfig()
	end)
end

function M.erase_flash()
	with_project(function(project)
		project:erase_flash()
	end)
end

function M.set_target(target)
	with_project(function(project)
		project:set_target(target)
	end)
end

return M
