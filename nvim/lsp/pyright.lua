-- https://microsoft.github.io/pyright/#/settings
---@type vim.lsp.Config
return {
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Using Ruff's import organizer
    },
  },
}
