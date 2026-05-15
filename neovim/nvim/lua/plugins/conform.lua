--- Format current buffer with `conform.nvim` & report progression with `fidget.nvim`.
--- Adapted from: https://github.com/stevearc/conform.nvim/issues/250#issuecomment-1871929168
---@param opts? conform.FormatOpts
local function conform_format_with_progress(opts)
  local conform = require("conform")
  local have_fidget, fidget_progress = pcall(require, "fidget.progress")

  if not have_fidget then
    conform.format(opts)
    return
  end

  local formatters = conform.list_formatters()
  local fmt_names = {}
  if not vim.tbl_isempty(formatters) then
    fmt_names = vim.tbl_map(function(f) return f.name end, formatters)
  elseif (opts ~= nil) and (opts["lsp_fallback"] == true) then
    fmt_names = { "lsp" }
  else
    return
  end

  local msg_handle = fidget_progress.handle.create({
    title = string.format("fmt: %s", table.concat(fmt_names, ", ")),
    lsp_client = { name = "conform.nvim" },
    percentage = nil,
  })

  conform.format(opts, function(err)
    msg_handle:finish()
    if err then
      vim.notify(err, vim.log.levels.WARN, { title = "formatting failed" })
    end
  end)
end

---@type LazySpec[]
return {
  {
    -- Lightweight formatter plugin for Neovim
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    ---@type conform.setupOpts
    opts = {
      -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        toml = { "tombi" },
        yaml = { lsp_format = "first", "trim_newlines", "trim_whitespace" },
        markdown = { "rumdl", "trim_newlines", "trim_whitespace" },
        python = { "ruff_organize_imports", "ruff_format" },
        json = { lsp_format = "first" },
        ["_"] = { "trim_newlines", "trim_whitespace" },
      },
      formatters = {
        rustfmt = {
          options = {
            default_edition = "2024",
            nightly = true,
          },
        },
      },
    },
    keys = {
      {
        "<leader>cf",
        function()
          conform_format_with_progress({ timeout_ms = 3000, async = true, quiet = false, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "[f]ormat code",
      },
    },
  },
}
