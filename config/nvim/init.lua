require("beck.bootstrap_lazy")
require("beck.settings")
require("beck.plugins_v2")
require("beck.keys")

vim.o.background = "dark"
require("beck.colorscheme").apply()

-- Set colorscheme
-- vim.cmd("colorscheme catppuccin-frappe")
-- vim.cmd("colorscheme catppuccin-macchiato")
-- vim.cmd("colorscheme catppuccin-mocha")
-- vim.cmd("colorscheme gruvbox")
-- vim.cmd("colorscheme night-owl")
-- vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme onedark_dark")
-- vim.cmd("colorscheme onedark_vivid")
-- vim.cmd("colorscheme poimandres")
-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme vscode")

-- Neovide configs
if vim.g.neovide then
  require("beck.neovide")
end
