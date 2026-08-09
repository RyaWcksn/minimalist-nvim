-- This is for plugin related
vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  callback = function()
    require("plugins.dap").setup()
  end,
})
