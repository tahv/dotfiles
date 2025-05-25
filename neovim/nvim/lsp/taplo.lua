---@type vim.lsp.Config
return {
  settings = {},
  -- Required for taplo LSP to work in non-git repositories
  -- root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
}
