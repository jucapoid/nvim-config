local Serial = {}
Serial.__index = Serial

local function shell_list(cmd)
	local output = vim.fn.systemlist(cmd)
	if vim.v.shell_error ~= 0 then
		return {}
	end
	return output
end

local function existing(path)
	return path and path ~= "" and vim.uv.fs_stat(path) ~= nil
end

local function select_from_list(items, prompt)
	if #items == 0 then
		return nil
	end

	if #items == 1 then
		return items[1]
	end

	local choice = vim.fn.inputlist(vim.list_extend({ prompt }, items))
	if choice < 1 or choice > #items then
		return nil
	end

	return items[choice]
end

function Serial.new(root, state)
	local self = setmetatable({}, Serial)
	self.root = root
	self.state = state
	return self
end

function Serial:candidates()
	local items = {}

	local by_id = shell_list("sh -lc 'ls -1 /dev/serial/by-id 2>/dev/null'")
	for _, name in ipairs(by_id) do
		table.insert(items, "/dev/serial/by-id/" .. name)
	end

	if #items > 0 then
		return items
	end

	local tty_acm = shell_list("sh -lc 'ls -1 /dev/ttyACM* 2>/dev/null'")
	for _, item in ipairs(tty_acm) do
		table.insert(items, item)
	end

	local tty_usb = shell_list("sh -lc 'ls -1 /dev/ttyUSB* 2>/dev/null'")
	for _, item in ipairs(tty_usb) do
		table.insert(items, item)
	end

	return items
end

function Serial:current()
	local cached = self.state:get("port")
	if existing(cached) then
		return cached
	end

	local items = self:candidates()
	local selected = select_from_list(items, "Select ESP serial port:")
	if not selected then
		return nil
	end

	self.state:set("port", selected)
	return selected
end

function Serial:set(port)
	if existing(port) then
		self.state:set("port", port)
		return port
	end

	return nil
end

return Serial
