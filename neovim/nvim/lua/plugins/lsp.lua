---@type LazySpec[]
return {
  {
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    "williamboman/mason.nvim",
    ---@type MasonSettings
    opts = {},
  },
  {
    -- Default LSP client configurations.
    -- No need to load the plugin, adding the plugin directory to runtimepath
    -- is enough to load `lsp/` configs.
    "neovim/nvim-lspconfig",
    lazy = true,
    init = function()
      local lazy_config = require("lazy.core.config")
      vim.opt.runtimepath:prepend(lazy_config.options.root .. "/nvim-lspconfig")
    end,
  },
  {
    -- Display LSP progress messages in the bottom right corner.
    "j-hui/fidget.nvim",
    opts = {},
  },
  -- TODO: try diagflow.nvim once this is fixed: https://github.com/dgagn/diagflow.nvim/issues/55
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
        toml = { "taplo" },
        yaml = {}, -- use yamlls lsp
        markdown = { "markdownlint-cli2" },
        python = { "ruff_organize_imports", "ruff_format", "trim_whitespace" },
      },
    },
    keys = {
      {
        "<leader>cf",
        function()
          -- Format with progression, adapted from:
          -- https://github.com/stevearc/conform.nvim/issues/250#issuecomment-1871929168
          local format_args = {
            timeout_ms = 3000,
            async = true,
            quiet = false,
            lsp_fallback = true,
          } --[[@as conform.FormatOpts]]

          local conform = require("conform")
          local have_fidget, fidget_progress = pcall(require, "fidget.progress")

          if not have_fidget then
            conform.format(format_args)
            return
          end

          local formatters = conform.list_formatters()
          local fmt_names = {}
          if not vim.tbl_isempty(formatters) then
            fmt_names = vim.tbl_map(function(f) return f.name end, formatters)
          elseif format_args["lsp_fallback"] == true then
            fmt_names = { "lsp" }
          else
            return
          end

          local msg_handle = fidget_progress.handle.create({
            title = string.format("fmt: %s", table.concat(fmt_names, ", ")),
            lsp_client = { name = "conform.nvim" },
            percentage = nil,
          })

          conform.format(format_args, function(err)
            msg_handle:finish()
            if err then
              vim.notify(err, vim.log.levels.WARN, { title = "formatting failed" })
            end
          end)
        end,
        mode = { "n", "v" },
        desc = "[f]ormat code",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "mypy" },
      }

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
  {
    -- Properly configures LuaLS for editing Neovim config.
    "folke/lazydev.nvim",
    enabled = true,
    ft = "lua",
    ---@type lazydev.Config
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        "lazy.nvim",
        "mason.nvim",
        "gitsigns",
        "snacks.nvim",
        "lazydev.nvim",
        "nvim-treesitter-context",
        "neogit",
        "indent-blankline.nvim",
        "Comment.nvim",
      },
    },
  },
}
