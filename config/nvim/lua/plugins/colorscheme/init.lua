if vim.g.selected_theme then
  return require("plugins.colorscheme" .. "." .. vim.g.selected_theme)
else
  return {}
end
