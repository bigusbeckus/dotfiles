return {
  "olivercederborg/poimandres.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- disable_background = true,
    -- dim_nc_background = true, -- dim the 'non-current' window's background
    dark_variant = true,
    bold_vert_spilt = false,
    disable_italics = false,
  },
  init = function()
    vim.cmd([[ colorscheme poimandres ]])
  end,
}
