-- https://ltex-plus.github.io/ltex-plus/settings.html
---@type vim.lsp.Config
return {
  filetypes = { "markdown", "text" },
  settings = {
    ltex = {
      -- can also be set per file via markdown yaml header (e.g. `lang: fr`)
      language = "en-US",
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "fr",
      },
      markdown = {
        nodes = { Link = "dummy" }, -- don't check link text
      },
    },
  },
}
