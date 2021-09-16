local lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- For omnisharp
local pid = vim.fn.getpid()

local omnisharp_bin = "/usr/bin/omnisharp"

lsp.omnisharp.setup{
  commands = {
    Format = {
      function()
        vim.lsp.buf.formatting()
      end
    }
  };
  cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
  capabilities = capabilities,
}

lsp.clangd.setup{
  capbilities = capabilities,
  cmd = { "clangd", "--background-index" , "--clang-tidy"},
  commands = {
    Format = {
      function()
        vim.lsp.buf.formatting()
      end
    }
  };
}

lsp.vimls.setup{
  capabilities = capabilities,
  commands = {
    Format = {
      function()
        vim.lsp.buf.formatting()
      end
    }
  };
}

lsp.pylsp.setup{
  capabilities = capabilities,
  commands = {
    Format = {
      function()
        vim.lsp.buf.formatting()
      end
    }
  };
}
