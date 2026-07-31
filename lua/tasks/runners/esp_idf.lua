local tasks = require("tasks")

local M = {}

function M.build()
	tasks.make("idf.py build")
end

function M.flash()
	tasks.run("idf.py flash")
end

function M.monitor()
	tasks.run("idf.py monitor")
end

function M.clean()
	tasks.run("idf.py fullclean")
end

function M.menuconfig()
	tasks.run("idf.py menuconfig")
end

function M.erase_flash()
	tasks.run("idf.py erase-flash")
end

function M.set_target(target)
	tasks.run("idf.py set-target " .. target)
end

return M
