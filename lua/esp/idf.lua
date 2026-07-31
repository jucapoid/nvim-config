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

function Idf.new(project)
	local self = setmetatable({}, Idf)
	self.project = project
	return self
end

function Idf:executable()
	return "idf.py"
end

function Idf:is_available()
	return vim.fn.executable(self:executable()) == 1
end

function Idf:command(args)
	return build_command(self.project, args)
end

function Idf:run(args)
	require("tasks").run(table.concat(self:command(args), " "))
end

function Idf:flash()
	self:run({ "flash" })
end

function Idf:monitor()
	self:run({ "monitor" })
end

function Idf:clean()
	self:run({ "fullclean" })
end

function Idf:menuconfig()
	self:run({ "menuconfig" })
end

function Idf:erase_flash()
	self:run({ "erase-flash" })
end

return Idf
