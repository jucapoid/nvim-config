local boards = {
	["xiao-esp32s3"] = {
		target = "esp32s3",
		baud = 460800,
	},

	["xiao-esp32c3"] = {
		target = "esp32c3",
		baud = 460800,
	},
}

local Board = {}
Board.__index = Board

function Board.names()
	local names = {}

	for name in pairs(boards) do
		table.insert(names, name)
	end

	table.sort(names)

	return names
end

function Board.new(name)
	local config = boards[name]
	if not config then
		return nil
	end

	return setmetatable({
		name = name,
		config = config,
	}, Board)
end

function Board:target()
	return self.config.target
end

function Board:baud()
	return self.config.baud
end

return Board
