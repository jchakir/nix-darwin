return {

	{
		"ray-x/starry.nvim",
		opts = {
			contrast = {
				enable = true,
				terminal = true,
			},
			text_contrast = {
				darker = true,
			},
			disable = {
				background = true, -- transparent background
			},
			style = {
				name = "monokai",
				disable = { "bold" },
				darker_contrast = true,
				deep_black = true,
			},
			custom_colors = {
				variable = "#00ABB3",
			},
			custom_highlights = {
				["@variable"] = { fg = "#A6CDC6" },
				["@field"] = { fg = "#00ABB3" },
			},
		},
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "starry",
		},
	},
}
