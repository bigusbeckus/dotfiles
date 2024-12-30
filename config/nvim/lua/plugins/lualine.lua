return {
  "nvim-lualine/lualine.nvim", -- Lualine
  dependencies = {
    {
      "kyazdani42/nvim-web-devicons",
      -- config = {
      --   opt = true,
      -- },
    },
  },
  opts = {
    options = {
      component_separators = "|",
      section_separators = "",
      icons_enabled = true,
      theme = "auto",
    },
  },
}
