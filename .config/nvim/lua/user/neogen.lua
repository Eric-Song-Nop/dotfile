local M = {
    "danymat/neogen",
    cond = vim.g.vscode == nil,
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
    config = true,
}

return M
