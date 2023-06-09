local vim = vim
local lvim = lvim
--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
require("user.keymaps")

vim.opt.scrolloff = 5
vim.opt.exrc = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
-- vim.opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.o.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	-- pattern = "*.lua",
	timeout = 1000,
}

-- -- Change theme settings
local colorschemes = { "lunar", "gruvbox-material", "tokyonight-moon", "pink-ai", "doom-one", "catppuccin" }
lvim.colorscheme = colorschemes[6]
-- lvim.colorscheme = "lunar"
if vim.g.neovide == nil then
	vim.opt.background = "light"
else
	vim.opt.background = "dark"
end
vim.opt.background = "dark"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.dap.active = true
lvim.builtin.cmp.cmdline.enable = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.builtin.lualine.style = "lvim"

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer", "csharp_ls" })
local opts = {} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("csharp_ls", opts)
-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls.
-- IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--     return server ~= "clangd"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
lvim.lsp.on_attach_callback = function(client, bufnr)
	for index, data in ipairs(client) do
		print("index: " .. index .. "data: " .. data)

		-- for key, value in pairs(data) do
		-- 	print("\t", key, value)
		-- end
	end
	require("nvim-navbuddy").attach(client, bufnr)
	--   local function buf_set_option(...)
	--     vim.api.nvim_buf_set_option(bufnr, ...)
	--   end
	--   --Enable completion triggered by <c-x><c-o>
	--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local null_ls = require("null-ls")
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	-- null_ls.builtins.formatting.clang_format.with({
	--     extra_args = { "-style={BasedOnStyle: Microsoft,SortIncludes: Never}" }
	-- }),
	{
		command = "markdownlint",
		filetypes = { "markdown" },
	},
	{ command = "black", filetypes = { "python" } },
	{ command = "isort", filetypes = { "python" } },
	{ command = "stylua" },
	--   {
	--     command = "prettier",
	--     extra_args = { "--print-width", "100" },
	--     filetypes = { "typescript", "typescriptreact" },
	--   },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "markdownlint",
		filetypes = { "markdown" },
	},
	{ command = "flake8", filetypes = { "python" } },
	{
		command = "shellcheck",
		args = { "--severity", "warning" },
	},
	{
		command = "luacheck",
		filetypes = { "lua" },
	},
})

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	{
		"ionide/Ionide-vim",
		config = function()
			vim.cmd([[
let g:fsharp#fsautocomplete_command =
    \ [ 'dotnet',
    \   'fsautocomplete',
    \   '--background-service-enabled'
    \ ]
let g:fsharp#lsp_auto_setup = 0
]])
			require("ionide").setup({})
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
		opts = {},
		lazy = true,
		init = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
				callback = function(args)
					if not (args.data and args.data.client_id) then
						return
					end
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					require("lsp-inlayhints").on_attach(client, args.buf)
				end,
			})
		end,
	},
	{
		dir = vim.env.HOME .. "/.config/lvim/lua/user/colors/pink_ai",
	},
	{
		"kevinhwang91/rnvimr",
		cmd = { "RnvimrToggle" },
		config = require("user.rnvimr").config,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "folke/trouble.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		ft = { "markdown" },
		config = require("user.md").config,
	},
	{
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
	},
	{
		"notomo/cmdbuf.nvim",
	},
	-- {
	-- 	"shellRaining/hlchunk.nvim",
	-- 	dir = vim.env.HOME .. "/projects/hlchunk.nvim",
	-- 	event = { "UIEnter" },
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append("space:⋅")
			-- vim.opt.listchars:append("eol:↴")

			require("indent_blankline").setup({
				show_end_of_line = false,
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup()
		end,
	},
	{
		-- Use :number to pick and peek lines
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup({})
		end,
	},
	{
		-- Change surround: cs'"
		-- Surround word: ysiw)
		-- Delete surround: ds]
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"andweeb/presence.nvim",
		config = function()
			require("presence").setup({
				auto_update = true,
				neovim_image_text = "The One True Text Editor",
				main_image = "neovim",
				buttons = true,
			})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"wakatime/vim-wakatime",
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = {
			{ "<leader>S", "<cmd>SymbolsOutline<cr>", desc = "SymbolsOutline" },
		},
		config = function()
			require("symbols-outline").setup({
				auto_preview = true,
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "AerialToggle",
		config = function()
			require("aerial").setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
		end,
	},
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
			"numToStr/Comment.nvim", -- Optional
			"nvim-telescope/telescope.nvim", -- Optional
		},
	},
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
	},
	{
		"scalameta/nvim-metals",
		-- ft = { "scala" },
		config = function()
			require("user.metals").config()
		end,
	},
	{
		"NTBBloodbath/doom-one.nvim",
		init = require("user.doom").init,
		config = function() end,
	},
	{
		"rktjmp/lush.nvim",
	},
	{
		"Scysta/pink-panic.nvim",
	},
	{
		"catppuccin/nvim",
		config = require("catppuccin").setup({
			background = {
				-- :h background
				light = "latte",
				dark = "mocha",
			},
			-- flavour = "latte",
			transparent_background = (vim.g.neovide ~= nil),
			-- transparent_background = false,
		}),
	},
	{
		"sainnhe/gruvbox-material",
	},
	{
		"purescript-contrib/purescript-vim",
	},
	{
		-- <leader>mm
		"gorbit99/codewindow.nvim",
		config = function()
			local codewindow = require("codewindow")
			codewindow.setup({
				-- auto_enable = true,
				minimap_width = 13,
			})
			codewindow.apply_default_keybinds()
		end,
		keys = {
			{ "<leader>mm" },
		},
	},
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = "DiffviewOpen",
	},
	{
		"ggandor/flit.nvim",
		dependencies = {
			"ggandor/leap.nvim",
			"tpope/vim-repeat",
		},
		config = function()
			require("flit").setup({
				keys = { f = "f", F = "F", t = "t", T = "T" },
				-- A string like "nv", "nvo", "o", etc.
				labeled_modes = "nvo",
				multiline = false,
				-- Like `leap`s similar argument (call-specific overrides).
				-- E.g.: opts = { equivalence_classes = {} }
				opts = {},
			})
		end,
	},
	{
		"danymat/neogen",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip",
				languages = {
					["cpp.doxygen"] = require("neogen.configurations.cpp"),
				},
			})
		end,
		cmd = { "Neogen" },
	},
	"simrat39/rust-tools.nvim",
	{
		"saecki/crates.nvim",
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "rust", "toml" },
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
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"kaarmu/typst.vim",
		ft = "typst",
	},
}

require("dap").configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "Run or Test Target",
		metals = {
			runType = "runOrTestFile",
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "Test Target",
		metals = {
			runType = "testTarget",
		},
	},
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- Neovide related variables
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_cursor_vfx_particle_lifetime = 2.0
vim.g.neovide_cursor_vfx_particle_density = 10.0
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.opt.guifont = { "CaskaydiaCove Nerd Font Mono", ":h14" }
vim.api.nvim_set_var("neovide_transparency", 0.85)

-- lldb dap related
-- lvim.builtin.dap.on_config_done = require("user.llbd").config

-- rust
local rust_config = require("user.rust")

pcall(rust_config.rust_tools_config)
lvim.builtin.dap.on_config_done = rust_config.dap_config

function toggle_term_with(app_cmd)
	local Terminal = require("toggleterm.terminal").Terminal
	local gitui = Terminal:new({
		cmd = app_cmd,
		hidden = true,
		direction = "float",
		float_opts = {
			border = "double",
			width = function(_)
				return math.floor(vim.o.columns)
			end,
			height = function(_)
				return math.floor(vim.o.lines * 0.85)
			end,
		},
		on_open = function(_)
			vim.cmd("startinsert!")
		end,
		on_close = function(_) end,
		count = 99,
	})
	gitui:toggle()
end
