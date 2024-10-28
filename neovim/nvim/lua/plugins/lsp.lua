---@type LazySpec[]
return {
  {
    --- Portable package manager for Neovim.
    "williamboman/mason.nvim",
    ---@type MasonSettings
    opts = {},
  },
  {
    --- Bridges mason.nvim with nvim-lspconfig.
    "williamboman/mason-lspconfig.nvim",
    ---@type MasonLspconfigSettings
    opts = {
      automatic_installation = true,
    },
  },
  {
    -- Display LSP progress messages in the bottom right corner.
    "j-hui/fidget.nvim",
    opts = {},
  },
  -- TODO: try diagflow.nvim once this is fixed: https://github.com/dgagn/diagflow.nvim/issues/55
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = { { "<leader>cR", ":LspRestart<CR>", desc = "[R]estart LSP Server" } },
    config = function()
      ---@param client vim.lsp.Client
      ---@param bufnr integer
      local function on_attach(client, bufnr)
        local tb = require("telescope.builtin")

        -- hover
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
        vim.keymap.set(
          "n",
          "<leader>k",
          vim.lsp.buf.signature_help,
          { buffer = bufnr, desc = "Hover Signature Documentation" }
        )
        -- go to
        vim.keymap.set("n", "gd", tb.lsp_definitions, { buffer = bufnr, desc = "[G]oto [D]efinition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "[G]oto [D]eclaration" })
        vim.keymap.set("n", "gy", tb.lsp_type_definitions, { buffer = bufnr, desc = "[G]oto T[y]pe Definition" })
        vim.keymap.set("n", "gr", tb.lsp_references, { buffer = bufnr, desc = "[G]oto [R]eferences" })
        vim.keymap.set("n", "gI", tb.lsp_implementations, { buffer = bufnr, desc = "[G]oto [I]mplementation" })

        -- search
        vim.keymap.set(
          "n",
          "<leader>ss",
          tb.lsp_document_symbols,
          { buffer = bufnr, desc = "[S]earch Document [S]ymbols" }
        )
        vim.keymap.set(
          "n",
          "<leader>sS",
          tb.lsp_dynamic_workspace_symbols,
          { buffer = bufnr, desc = "[S]earch Workspace [S]ymbols" }
        )

        -- actions
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]ename Symbol" })
        -- TODO: code actions in visual mode ?
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction" })

        -- toggle inlay hint
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          vim.keymap.set("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { buffer = bufnr, desc = "[T]oggle Inlay [H]ints" })
        end
      end

      -- --- @param override lsp.ClientCapabilities | nil
      -- local function override_capabilities(override)
      --   return vim.tbl_deep_extend("force", capabilities, override or {})
      -- end

      local lspconfig = require("lspconfig")

      local function get_capabilities()
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if has_cmp then
          return cmp_nvim_lsp.default_capabilities()
        end
        return vim.lsp.protocol.make_client_capabilities()
      end

      local capabilities = get_capabilities()

      -- https://docs.astral.sh/ruff/editors/settings
      -- https://docs.astral.sh/ruff/editors/setup/#neovim
      lspconfig["ruff"].setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
          on_attach(client, bufnr)
        end,
      } --[[@as lspconfig.Config]])

      -- https://microsoft.github.io/pyright/#/settings
      lspconfig["pyright"].setup({
        capabilities = capabilities,
        settings = {
          pyright = {
            disableOrganizeImports = true, -- Using Ruff's import organizer
          },
        },
      } --[[@as lspconfig.Config]])

      -- https://github.com/LuaLS/lua-language-server/blob/master/doc/en-us/config.md
      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
            codeLens = { enable = true },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      } --[[@as lspconfig.Config]])

      lspconfig["rust_analyzer"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      } --[[@as lspconfig.Config]])

      -- lspconfig["gopls"].setup({ capabilities = capabilities } --[[@as lspconfig.Config]])

      -- https://github.com/emacs-lsp/lsp-mode/blob/master/clients/lsp-pwsh.el
      lspconfig["powershell_es"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
      } --[[@as lspconfig.Config]])

      lspconfig["taplo"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        -- Tequired for taplo LSP to work in non-git repositories
        root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
      } --[[@as lspconfig.Config]])

      -- https://github.com/redhat-developer/yaml-language-server
      lspconfig["yamlls"].setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true
          on_attach(client, bufnr)
        end,
        settings = {
          yaml = {
            validate = true,
            keyOrdering = false,
            format = { enable = true },
            schemaStore = { enable = false },
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yml",
            },
          },
        },
      } --[[@as lspconfig.Config]])

      lspconfig["jsonls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          json = {
            validate = { enable = true },
            schemas = {},
          },
        },
      } --[[@as lspconfig.Config]])
    end,
  },
  {
    -- Lightweight formatter plugin for Neovim
    "stevearc/conform.nvim",
    -- TODO: report progress: https://github.com/stevearc/conform.nvim/issues/250#issuecomment-1871929168
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
        yaml = {}, -- use yamlls lsp
        markdown = { "markdownlint-cli2" },
        python = { "ruff_organize_imports", "ruff_format", "trim_whitespace" },
      },
    },
    keys = {
      {
        "<leader>cf",
        function()
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
            -- stylua: ignore
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
        desc = "[F]ormat buffer",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Add error codes to mypy
      lint.linters.mypy = {
        cmd = "mypy",
        stdin = false,
        ignore_exitcode = true,
        args = {
          "--show-column-numbers",
          "--show-error-end",
          "--hide-error-context",
          "--no-color-output",
          "--no-error-summary",
          "--no-pretty",
          "--python-executable",
          function()
            return vim.fn.exepath("python3") or vim.fn.exepath("python")
          end,
        },
        parser = require("lint.parser").from_pattern(
          "([^:]+):(%d+):(%d+):(%d+):(%d+): (%a+): (.*) %[(%a[%a-]+)%]",
          { "file", "lnum", "col", "end_lnum", "end_col", "severity", "message", "code" },
          {
            error = vim.diagnostic.severity.ERROR,
            warning = vim.diagnostic.severity.WARN,
            note = vim.diagnostic.severity.HINT,
          },
          { ["source"] = "mypy" },
          { end_col_offset = 0 }
        ),
      }

      lint.linters_by_ft = {
        python = { "mypy" },
      }

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    -- Properly configures LuaLS for editing Neovim config.
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = { { "Bilal2453/luvit-meta", lazy = true } },
    ---@type lazydev.Config
    opts = {
      library = {
        "lazy.nvim",
        "mason.nvim",
        "gitsigns",
        "mason-lspconfig.nvim",
        "lazydev.nvim",
        "nvim-treesitter-context",
        "neogit",
        "indent-blankline.nvim",
        "Comment.nvim",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
}
