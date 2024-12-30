-- Dumb but fun
return {
	"eandrju/cellular-automaton.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>kmn",
			"<cmd>CellularAutomaton make_it_rain<CR>",
			desc = "Make it Rain (Cellular Automaton)",
		},
		{
			"<leader>kms",
			"<cmd>CellularAutomaton game_of_life<CR>",
			desc = "Game of life (Cellular Automaton)",
		},
	},
}
