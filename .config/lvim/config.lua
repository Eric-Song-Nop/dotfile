lvim.colorscheme = "catppuccin"

lvim.builtin.cmp.cmdline.enable = true

vim.opt.relativenumber = true
vim.o.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = true

if vim.g.neovide then
	vim.o.guifont = "CaskaydiaMono Nerd Font:h15"
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
require("user.keys")
--#endregion

lvim.plugins = require("user.plugins")

lvim.builtin.bufferline.options = {
	-- mode = "tabs",
    show_tab_indicators = true,
}

-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
