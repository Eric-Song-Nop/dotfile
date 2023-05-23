local M = {}
M.config = function(dap)
    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
            command = "codelldb",
            args = { "--port", "${port}" },

            -- On windows you may have to uncomment this:
            -- detached = false,
        },
    }

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                local path
                vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
                    path = input
                end)
                vim.cmd [[redraw]]
                return path
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    }

    dap.configurations.c = dap.configurations.cpp
end
return M
