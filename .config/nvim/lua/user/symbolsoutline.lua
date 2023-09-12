local M = {
    {
        "simrat39/symbols-outline.nvim",
        cond = vim.g.vscode == nil,
        cmd = "SymbolsOutline",
        config = function()
            require("symbols-outline").setup()
        end,
    },
    {
        "stevearc/aerial.nvim",
        -- dev = true,
        opts = {},
        cond = vim.g.vscode == nil,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        cmd = "AerialToggle",
        config = function()
            require("aerial").setup {
                --     -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                --     on_attach = function(bufnr)
                --         -- Jump forwards/backwards with '{' and '}'
                --         vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                --         vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
                --     end,
            }
        end,
    },
    -- "Bekaboo/dropbar.nvim",
}
return M
