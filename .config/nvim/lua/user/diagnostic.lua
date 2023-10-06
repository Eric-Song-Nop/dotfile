local M = {
    {
        "kosayoda/nvim-lightbulb",
        cond = vim.g.vscode == nil,
        event = "VeryLazy",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
    },
    {
        "mfussenegger/nvim-lint",
        cond = vim.g.vscode == nil,
        event = "BufWritePre",
        config = function()
            require("lint").linters_by_ft = {
                markdown = { "vale" },
                python = { "flake8" },
            }
        end,
    },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup {
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python = { "isort", "black" },
                    -- Use a sub-list to run only the first available formatter
                    javascript = { { "prettierd", "prettier" } },
                    cpp = { "clang_format" },
                },
            }
        end,
    },
}

return M
