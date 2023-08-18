local M = {
    "lvimuser/lsp-inlayhints.nvim",
    cond = vim.g.vscode == nil,
    branch = "anticonceal",
    opts = {},
    lazy = true,
}

return M
