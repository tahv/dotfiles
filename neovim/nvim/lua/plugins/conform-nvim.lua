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

return {
  "stevearc/conform.nvim",
  lazy = true,
  cmd = "ConformInfo",
  -- event = { "BufWritePre" },
  dependencies = { "mason.nvim" },
  opts = {
    formatters_by_ft = {
      -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
      lua = { "stylua" },
      python = { "ruff_organize_imports", "ruff_format" },
      -- TOOD: toml, markdown, yaml
    },
  },
  keys = {
    { "<leader>cf", format_buffer, mode = { "n", "v" }, desc = "[F]ormat buffer" },
  },
}
