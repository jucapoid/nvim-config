local M = {}

local state = {
	buf = nil,
	win = nil,
	job = nil,
	height = 15,
	cwd = nil,
}

local function valid_window()
	return state.win and vim.api.nvim_win_is_valid(state.win)
end

local function valid_buffer()
	return state.buf and vim.api.nvim_buf_is_valid(state.buf)
end

local function start_terminal(cwd)
	state.cwd = cwd

	if not valid_buffer() then
		state.buf = vim.api.nvim_create_buf(false, true)
	end

	if valid_window() then
		vim.api.nvim_win_set_buf(state.win, state.buf)
		return
	end

	vim.cmd(("botright %dsplit"):format(state.height))
	state.win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(state.win, state.buf)

	state.job = vim.fn.termopen(vim.o.shell, {
		cwd = cwd,
	})

	vim.cmd("wincmd p")
end

function M.open(cwd)
	cwd = cwd or state.cwd or vim.uv.cwd()

	if not state.job then
		start_terminal(cwd)
		return
	end

	if cwd ~= state.cwd then
		if valid_window() then
			vim.api.nvim_win_close(state.win, true)
			state.win = nil
		end

		if valid_buffer() then
			vim.api.nvim_buf_delete(state.buf, { force = true })
		end

		state.buf = nil
		state.job = nil

		start_terminal(cwd)
		return
	end

	if not valid_window() then
		vim.cmd(("botright %dsplit"):format(state.height))
		state.win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(state.win, state.buf)
		vim.cmd("wincmd p")
	end
end

function M.toggle()
	if valid_window() then
		vim.api.nvim_win_close(state.win, true)
		state.win = nil
	else
		M.open()
	end
end

function M.send(cmd, cwd)
	M.open(cwd)
	vim.fn.chansend(state.job, cmd .. "\n")
end

return M
