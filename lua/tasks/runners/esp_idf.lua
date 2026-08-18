local M = {}

local Board = require("esp.board")
local Status = require("esp.status")
local Manager = require("esp.manager")

local function current_project()
	return Manager.current()
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
	with_project(function(project)
		project:build()
	end)
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

function M.select_board()
	with_project(function(project)
		vim.ui.select(Board.names(), {
			prompt = "Select ESP board",
		}, function(choice)
			if not choice then
				return
			end

			project:set_board(choice)
			vim.notify("Board set to " .. choice)
		end)
	end)
end

function M.select_port()
	with_project(function(project)
		vim.ui.select(project:ports(), {
			prompt = "Select ESP serial port",
		}, function(choice)
			if not choice then
				return
			end

			project:set_port(choice)
			vim.notify("Port set to " .. choice)
		end)
	end)
end

function M.status()
	with_project(function(project)
		Status.show(project)
	end)
end

return M
