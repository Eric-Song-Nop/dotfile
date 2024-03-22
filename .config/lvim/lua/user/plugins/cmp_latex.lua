return {
	"amarakon/nvim-cmp-lua-latex-symbols",
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		table.insert(lvim.builtin.cmp.sources, { name = "lua-latex-symbols", option = { cache = true } })
	end,
}
