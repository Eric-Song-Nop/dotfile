local M = {
    "j-hui/fidget.nvim",
    lazy = false,
    branch = "legacy",
    config = function()
        require("fidget").setup {}
    end,
}

return M
