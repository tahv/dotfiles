-- Lightweight formatter plugin for Neovim

---Run all formatters on buffer.
local function format_buffer()
  require("conform").format({
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_fallback = true,
  })
end

---@type LazySpec
return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  event = { "BufReadPre", "BufNewFile" },
  ---@type conform.setupOpts
  opts = {
    -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
    formatters_by_ft = {
      lua = { "stylua" },
      toml = { "taplo" },
      yaml = {},  -- use yamlls lsp
      markdown = { "markdownlint-cli2" },
      python = { "ruff_organize_imports", "ruff_format" },
    },
  },
  keys = {
    { "<leader>cf", format_buffer, mode = { "n", "v" }, desc = "[F]ormat buffer" },
  },
}
