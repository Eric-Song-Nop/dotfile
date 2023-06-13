-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

local wk = require "which-key"

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Ufo
keymap("n", "zR", require("ufo").openAllFolds, opts)
keymap("n", "zM", require("ufo").closeAllFolds, opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Common save and quit
keymap("n", "<C-s>", "<cmd>w<CR>", opts)
keymap("n", "<C-q>", "<cmd>q<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Better paste
keymap("v", "p", "P", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
wk.register({
    e = {
        ":NvimTreeToggle<CR>",
        "Explorer",
    },
}, { prefix = "<leader>" })

-- Telescope
wk.register({
    s = {
        name = "Telescope",
        f = { ":Telescope find_files<CR>", "Find files" },
        t = { ":Telescope live_grep<CR>", "Search words" },
        p = { ":Telescope projects<CR>", "Projects" },
        b = { ":Telescope buffers<CR>", "Search Buffers" },
        k = { ":Telescope keymaps<CR>", "Search Keymaps" },
        c = { ":Telescope colorscheme<CR>", "Search colorscheme" },
    },
}, { prefix = "<leader>" })

-- Git
wk.register({
    g = {
        name = "Git",
        g = { "<cmd>lua _GITUI_TOGGLE()<CR>", "Gitui" },
        s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
        r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
        p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
        b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Preview blame" },
    },
}, { prefix = "<leader>" })

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- DAP
wk.register({
    d = {
        name = "Dap",
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "toggle breakpoint" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "continue" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "step into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "step over" },
        O = { "<cmd>lua require'dap'.step_out()<cr>", "step out" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "repl toggle" },
        l = { "<cmd>lua require'dap'.run_last()<cr>", "run last" },
        u = { "<cmd>lua require'dapui'.toggle()<cr>", "ui toggle" },
        t = { "<cmd>lua require'dap'.terminate()<cr>", "terminate" },
    },
}, { prefix = "<leader>" })
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>"         , opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>"        , opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>"        , opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>"         , opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>"      , opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>"         , opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>"         , opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>"        , opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
