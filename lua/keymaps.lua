-- Using jk as ESC
vim.keymap.set("t", "jk", "<C-\\><C-n>")
vim.keymap.set({ "i", "v" }, "jk", "<esc>")

-- Completions
vim.keymap.set("i", "<Tab>", function()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true, noremap = true })

vim.keymap.set("i", "<S-Tab>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true, noremap = true })

vim.keymap.set("i", "<CR>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-y>"
	else
		return "<CR>"
	end
end, { expr = true, noremap = true })

-- Save
vim.keymap.set('n', '<leader><leader>', ':write<CR>')

-- Quit
vim.keymap.set('n', '<leader>q', ':quit<CR>')

-- Netrw
vim.keymap.set("n", "<leader>e", ":Lexplore<CR>", { silent = true })

-- Window
vim.keymap.set('n', '<leader>wk', "<c-w>k", { desc = "Switch Up" })
vim.keymap.set('n', '<leader>wj', "<c-w>j", { desc = "Switch Down" })
vim.keymap.set('n', '<leader>wh', "<c-w>h", { desc = "Switch Left" })
vim.keymap.set('n', '<leader>wl', "<c-w>l", { desc = "Switch Right" })

-- Find
vim.keymap.set("n", "<leader>f", ":find ", { silent = false })

-- Reload config
vim.keymap.set("n", "<leader>rr", ":restart<CR>", { silent = true })

-- Yank to EOL
vim.keymap.set("n", "Y", "y$", { silent = true })

-- Quickfix
vim.keymap.set('n', '<C-l>', ":cnext<CR>", { silent = true })
vim.keymap.set('n', '<C-h>', ":cprev<CR>", { silent = true })

-- Buffer
vim.keymap.set('n', '<leader>ba', ":w <bar> %bd <bar> e# <bar> bd# <CR>", { desc = "Delete All But This Buffer" })
vim.keymap.set('n', '<leader>bd', ":bd<CR>", { desc = "Delete This Buffer" })
