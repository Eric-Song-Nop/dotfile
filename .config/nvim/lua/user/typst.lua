local M = {
    "kaarmu/typst.vim",
    cond = vim.g.vscode == nil,
    ft = { "typst" },
}

return M
