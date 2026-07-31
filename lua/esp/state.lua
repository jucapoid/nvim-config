local State = {}
State.__index = State

local function state_path(root)
	return root .. "/.nvim/esp.json"
end

local function ensure_dir(root)
	vim.fn.mkdir(root .. "/.nvim", "p")
end

local function decode(content)
	if not content or content == "" then
		return {}
	end

	local ok, data = pcall(vim.json.decode, content)
	if not ok or type(data) ~= "table" then
		return {}
	end

	return data
end

local function encode(data)
	local ok, content = pcall(vim.json.encode, data)
	if not ok then
		return "{}"
	end
	return content
end

function State.new(root)
	local self = setmetatable({}, State)
	self.root = root
	self.path = state_path(root)
	self.data = nil
	return self
end

function State:load()
	if self.data then
		return self.data
	end

	local fd = io.open(self.path, "r")
	if not fd then
		self.data = {}
		return self.data
	end

	local content = fd:read("*a")
	fd:close()

	self.data = decode(content)
	return self.data
end

function State:save()
	ensure_dir(self.root)

	local fd = assert(io.open(self.path, "w"))
	fd:write(encode(self:load()))
	fd:close()
end

function State:get(key)
	return self:load()[key]
end

function State:set(key, value)
	local data = self:load()
	data[key] = value
	self:save()
end

function State:all()
	return vim.deepcopy(self:load())
end

return State
