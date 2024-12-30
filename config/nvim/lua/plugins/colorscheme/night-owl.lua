return {
  "oxfist/night-owl.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent_background = true,
  },
  init = function()
    vim.cmd([[ colorscheme night-owl ]])
  end,
}
