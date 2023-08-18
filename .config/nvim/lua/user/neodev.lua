local M = {
    "folke/neodev.nvim",
    cond = vim.g.vscode == nil,
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
}

M.name = "neodev"
function M.config()
    require("neodev").setup {}
end

return M
