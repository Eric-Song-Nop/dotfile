return {
    "kevinhwang91/rnvimr",
    cmd = { "RnvimrToggle" },
    keys = {
        { "<leader>ra", "<cmd>RnvimrToggle<cr>", desc = "Ranger Toggle" },
    },
    config = function()
        vim.g.rnvimr_enable_picker = 1
        vim.g.rnvimr_edit_cmd = "drop"
    end,
}
