local M = {
    "scalameta/nvim-metals",
    cond = vim.g.vscode == nil,
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
        local metals_config = require("metals").bare_config()
        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
        metals_config.settings = {
            superMethodLensesEnabled = true,
            showImplicitArguments = true,
            showInferredType = true,
            showImplicitConversionsAndClasses = true,
            excludedPackages = {},
        }
        metals_config.init_options.statusBarProvider = false
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "scala", "sbt", "java" },
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
        })
    end,
}

return M
