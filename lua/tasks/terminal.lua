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

local function job_alive(job)
	if not job then
		return false
	end

	local status = vim.fn.jobwait({ job }, 0)[1]
	return status == -1
end

local function reset_job()
	state.job = nil
	state.buf = nil
end

function M.on_open(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local opts = { buffer = bufnr }

	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], vim.tbl_extend("force", opts, { desc = "Leave Terminal Mode" }))
	vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
	vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
	vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
	vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

	vim.keymap.set("n", "q", function()
		M.toggle()
	end, vim.tbl_extend("force", opts, { desc = "Hide Terminal" }))
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
		on_exit = function()
			reset_job()
		end,
	})

	M.on_open(state.buf)
	vim.cmd("wincmd p")
end

function M.open(cwd)
	cwd = cwd or state.cwd or vim.uv.cwd()

	if not job_alive(state.job) then
		if valid_window() then
			vim.api.nvim_win_close(state.win, true)
			state.win = nil
		end

		if valid_buffer() then
			vim.api.nvim_buf_delete(state.buf, { force = true })
		end

		reset_job()
	end

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

		reset_job()
		start_terminal(cwd)
		return
	end

	if not valid_window() then
		vim.cmd(("botright %dsplit"):format(state.height))
		state.win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(state.win, state.buf)
		M.on_open(state.buf)
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
	if not job_alive(state.job) then
		vim.notify("Terminal is not running. Toggle it with <leader>tt", vim.log.levels.WARN)
		return
	end
	vim.fn.chansend(state.job, cmd .. "\n")
end

return M
