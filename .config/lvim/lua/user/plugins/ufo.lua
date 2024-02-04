return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
		lvim.keys.normal_mode["zR"] = require("ufo").openAllFolds
		lvim.keys.normal_mode["zM"] = require("ufo").closeAllFolds
	end,
}
