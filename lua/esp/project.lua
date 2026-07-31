local State = require("esp.state")
local Serial = require("esp.serial")
local Idf = require("esp.idf")
local Board = require("esp.board")

local Project = {}
Project.__index = Project

function Project.new(root)
	local self = setmetatable({}, Project)

	self.root = root
	self.state = State.new(root)
	self.serial = Serial.new(root, self.state)
	self.idf = Idf.new(self)

	return self
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

	self.state:set("board", name)
	self:set_target(board:target())
	self:set_baud(board:baud())

	return true
end

function Project:ports()
	return self.serial:candidates()
end

function Project:set_port(port)
	return self.serial:set(port)
end

function Project:port()
	return self.serial:current()
end

function Project:baud()
	return self.state:get("baud") or 460800
end

function Project:path(...)
	return vim.fs.joinpath(self.root, ...)
end

function Project:exists(...)
	return vim.uv.fs_stat(self:path(...)) ~= nil
end

function Project:root_path()
	return self.root
end

return {
	new = Project.new,
}
