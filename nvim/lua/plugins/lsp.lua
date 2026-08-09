---Adds LSP support for PEP 723 inline metadata scripts via `ty` lsp.
---Issue: https://github.com/astral-sh/ty/issues/691
---Inspired by: https://github.com/Jay-Madden/tylsp-pep723.nvim
local function setup_ty_autocmd()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function(_)
      local utils = require("utils")

      if vim.lsp.is_enabled("ty") then
        utils.err("'ty' LSP is already globally enabled")
        return
      end

      local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
      local has_inline_metadata = first_line:match("^# /// script") ~= nil

      if not has_inline_metadata then
        local config = vim.lsp.config["ty"]
        if config ~= nil then
          vim.lsp.start(config)
        end
        return
      end

      local filepath = vim.fn.expand("%:p")
      local filename = vim.fn.fnamemodify(filepath, ":t")
      local relpath = vim.fn.fnamemodify(filepath, ":.")
      local config = vim.deepcopy(vim.lsp.config["ty"] or {}) ---@type table
      config = vim.tbl_extend("force", config, {
        name = "ty-" .. filename,
        cmd = { "uvx", "--with-requirements", relpath, "ty", "server" },
        root_dir = vim.fn.fnamemodify(filepath, ":h"),
      })
      utils.info("Starting " .. config["name"])
      vim.lsp.start(config)
    end,
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil and client.name == "tombi" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

local function select_python_lsp()
  local py_clients = { "pyrefly", "ty", "zuban" }
  vim.ui.select(py_clients, {
    prompt = "Select LSP client",
  }, function(choice)
    if choice == nil then
      return
    end
    vim.lsp.enable(py_clients, false)
    require("utils").info("Disabled LSP: " .. table.concat(py_clients, ", "))
    vim.lsp.enable(choice)
    require("utils").info("Enabled LSP: " .. choice)
  end)
end

vim.api.nvim_create_user_command("SelectPyLsp", select_python_lsp, {})

---@type LazySpec[]
return {
  {
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    "williamboman/mason.nvim",
    ---@class tahv.MasonSettings: MasonSettings
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:crashdummyy/mason-registry", -- https://github.com/mason-org/mason-registry/pull/6330
      },
      ensure_installed = { ---@type string[] automatically install the following packages
        "dockerfile-language-server",
        "json-lsp",
        "just-lsp",
        "lua-language-server",
        "mpls",
        "pyrefly",
        "roslyn", -- registry: github:crashdummyy/mason-registry
        "ruff",
        "rumdl",
        "rust-analyzer",
        "stylua",
        "tombi",
        "tree-sitter-cli", -- required by `nvim-treesitter`
        "ty",
        "typos-lsp",
        "yaml-language-server",
        "ltex-ls-plus",
        "zuban",
      },
      enabled = { ---@type string[] Enable the following lsp packages
        "jsonls",
        "just",
        "lua_ls",
        "powershell_es",
        -- "pyrefly",
        "ruff",
        "rumdl",
        "rust_analyzer",
        "tombi",
        "ty",
        "typos_lsp",
        "yamlls",
        "mpls",
        "nushell",
        "ltex_plus",
        -- "zuban",
      },
    },
    ---@param opts tahv.MasonSettings
    config = function(_, opts)
      require("mason").setup(opts)
      local utils = require("utils")

      -- Install missing
      local installed = require("mason-registry").get_installed_package_names()
      local missing = utils.difference(opts.ensure_installed, installed)
      if next(missing) ~= nil then
        vim.cmd("MasonInstall " .. table.concat(missing, " "))
      end

      -- Remove unused
      local remove = utils.difference(installed, opts.ensure_installed)
      if next(remove) ~= nil then
        vim.cmd("MasonUninstall " .. table.concat(remove, " "))
      end

      -- -- Enable ty with support for inline metadata
      -- if utils.tbl_remove(opts.enabled, "ty") then
      --   setup_ty_autocmd()
      -- end

      -- Enable lsp
      vim.lsp.enable(opts.enabled)
    end,
  },
  {
    -- Default LSP client configurations.
    -- No need to load the plugin,
    -- adding the plugin directory to runtimepath is enough to load `lsp/` configs.
    "neovim/nvim-lspconfig",
    lazy = true,
    init = function() vim.opt.runtimepath:prepend(require("lazy.core.config").options.root .. "/nvim-lspconfig") end,
  },
  {
    -- Display LSP progress messages in the bottom right corner.
    "j-hui/fidget.nvim",
    opts = {},
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lint").linters_by_ft = {
        python = { "mypy" },
      }

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        -- TODO(tga): progression: https://github.com/mfussenegger/nvim-lint/issues/906
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
        { path = "lazy.nvim", words = { "Lazy" } },
        { path = "markview.nvim", words = { "markview" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        "mason.nvim",
        "render-markdown.nvim",
        "tokyonight.nvim",
        "gitsigns.nvim",
        "lazydev.nvim",
        "nvim-treesitter-context",
      },
    },
  },
  {
    -- C# Roslyn LSP
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      broad_search = true,
    },
  },
}
