local Doctor = require("esp.doctor")

local M = {}

local ns = vim.api.nvim_create_namespace("esp.status")

local function exists(value)
	return value ~= nil and value ~= ""
end

local function add_section(items, title, entries)
	table.insert(items, {
		type = "heading",
		label = title,
	})

	vim.list_extend(items, entries)
end

function M.collect(project)
	local items = {}

	add_section(items, "Configuration", {
		{
			label = "Board",
			value = project.state:get("board"),
			ok = exists(project.state:get("board")),
		},
		{
			label = "Target",
			value = project.state:get("target"),
			ok = exists(project.state:get("target")),
		},
		{
			label = "Port",
			value = project:port(),
			ok = exists(project:port()),
		},
		{
			label = "Baud",
			value = tostring(project:baud()),
			ok = true,
		},
	})

	add_section(items, "Project", {
		{
			label = "Root",
			value = project:root_path(),
			ok = true,
		},
		{
			label = "sdkconfig",
			value = "",
			ok = project:exists("sdkconfig"),
		},
		{
			label = "build/",
			value = "",
			ok = project:exists("build"),
		},
		{
			label = "compile_commands.json",
			value = "",
			ok = project:exists("compile_commands.json"),
		},
	})

	local diagnostics = Doctor.check(project)

	add_section(
		items,
		"Diagnostics",
		vim.tbl_map(function(check)
			return {
				label = check.message,
				value = "",
				ok = check.ok,
			}
		end, diagnostics)
	)

	return items
end

local function render(items)
	local lines = {
		"ESP-IDF Project",
		"",
	}

	for _, item in ipairs(items) do
		if item.type == "heading" then
			table.insert(lines, item.label)
		else
			local icon = item.ok and "✓" or "✗"

			if item.value ~= "" then
				table.insert(lines, string.format("%s %-24s %s", icon, item.label .. ":", item.value))
			else
				table.insert(lines, string.format("%s %s", icon, item.label))
			end
		end
	end

	return lines
end

function M.show(project)
	local items = M.collect(project)
	local lines = render(items)

	local width = 0
	for _, line in ipairs(lines) do
		width = math.max(width, vim.fn.strdisplaywidth(line))
	end

	local buf = vim.api.nvim_create_buf(false, true)

	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].modifiable = true

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	vim.bo[buf].modifiable = false

	local row = 0

	vim.api.nvim_buf_add_highlight(buf, ns, "Title", row, 0, -1)

	row = row + 2

	for _, item in ipairs(items) do
		if item.type == "heading" then
			vim.api.nvim_buf_add_highlight(buf, ns, "Title", row, 0, -1)
			row = row + 1
		else
			vim.api.nvim_buf_add_highlight(buf, ns, item.ok and "DiagnosticOk" or "DiagnosticError", row, 0, 1)

			if item.value ~= "" then
				vim.api.nvim_buf_add_highlight(buf, ns, "Identifier", row, 2, 26)
			end

			row = row + 1
		end
	end

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		style = "minimal",
		border = "rounded",
		width = width + 2,
		height = #lines,
		row = math.floor((vim.o.lines - #lines) / 2),
		col = math.floor((vim.o.columns - width - 2) / 2),
	})

	local function close()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	vim.keymap.set("n", "q", close, { buffer = buf, silent = true })
	vim.keymap.set("n", "<Esc>", close, { buffer = buf, silent = true })

	vim.api.nvim_create_autocmd({
		"BufLeave",
		"WinLeave",
	}, {
		buffer = buf,
		once = true,
		callback = close,
	})
end

return M
