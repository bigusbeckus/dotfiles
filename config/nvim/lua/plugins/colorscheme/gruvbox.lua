return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent_mode = true,
  },
  init = function()
    vim.cmd([[ colorscheme gruvbox ]])
  end,
}
