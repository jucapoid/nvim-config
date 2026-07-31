local State = require("esp.state")
local Serial = require("esp.serial")
local Idf = require("esp.idf")
local Board = require("esp.board")

local Project = {}
Project.__index = Project

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

function Project.new(root)
	local self = setmetatable({}, Project)

	self.root = root
	self.state = State.new(root)
	self.serial = Serial.new(root, self.state)
	self.idf = Idf.new(self)

	return self
end

function Project.current(bufnr)
	local root = find_root(bufnr)
	if not root then
		return nil
	end

	return Project.new(root)
end

function Project:setup(bufnr)
	bufnr = bufnr or 0
	vim.bo[bufnr].makeprg = "idf.py build"
end

function Project:build()
	vim.cmd.make()
end

function Project:flash()
	self.idf:flash()
end

function Project:monitor()
	self.idf:monitor()
end

function Project:clean()
	self.idf:clean()
end

function Project:menuconfig()
	self.idf:menuconfig()
end

function Project:erase_flash()
	self.idf:erase_flash()
end

function Project:set_target(target)
	self.state:set("target", target)
end

function Project:set_baud(baud)
	self.state:set("baud", baud)
end

function Project:set_board(name)
	local board = Board.new(name)
	if not board then
		return false
	end

	self:set_target(board:target())
	self:set_baud(board:baud())

	return true
end

function Project:port()
	return self.serial:current()
end

function Project:baud()
	return self.state:get("baud") or 460800
end

return {
	new = Project.new,
	current = Project.current,
}
