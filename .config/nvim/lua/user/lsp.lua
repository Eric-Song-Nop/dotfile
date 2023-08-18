local M = {
    "neovim/nvim-lspconfig",
    cond = vim.g.vscode == nil,
    lazy = true,
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
        },
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim",
            },
            opts = { lsp = { auto_attach = true } },
        },
    },
}

local cmp_nvim_lsp = require "cmp_nvim_lsp"
function M.config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
    capabilities = vim.tbl_deep_extend("force", capabilities, {
        offsetEncoding = { "utf-16" },
        general = {
            positionEncodings = { "utf-16" },
        },
    })

    local function lsp_keymaps(bufnr)
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap
        local wk = require "which-key"
        keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

        wk.register({
            l = {
                name = "Lsp",
                i = { "<cmd>LspInfo<cr>", "Lsp info" },
                I = { "<cmd>Mason<cr>", "Mason" },
                a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Coda action" },
                j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "Next diagnostic" },
                k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Previous diagnostic" },
                r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
                s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
                q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Diagnostic set loc list" },
            },
        }, { prefix = "<leader>", buffer = bufnr })
    end

    local lspconfig = require "lspconfig"
    local on_attach = function(client, bufnr)
        if client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
        end

        if client.name == "sumneko_lua" then
            client.server_capabilities.documentFormattingProvider = false
        end

        lsp_keymaps(bufnr)
        require("illuminate").on_attach(client)
    end

    for _, server in pairs(require("utils").servers) do
        Opts = {
            on_attach = on_attach,
            capabilities = capabilities,
            offset_encoding = "utf-16",
        }

        server = vim.split(server, "@")[1]

        local require_ok, conf_opts = pcall(require, "settings." .. server)
        if require_ok then
            Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
        end

        lspconfig[server].setup(Opts)
    end

    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- disable virtual text
        virtual_text = true,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
            suffix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

return M
