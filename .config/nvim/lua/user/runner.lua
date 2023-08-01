return {
    "stevearc/overseer.nvim",
    opts = {},
    cmd = { "OverseerRun", "OverseerToggle" },
    config = function()
        require("overseer").setup {
            task_list = {
                -- Default detail level for tasks. Can be 1-3.
                default_detail = 2,
                bindings = {
                    ["<C-A-q>"] = "OpenQuickFix",
                },
            },
        }
    end,
}
