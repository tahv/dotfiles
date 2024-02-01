-- Portable package manager for Neovim.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters. 
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with the lspconfig plugin
  },
  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')

    mason.setup({})

    mason_lspconfig.setup({
      ensure_installed = {
        "pyright",
        "ruff_lsp",
        "rust_analyzer",
        "gopls",
        "lua_ls",
        "taplo",  -- toml
      },
    })
  end,
}
