local M = {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "folke/trouble.nvim" },
    lazy = false,
    config = function()
        require("todo-comments").setup()
    end,
}

return M
