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
	require("tasks").run(table.concat(build_command(project, args), " "))
end

function Idf.new(project)
	local self = setmetatable({}, Idf)
	self.project = project
	return self
end

function Idf:flash()
	run(self.project, { "flash" })
end

function Idf:monitor()
	run(self.project, { "monitor" })
end

function Idf:clean()
	run(self.project, { "fullclean" })
end

function Idf:menuconfig()
	run(self.project, { "menuconfig" })
end

function Idf:erase_flash()
	run(self.project, { "erase-flash" })
end

return Idf
