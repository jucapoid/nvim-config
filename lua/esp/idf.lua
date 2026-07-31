local Idf = {}
Idf.__index = Idf

local function build_command(project, args)
	local cmd = { "idf.py" }

	local port = project:port()
	if port then
		table.insert(cmd, "-p")
		table.insert(cmd, port)
	end

	local baud = project:baud()
	if baud then
		table.insert(cmd, "-b")
		table.insert(cmd, tostring(baud))
	end

	vim.list_extend(cmd, args)
	return cmd
end

local function run(project, args)
	local cmd = build_command(project, args)
	require("tasks").run(table.concat(cmd, " "))
end

function Idf.new(root, state, serial)
	local self = setmetatable({}, Idf)
	self.root = root
	self.state = state
	self.serial = serial
	return self
end

function Idf:flash()
	run(self, { "flash" })
end

function Idf:monitor()
	run(self, { "monitor" })
end

function Idf:clean()
	run(self, { "fullclean" })
end

function Idf:menuconfig()
	run(self, { "menuconfig" })
end

function Idf:erase_flash()
	run(self, { "erase-flash" })
end

return Idf
