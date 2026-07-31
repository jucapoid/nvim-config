local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Keep cursor centered while searching
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Keep cursor centered while scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<leader>gg", "<cmd>Git<CR>", {
	desc = "Git",
})

map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", {
	desc = "Diffview",
})

map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", {
	desc = "File History",
})

map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", {
	desc = "Repository History",
})

map("n", "<leader>gc", "<cmd>Git commit<CR>", {
	desc = "Commit",
})

map("n", "<leader>gb", "<cmd>Git blame<CR>", {
	desc = "Blame",
})
