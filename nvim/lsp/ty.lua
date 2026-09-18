-- https://docs.astral.sh/ty/reference/editor-settings/
---@type vim.lsp.Config
return {
  init_options = {
    experimental = {
      useUv = "scripts",
    },
  },
  settings = {
    ty = {
      diagnosticMode = "workspace",
    },
  },
}
