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
        "mhartington/formatter.nvim",
        cond = vim.g.vscode == nil,
        event = "BufWritePre",
        cmd = "FormatWrite",
        config = function()
            require("formatter").setup {
                log_level = vim.log.levels.INFO,
                filetype = {
                    c = {
                        require("formatter.filetypes.c").clangformat,
                    },
                    cpp = {
                        require("formatter.filetypes.c").clangformat,
                    },
                    cs = {
                        require("formatter.filetypes.c").clangformat,
                    },
                    go = {
                        require("formatter.filetypes.go").gofmt,
                    },
                    lua = {
                        require("formatter.filetypes.lua").stylua,
                    },
                    python = {
                        require("formatter.filetypes.lua").black,
                    },
                    -- toml = {
                    --     require("formatter.filetypes.toml").taplo,
                    -- },
                    ["*"] = {
                        -- "formatter.filetypes.any" defines default configurations for any
                        -- filetype
                        require("formatter.filetypes.any").remove_trailing_whitespace,
                    },
                },
            }
        end,
    },
}

return M
