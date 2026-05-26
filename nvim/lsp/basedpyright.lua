-- https://docs.basedpyright.com/v1.20.0/configuration/language-server-settings/
---@type vim.lsp.Config
return {
  cmd = { "basedpyright-langserver", "--stdio", "--ignoreexternal" },
  settings = {
    basedpyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
  },
}
