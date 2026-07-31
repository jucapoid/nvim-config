local M = {}

local function result(opts)
	return vim.tbl_extend("force", {
		id = "",
		severity = "info",
		ok = true,
		message = "",
		fix = nil,
	}, opts)
end

local function check_idf(project)
	local ok = project.idf:is_available()

	return result({
		id = "idf",
		severity = "error",
		ok = ok,
		message = ok and "idf.py is available" or "idf.py was not found in PATH",
	})
end

local function check_board(project)
	local board = project.state:get("board")
	local ok = board ~= nil and board ~= ""

	return result({
		id = "board",
		severity = "warning",
		ok = ok,
		message = ok and ("Board: " .. board) or "No board selected",
	})
end

local function check_target(project)
	local target = project.state:get("target")
	local ok = target ~= nil and target ~= ""

	return result({
		id = "target",
		severity = "warning",
		ok = ok,
		message = ok and ("Target: " .. target) or "No target selected",
	})
end

local function check_port(project)
	local port = project:port()
	local ok = port ~= nil and port ~= ""

	return result({
		id = "port",
		severity = "warning",
		ok = ok,
		message = ok and ("Serial port: " .. port) or "No serial port selected",
	})
end

local function check_sdkconfig(project)
	local ok = project:exists("sdkconfig")

	return result({
		id = "sdkconfig",
		severity = "warning",
		ok = ok,
		message = ok and "sdkconfig found" or "sdkconfig not found",
	})
end

local function check_build(project)
	local ok = project:exists("build")

	return result({
		id = "build",
		severity = "info",
		ok = ok,
		message = ok and "build directory exists" or "build directory has not been created",
	})
end

local function check_compile_commands(project)
	local ok = project:exists("compile_commands.json")

	return result({
		id = "compile_commands",
		severity = "info",
		ok = ok,
		message = ok and "compile_commands.json found" or "compile_commands.json not found",
	})
end

local checks = {
	check_idf,
	check_board,
	check_target,
	check_port,
	check_sdkconfig,
	check_build,
	check_compile_commands,
}

function M.check(project)
	local diagnostics = {}

	for _, check in ipairs(checks) do
		table.insert(diagnostics, check(project))
	end

	return diagnostics
end

return M
