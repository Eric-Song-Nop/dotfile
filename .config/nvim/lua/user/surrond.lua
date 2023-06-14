local M = {
    -- Change surround: cs'"
    -- Surround word: ysiw)
    -- Delete surround: ds]
    "kylechui/nvim-surround",
    lazy = false,
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup {}
    end,
}

return M
