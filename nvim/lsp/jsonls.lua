-- https://github.com/Microsoft/vscode/blob/main/extensions/json-language-features/server/README.md#settings
---@type vim.lsp.Config
return {
  settings = {
    json = {
      validate = { enable = true },
      schemas = {},
    },
  },
}
