require("config.lazy")
require("config.settings")

require("lazy").setup({
	spec = "plugins",
	change_detection = {
		notify = false,
	},
	dev = {
		path = "~/Documents/Personal/nvim-plugins",
	},
})

require("config.remap")
require("config.semantics")
