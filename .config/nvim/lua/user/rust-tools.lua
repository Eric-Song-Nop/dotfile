local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

local codelldb_path = mason_path .. "bin/codelldb"
local liblldb_path = mason_path .. "packages/codelldb/extension/lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname
--
-- The path in windows is different
if this_os:find "Windows" then
    codelldb_path = mason_path .. "packages\\codelldb\\extension\\adapter\\codelldb.exe"
    liblldb_path = mason_path .. "packages\\codelldb\\extension\\lldb\\bin\\liblldb.dll"
else
    -- The liblldb extension is .so for linux and .dylib for macOS
    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

local M = {
    {
        "simrat39/rust-tools.nvim",
        lazy = false,
        -- ft = "rust",
        config = function()
            require("rust-tools").setup {
                server = {
                    on_attach = function(client, bufnr)
                        local rt = require "rust-tools"
                        vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
                    end,

                    settings = {
                        ["rust-analyzer"] = {
                            lens = {
                                enable = true,
                            },
                            checkOnSave = {
                                enable = true,
                                command = "clippy",
                            },
                        },
                    },
                },
                tools = {
                    executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
                    reload_workspace_from_cargo_toml = true,
                    runnables = {
                        use_telescope = true,
                    },
                    inlay_hints = {
                        auto = false,
                    },
                    hover_actions = {
                        border = "rounded",
                    },
                    on_initialized = function()
                        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                            pattern = { "*.rs" },
                            callback = function()
                                local _, _ = pcall(vim.lsp.codelens.refresh)
                            end,
                        })
                    end,
                },
                dap = {
                    -- adapter= codelldb_adapter,
                    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
                },
            }
        end,
    },
    {
        "saecki/crates.nvim",
        lazy = false,
        version = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup {
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
                popup = {
                    border = "rounded",
                },
            }
        end,
    },
}

return M
