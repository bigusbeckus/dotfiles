return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    transparent_background = true,
  },
  init = function()
    -- vim.cmd([[ colorscheme catppuccin ]])
    -- vim.cmd([[ colorscheme catppuccin-frappe ]])
    -- vim.cmd([[ colorscheme catppuccin-macchiato ]])
    vim.cmd([[ colorscheme catppuccin-mocha ]])
  end,
}
