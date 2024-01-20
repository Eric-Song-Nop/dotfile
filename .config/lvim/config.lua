lvim.colorscheme = "gruvbox"

vim.opt.relativenumber = true
vim.o.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = true

if vim.g.neovide then
	vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h15"
	vim.g.neovide_transparency = 0.95
	vim.g.neovide_fullscreen = false
	vim.g.neovide_remember_window_size = true
	vim.g.transparency = 0.95
end

lvim.builtin.treesitter.indent = {
	disable = { "cpp" },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer", "clangd" })

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

local codelldb_path = mason_path .. "bin/codelldb"
local liblldb_path = mason_path .. "packages/codelldb/extension/lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname

-- The path in windows is different
if this_os:find("Windows") then
	codelldb_path = mason_path .. "packages\\codelldb\\extension\\adapter\\codelldb.exe"
	liblldb_path = mason_path .. "packages\\codelldb\\extension\\lldb\\bin\\liblldb.dll"
else
	-- The liblldb extension is .so for linux and .dylib for macOS
	liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

local clangd_flags = {
	"--background-index",
	"--fallback-style=Microsoft",
	"--all-scopes-completion",
	"--clang-tidy",
	"--log=error",
	"--suggest-missing-includes",
	"--cross-file-rename",
	"--completion-style=detailed",
	"--pch-storage=memory", -- could also be disk
	"--folding-ranges",
	"--enable-config", -- clangd 11+ supports reading from .clangd configuration file
	"--offset-encoding=utf-16", --temporary fix for null-ls
	-- "--limit-references=1000",
	-- "--limit-resutls=1000",
	-- "--malloc-trim",
	-- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
	-- "--header-insertion=never",
	-- "--query-driver=<list-of-white-listed-complers>"
}

local provider = "clangd"

local custom_on_attach = function(client, bufnr)
	require("lvim.lsp").common_on_attach(client, bufnr)

	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
	vim.keymap.set("x", "<leader>lA", "<cmd>ClangdAST<cr>", opts)
	vim.keymap.set("n", "<leader>lH", "<cmd>ClangdTypeHierarchy<cr>", opts)
	vim.keymap.set("n", "<leader>lt", "<cmd>ClangdSymbolInfo<cr>", opts)
	vim.keymap.set("n", "<leader>lm", "<cmd>ClangdMemoryUsage<cr>", opts)

	require("clangd_extensions.inlay_hints").setup_autocmd()
	require("clangd_extensions.inlay_hints").set_inlay_hints()
end

local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
if status_ok then
	clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
end

local custom_on_init = function(client, bufnr)
	require("lvim.lsp").common_on_init(client, bufnr)
	require("clangd_extensions.config").setup({})
	require("clangd_extensions.ast").init()
	vim.cmd([[
  command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
  command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
  command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
  command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
  command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
  ]])
end

local opts = {
	cmd = { provider, unpack(clangd_flags) },
	on_attach = custom_on_attach,
	on_init = custom_on_init,
}

require("lvim.lsp.manager").setup("clangd", opts)

pcall(function()
	require("rust-tools").setup({
		tools = {
			executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
			reload_workspace_from_cargo_toml = true,
			runnables = {
				use_telescope = true,
			},
			inlay_hints = {
				auto = true,
				only_current_line = false,
				show_parameter_hints = false,
				parameter_hints_prefix = "<-",
				other_hints_prefix = "=>",
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 7,
				highlight = "Comment",
			},
			hover_actions = {
				border = "rounded",
			},
			on_initialized = function()
				vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
					pattern = { "*.rs" },
					callback = function()
						local _, _ = pcall(vim.lsp.codelens.refresh)
					end,
				})
			end,
		},
		dap = {
			-- adapter= codelldb_adapter,
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
		server = {
			on_attach = function(client, bufnr)
				require("lvim.lsp").common_on_attach(client, bufnr)
				local rt = require("rust-tools")
				vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
			end,

			capabilities = require("lvim.lsp").common_capabilities(),
			settings = {
				["rust-analyzer"] = {
					lens = {
						enable = true,
					},
					checkOnSave = {
						enable = true,
						command = "clippy",
					},
				},
			},
		},
	})
end)

lvim.builtin.dap.on_config_done = function(dap)
	dap.adapters.codelldb = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
	dap.configurations.rust = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}
	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				local path
				vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
					path = input
				end)
				vim.cmd([[redraw]])
				return path
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}

	dap.configurations.c = dap.configurations.cpp
end

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ name = "stylua" },
	{ name = "ktlint" },
})

--#region Keymaps

vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })

lvim.builtin.which_key.mappings["C"] = {
	name = "Rust",
	r = { "<cmd>RustRunnables<Cr>", "Runnables" },
	t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
	m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
	c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
	p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
	d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
	v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
	R = {
		"<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
		"Reload Workspace",
	},
	o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
	y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
	P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
	i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
	f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
	D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
}

lvim.builtin.which_key.mappings["t"] = {
	name = "Tab",
	t = { "<cmd>tabnew<cr>", "New Tab" },
	l = { "<cmd>tabnext<cr>", "Next Tab" },
	h = { "<cmd>tabprevious<cr>", "Previous Tab" },
	L = { "<cmd>tablast<cr>", "Last Tab" },
	H = { "<cmd>tabfirst<cr>", "First Tab" },
}

lvim.builtin.which_key.mappings["bd"] = {
	{ "<cmd>Bd<cr>", "Delete Buffer" },
}

lvim.keys.normal_mode["L"] = ":bn<CR>"
lvim.keys.normal_mode["H"] = ":bp<CR>"

--#endregion

lvim.plugins = {
	"simrat39/rust-tools.nvim",
	{
		"saecki/crates.nvim",
		version = "v0.3.0",
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
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
					["core.export"] = { config = { extensions = "all" } },
					["core.export.markdown"] = {},
					["core.summary"] = {},
				},
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	"famiu/bufdelete.nvim",
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"smoka7/hydra.nvim",
		},
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
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
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "folke/trouble.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				on_attach = function(bufnr)
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
		end,
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
	},
	"wakatime/vim-wakatime",
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{
		"luisiacc/gruvbox-baby",
		priority = 1000,
		config = function()
			vim.g.gruvbox_baby_transparent_mode = 1
		end,
	},
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
	{
		"kawre/leetcode.nvim",
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
					before = { "#include <bits/stdc++.h>", "using namespace std;" }, ---@type string|string[],
					after = "", ---@type string|string[]
				},
				["java"] = {
					before = "import java.util.*;", ---@type string|string[]
				},
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = false,
				},
			})
		end,
	},
	{
		"p00f/clangd_extensions.nvim",
	},
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	config = function()
	-- 		require("fidget").setup()
	-- 	end,
	-- },
}

lvim.builtin.bufferline.options = {
	mode = "tabs",
}

-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
