local M = {
    "ggandor/flit.nvim",
    lazy = false,
    dependencies = {
        {
            "ggandor/leap.nvim",
            dependencies = {
                "tpope/vim-repeat",
            },
            config = function()
                require("leap").add_default_mappings()
            end,
        },
    },
    config = function()
        require("flit").setup {
            keys = { f = "f", F = "F", t = "t", T = "T" },
            -- A string like "nv", "nvo", "o", etc.
            labeled_modes = "nvo",
            multiline = false,
            -- Like `leap`s similar argument (call-specific overrides).
            -- E.g.: opts = { equivalence_classes = {} }
            opts = {},
        }
    end,
}

return M
