return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    style = "night",
    styles = {
      -- sidebars = "transparent",
      -- floats = "transparent",
    },
    sidebars = { "qf", "help", "terminal", "packer" },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd([[ colorscheme tokyonight ]])
  end
}
