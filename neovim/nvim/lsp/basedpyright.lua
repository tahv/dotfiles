-- https://docs.basedpyright.com/v1.20.0/configuration/language-server-settings/
---@type vim.lsp.Config
return {
  cmd = { "basedpyright-langserver", "--stdio", "--ignoreexternal" },

  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- Using Ruff's import organizer
    },
  },
}
