local M = {
    "ionide/Ionide-vim",
    ft = "fsharp",
}

function M.config()
    vim.cmd [[
let g:fsharp#fsautocomplete_command =
    \ [ 'dotnet',
    \   'fsautocomplete',
    \   '--background-service-enabled'
    \ ]
]]
    vim.g["fsharp#lsp_auto_setup"] = 1
    require("ionide").setup {}
end

return M
