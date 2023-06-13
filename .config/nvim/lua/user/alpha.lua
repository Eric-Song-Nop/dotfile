local M = {
    "goolord/alpha-nvim",
    event = "VimEnter",
}

function M.config()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"
    dashboard.section.header.val = {
        [[         (      (              ]],
        [[   (     )\ )   )\ )           ]],
        [[   )\   (()/(  (()/(   (       ]],
        [[ (((_)   /(_))  /(_))  )\      ]],
        [[ )\___  (_))   (_))   ((_)     ]],
        [[((/ __| |_ _|  | _ \  | __|    ]],
        [[ | (__   | |   |   /  | _|     ]],
        [[  \___| |___|  |_|_\  |___|    ]],
        [[                               ]],
        [[    )                          ]],
        [[ ( /(                          ]],
        [[ )\())    )     (       )      ]],
        [[((_)\    /((    )\     (       ]],
        [[ _((_)  (_))\  ((_)    )\  '   ]],
        [[| \| |  _)((_)  (_)  _((_))    ]],
        [[| .` |  \ V /   | | | '  \()   ]],
        [[|_|\_|   \_/    |_| |_|_|_|    ]],
    }
    dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button(
            "p",
            " " .. " Find project",
            ":lua require('telescope').extensions.projects.projects()<CR>"
        ),
        dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }
    local function footer()
        return "Ericoolen's config from Lunarvim"
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
end

return M
