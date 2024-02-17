local enable_ibl = false

if not enable_ibl then
  return
end

require("ibl").setup({
  debounce = 500,
  indent = {
    char = "▏",
  },
})
