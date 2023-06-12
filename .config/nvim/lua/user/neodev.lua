local M = {
    "folke/neodev.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
}

M.name = "neodev"
function M.config()
    require("neodev").setup {}
end

return M
