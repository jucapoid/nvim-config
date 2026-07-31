local M = {}

local function current_project()
	return require("esp.project").current()
end

function M.build()
	vim.cmd.make()
end

function M.flash()
	local project = current_project()
	if not project then
		vim.notify("ESP-IDF project not detected", vim.log.levels.WARN)
		return
	end
	project:flash()
end

function M.monitor()
	local project = current_project()
	if not project then
		vim.notify("ESP-IDF project not detected", vim.log.levels.WARN)
		return
	end
	project:monitor()
end

function M.clean()
	local project = current_project()
	if not project then
		vim.notify("ESP-IDF project not detected", vim.log.levels.WARN)
		return
	end
	project:clean()
end

function M.menuconfig()
	local project = current_project()
	if not project then
		vim.notify("ESP-IDF project not detected", vim.log.levels.WARN)
		return
	end
	project:menuconfig()
end

function M.erase_flash()
	local project = current_project()
	if not project then
		vim.notify("ESP-IDF project not detected", vim.log.levels.WARN)
		return
	end
	project:erase_flash()
end

function M.set_target(target)
	local project = current_project()
	if not project then
		vim.notify("ESP-IDF project not detected", vim.log.levels.WARN)
		return
	end
	project:set_target(target)
end

return M
