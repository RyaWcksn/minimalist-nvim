vim.api.nvim_create_autocmd('UIEnter', {
	callback = function()
		vim.cmd.colorscheme("miku")
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	end,
})
