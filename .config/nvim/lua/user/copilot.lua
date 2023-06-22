local M = {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
        if vim.g.neovide then
            require("copilot").setup {
                copilot_node_command = vim.fn.expand "$HOME" .. "/.nvm/versions/node/v16.17.0/bin/node",
            }
        else
            require("copilot").setup {}
        end
    end,
}

return M
