return {
	"folke/zen-mode.nvim",
	event = "VeryLazy",
  keys = {
    {
      "<leader>zz",
      function()
        require("zen-mode").toggle()
      end,
      desc = "Toggle Zen Mode"
    }
  },
}
