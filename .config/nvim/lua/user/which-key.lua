local M = {
    "folke/which-key.nvim",
    cond = vim.g.vscode == nil,
    event = "VeryLazy",
}

function M.config()
    require("which-key").setup {}
end

return M
