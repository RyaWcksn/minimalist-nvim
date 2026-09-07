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

-- Folding
vim.keymap.set("n", "<leader>kk", function()
	local linenr = vim.fn.line(".")
	-- If there's no fold to be opened/closed, do nothing.
	if vim.fn.foldlevel(linenr) == 0 then
		return
	end

	-- Open recursively if closed, close if open.
	local cmd = vim.fn.foldclosed(linenr) == -1 and "zc" or "zO"
	vim.cmd("normal! " .. cmd)
end, { silent = true, desc = "Folds: Toggle" })

-- Git blame current line: name - commit message - date
vim.keymap.set("n", "<leader>gg", function()
	local file = vim.fn.expand("%:p")
	if file == "" then return end
	local line = vim.fn.line(".")
	local git_root = vim.fs.root(file, { ".git" })
	if not git_root then
		vim.notify("Not in a git repo", vim.log.levels.WARN)
		return
	end
	git_root = git_root:gsub("/$", "")
	local prefix = git_root .. "/"
	local rel_path = file:sub(#prefix + 1)
	local out = vim.fn.systemlist(string.format(
		"git -C %s blame --line-porcelain -L %d,+1 -- %s",
		vim.fn.shellescape(git_root), line, vim.fn.shellescape(rel_path)))
	if vim.v.shell_error ~= 0 then
		vim.notify("git blame failed (untracked file?)", vim.log.levels.WARN)
		return
	end
	local author, summary, date = "", "", ""
	for _, l in ipairs(out) do
		if l:match("^author ") then
			author = l:sub(8)
		elseif l:match("^summary ") then
			summary = l:sub(9)
		elseif l:match("^author%-time ") then
			local t = tonumber(l:sub(13))
			if t then date = os.date("%Y-%m-%d", t) end
		end
	end
	if author == "" then return end
	print(string.format("%s - %s - %s", author, summary, date))
end, { desc = "Git blame current line" })
