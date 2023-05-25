-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Cool binding to change selected text
lvim.keys.normal_mode["<leader>r"] = "*Ncgn"
lvim.keys.visual_mode["<leader>r"] = "*Ncgn"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

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

lvim.builtin.which_key.mappings["gg"] = {}

lvim.builtin.which_key.mappings["gi"] = {
	'<cmd>lua toggle_term_with("gitui")<cr>',
	"Gitui",
}

lvim.builtin.which_key.mappings["gt"] = {
	'<cmd>lua toggle_term_with("btm")<cr>',
	"btm",
}

lvim.builtin.which_key.mappings["n"] = {
	name = "Navbuddy & New instance",
	a = { "<cmd>Navbuddy<CR>", "navbuddy" },
}
