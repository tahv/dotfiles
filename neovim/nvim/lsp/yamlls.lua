-- https://github.com/redhat-developer/yaml-language-server
---@type vim.lsp.Config
return {
  settings = {
    yaml = {
      validate = true,
      keyOrdering = false,
      customTags = { "!reference sequence" },
      format = { enable = true },
      schemaStore = { enable = false },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yml",
      },
    },
  },
  -- on_attach = function(client, bufnr)
  --   client.server_capabilities.documentFormattingProvider = true
  -- end,
}
