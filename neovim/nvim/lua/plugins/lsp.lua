---Automatically install the following Mason packages.
local ensure_installed = {
  -- "basedpyright",
  "dockerfile-language-server",
  -- "gopls",
  "json-lsp",
  "lua-language-server",
  "markdownlint-cli2",
  -- "pyright",
  "ruff",
  "rust-analyzer",
  "stylua",
  "taplo",
  "ty",
  "typos-lsp",
  "yaml-language-server",
  "ltex-ls-plus",
}

---Enable the following lsp packages.
local enabled = {
  -- "basedpyright",
  "jsonls",
  "lua_ls",
  "powershell_es",
  -- "pyright",
  "ruff",
  "rust_analyzer",
  "taplo",
  "ty",
  "typos_lsp",
  "yamlls",
  "nushell",
  "ltex_plus",
}

---@type LazySpec[]
return {
  {
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    "williamboman/mason.nvim",
    ---@type MasonSettings
    opts = {},
    config = function(_, opts)
      local utils = require("utils")
      require("mason").setup(opts)
      -- Ensure installed
      local installed = require("mason-registry").get_installed_package_names()
      local missing = utils.difference(ensure_installed, installed)
      if next(missing) ~= nil then
        vim.cmd("MasonInstall " .. table.concat(missing, " "))
      end
      -- Remove unused
      local remove = utils.difference(installed, ensure_installed)
      if next(remove) ~= nil then
        vim.cmd("MasonUninstall " .. table.concat(remove, " "))
      end
      -- Enable lsp
      vim.lsp.enable(enabled)
    end,
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
        toml = { "taplo" },
        yaml = {}, -- use yamlls lsp
        markdown = { "markdownlint-cli2", "trim_whitespace" },
        python = {
          -- "ruff_fix",
          "ruff_format",
          "ruff_organize_imports",
          "trim_whitespace",
        },
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
        "tokyonight.nvim",
        "gitsigns.nvim",
        "snacks.nvim",
        "lazydev.nvim",
        "nvim-treesitter-context",
        "neogit",
        "indent-blankline.nvim",
        "Comment.nvim",
        "venv-selector.nvim",
      },
    },
  },
}
