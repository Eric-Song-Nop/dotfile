--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.exrc = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.foldmethod = "expr"                     -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.foldlevel = 99
-- general
lvim.log.level = "info"
lvim.format_on_save = {
    enabled = true,
    -- pattern = "*.lua",
    timeout = 1000,
}


-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["<leader>r"] = "*Ncgn"
lvim.keys.visual_mode["<leader>r"] = "*Ncgn"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"
lvim.colorscheme = "gruvbox-material"
-- lvim.colorscheme = "tokyonight-moon"
-- lvim.colorscheme = "pink-panic"
-- lvim.colorscheme = "doom-one"
vim.opt.background = "light"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "csharp_ls" })
local opts = {} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("csharp_ls", opts)
-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "markdownlint",
        filetypes = { "markdown" }
    },
    { command = "black", filetypes = { "python" } },
    { command = "isort", filetypes = { "python" } },
    --   { command = "stylua" },
    --   {
    --     command = "prettier",
    --     extra_args = { "--print-width", "100" },
    --     filetypes = { "typescript", "typescriptreact" },
    --   },
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        command = "markdownlint",
        filetypes = { "markdown" }
    },
    { command = "flake8", filetypes = { "python" } },
    {
        command = "shellcheck",
        args = { "--severity", "warning" },
    },
}

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
    {
        -- Use :number to pick and peek lines
        "nacro90/numb.nvim",
        config = function()
            require("numb").setup({
            })
        end
    },
    {
        -- Change surround: cs'"
        -- Surround word: ysiw)
        -- Delete surround: ds]
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
            })
        end
    },
    {
        "andweeb/presence.nvim",
    },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "wakatime/vim-wakatime"
    },
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        config = function()
            require("symbols-outline").setup()
        end
    },
    {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        dependencies = "hrsh7th/nvim-cmp",
        event = "InsertEnter",
    },
    {
        "scalameta/nvim-metals",
        ft = { 'scala' },
        config = function()
            require("user.metals").config()
        end,
    },
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    hover = {
                        enabled = false,
                    },
                    signature = {
                        enabled = false,
                    },
                    override = {
                            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                            ["vim.lsp.util.stylize_markdown"] = true,
                            ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
                -- add any options here
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },
    {
        'NTBBloodbath/doom-one.nvim',
        init = function()
            -- Add color to cursor
            vim.g.doom_one_cursor_coloring = false
            -- Set :terminal colors
            vim.g.doom_one_terminal_colors = true
            -- Enable italic comments
            vim.g.doom_one_italic_comments = false
            -- Enable TS support
            vim.g.doom_one_enable_treesitter = true
            -- Color whole diagnostic text or only underline
            vim.g.doom_one_diagnostics_text_color = false
            -- Enable transparent background
            vim.g.doom_one_transparent_background = false

            -- Pumblend transparency
            vim.g.doom_one_pumblend_enable = false
            vim.g.doom_one_pumblend_transparency = 20

            -- Plugins integration
            vim.g.doom_one_plugin_neorg = true
            vim.g.doom_one_plugin_barbar = false
            vim.g.doom_one_plugin_telescope = false
            vim.g.doom_one_plugin_neogit = true
            vim.g.doom_one_plugin_nvim_tree = true
            vim.g.doom_one_plugin_dashboard = true
            vim.g.doom_one_plugin_startify = true
            vim.g.doom_one_plugin_whichkey = true
            vim.g.doom_one_plugin_indent_blankline = true
            vim.g.doom_one_plugin_vim_illuminate = true
            vim.g.doom_one_plugin_lspsaga = false
        end,
        config = function()
        end
    },
    {
        "rktjmp/lush.nvim"
    },
    {
        "Scysta/pink-panic.nvim"
    },
    {
        "sainnhe/gruvbox-material"
    },
    {
        "purescript-contrib/purescript-vim",
    },
    {
        'quarto-dev/quarto-nvim',
        dependencies = {
            'jmbuhr/otter.nvim',
            'neovim/nvim-lspconfig'
        },
        config = function()
            require 'quarto'.setup {
                lspFeatures = {
                    enabled = true,
                    languages = { 'r', 'python', 'julia' },
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWrite" }
                    },
                    completion = {
                        enabled = true
                    }
                }
            }
        end
    },
    {
        -- <leader>mm
        'gorbit99/codewindow.nvim',
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup({
                -- auto_enable = true,
                minimap_width = 13,
            })
            codewindow.apply_default_keybinds()
        end,
    },
}
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.scala", "*.sbt", "*.sc" },
    callback = function() require('user.metals').config() end,
})
-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- Neovide related variables
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_cursor_vfx_particle_lifetime = 2.0
vim.g.neovide_cursor_vfx_particle_density = 10.0
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.opt.guifont = { "CaskaydiaCove Nerd Font Mono", ":h12" }
vim.api.nvim_set_var("neovide_transparency", 0.95)
