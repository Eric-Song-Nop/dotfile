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


