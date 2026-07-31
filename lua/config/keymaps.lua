local map = vim.keymap.set

vim.g.mapleader = " "

-- File
map("n", "<leader><leader>", "<cmd>w<CR>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- General
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Right Window" })

-- Keep cursor centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Git
map("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Git" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Diffview" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File History" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Repository History" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Commit" })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Blame" })

-- Tasks
map("n", "<leader>tt", function()
	require("tasks.terminal").toggle()
end, { desc = "Toggle Terminal" })

local esp = require("tasks.runners.esp_idf")

map("n", "<leader>eb", esp.build, { desc = "Build" })
map("n", "<leader>ef", esp.flash, { desc = "Flash" })
map("n", "<leader>em", esp.monitor, { desc = "Monitor" })
map("n", "<leader>ec", esp.clean, { desc = "Full Clean" })
map("n", "<leader>ek", esp.menuconfig, { desc = "Menuconfig" })
