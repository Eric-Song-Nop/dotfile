local M = {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
    cmd = "Neorg",
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/norg/notes",
                            work = "~/norg/work",
                            home = "~/norg/home",
                        },
                    },
                },
                ["core.integrations.telescope"] = {},
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.export"] = {},
                ["core.export.markdown"] = {},
                ["core.integrations.treesitter"] = {},
            },
        }
    end,
}

return M
