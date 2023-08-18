local M = {
    "j-hui/fidget.nvim",
    cond = vim.g.vscode == nil,
    lazy = false,
    branch = "legacy",
    config = function()
        require("fidget").setup {}
    end,
}

return M
