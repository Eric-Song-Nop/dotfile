local M = {
    "Eric-Song-Nop/launcher.nvim",
    cond = vim.g.vscode == nil,
    dev = true,
    cmd = "DRun",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
}

return M
