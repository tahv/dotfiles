---@type vim.lsp.Config
return {
  settings = {
    powershell = {
      codeFormatting = { Preset = "OTBS" },
    },
  },
  init_options = {
    enableProfileLoading = false,
  },
  -- bundle_path = "C:/Users/tgambier/AppData/Local/nvim-data/mason/packages/powershell-editor-services",
}
