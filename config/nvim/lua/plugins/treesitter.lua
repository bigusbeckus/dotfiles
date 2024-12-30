return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },
  -- Extras
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter" }
  },
  {
    -- Additional text objects via treesitter (this is actually kinda insane)
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter" },
  },
  {
    "kiyoon/treesitter-indent-object.nvim",
    dependencies = { "nvim-treesitter" },
  },
  -- Language specific
  {
    "vrischmann/tree-sitter-templ",
    dependencies = { "nvim-treesitter" },
    opts = {},
  },
}
