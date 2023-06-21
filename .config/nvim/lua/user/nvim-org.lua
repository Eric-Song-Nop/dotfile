local M = {
    {
        "nvim-orgmode/orgmode",
        lazy = false,
        config = function()
            require("orgmode").setup {}
            require("orgmode").setup_ts_grammar()

            -- Treesitter configuration
            require("nvim-treesitter.configs").setup {
                -- If TS highlights are not enabled at all, or disabled via `disable` prop,
                -- highlighting will fallback to default Vim syntax highlighting
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    -- Required for spellcheck, some LaTex highlights and
                    -- code block highlights that do not have ts grammar
                    additional_vim_regex_highlighting = { "org" },
                },
                ensure_installed = { "org" }, -- Or run :TSUpdate org
            }

            require("orgmode").setup {
                org_agenda_files = { "~/org/TODO.org", "~/Documents/nog-notes/**/*" },
                org_default_notes_file = "~/Documents/nog-notes/index.org",
            }
        end,
    },
    {
        "akinsho/org-bullets.nvim",
        ft = "org",
        config = function()
            require("org-bullets").setup()
        end,
    },
}

return M
