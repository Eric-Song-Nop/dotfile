local plugins = {
	"simrat39/rust-tools.nvim",
	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
				popup = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	"famiu/bufdelete.nvim",
	require("user.plugins.flash"),
	require("user.plugins.multicursor"),
	require("user.plugins.ufo"),
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "folke/trouble.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	require("user.plugins.aerial"),
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
	},
	"wakatime/vim-wakatime",
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = { enabled = false },
				suggestions = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua" },
		event = "InsertEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup()
				require("copilot_cmp").setup()
			end, 100)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	require("user.plugins.leet"),
	require("user.plugins.noice"),
	{
		"p00f/clangd_extensions.nvim",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	require("user.plugins.lean"),
	require("user.plugins.gp"),
	require("user.plugins.cmp_latex"),
}

return plugins
