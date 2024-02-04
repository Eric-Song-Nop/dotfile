return {
	"kawre/leetcode.nvim",
	dev = false,
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- required by telescope
		"MunifTanjim/nui.nvim",

		-- optional
		"nvim-treesitter/nvim-treesitter",
		"rcarriga/nvim-notify",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		cn = {
			enabled = true,
		},
		image_support = false,
		injector = {
			["cpp"] = {
				before = { "#include <bits/stdc++.h>", "using namespace std;" }, ---@type string|string[]
				after = "", ---@type string|string[]
			},
			["java"] = {
				before = "import java.util.*;", ---@type string|string[]
			},
		},
	},
}
