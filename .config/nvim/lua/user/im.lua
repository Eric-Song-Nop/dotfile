local M = {
    "Kicamon/im-switch.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("im-switch").setup {
            im = "fcitx5",
        }
    end,
}

return M
