return {
    "kevinhwang91/rnvimr",
    cmd = { "RnvimrToggle" },
    config = function()
        vim.g.rnvimr_enable_picker = 1
        vim.g.rnvimr_edit_cmd = "drop"
    end,
}
