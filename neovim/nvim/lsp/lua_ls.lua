--  https://github.com/JohnnyMorganz/StyLua?tab=readme-ov-file#options
-- https://luals.github.io/wiki/settings/
---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      completion = { callSnippet = "Replace" },
      telemetry = { enable = false },
      codeLens = { enable = true },
      diagnostics = { disable = { "missing-fields" } },
      runtime = { version = "LuaJIT" },
    },
  },
}
