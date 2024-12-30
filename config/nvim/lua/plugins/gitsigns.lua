return {
  "lewis6991/gitsigns.nvim", -- Gitsigns: Inline git blame
  event = "VeryLazy",
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 150,
    },
  },
}
