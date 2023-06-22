vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
    callback = function()
        vim.cmd [[
          nnoremap <silent> <buffer> q :close<CR>
          set nobuflisted
        ]]
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd "tabdo wincmd ="
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 500 }
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    buffer = buffer,
    callback = function()
        vim.lsp.buf.format { async = false }
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.java" },
    callback = function()
        vim.lsp.codelens.refresh()
    end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        vim.cmd "hi link illuminatedWord LspReferenceText"
    end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        if line_count >= 5000 then
            vim.cmd "IlluminatePauseBuf"
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.name ~= "null-ls" then
            if client.server_capabilities.inlayHintProvider and client.name ~= "rust_analyzer" then
                print "Useing builtin"
                vim.lsp.buf.inlay_hint(bufnr, true)
            else
                print "Using inlay"
                require("lsp-inlayhints").on_attach(client, bufnr)
            end
        end
    end,
})
