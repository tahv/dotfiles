---On attach overrides for specific LSP clients.
---@type { [string]: fun(lsp.Client): nil}
local clients_overrides = {
  ["ruff"] = function(client)
    client.server_capabilities.hoverProvider = false -- Disable hover in favor of Pyright
  end,
}

local function toggle_inlay_hint()
  ---@diagnostic disable-next-line: missing-parameter
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

---@param event any
local function lsp_attach_callback(event)
  ---@param keys string
  ---@param func fun(): nil
  ---@param desc string
  local function map(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
  end

  local telescope_builtin = require("telescope.builtin")

  -- hover
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  map("<leader>k", vim.lsp.buf.signature_help, "Hover Signature Documentation")

  -- goto
  map("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  map("gy", telescope_builtin.lsp_type_definitions, "[G]oto T[y]pe Definition")
  map("gr", telescope_builtin.lsp_references, "[G]oto [R]eferences")
  map("gI", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation")

  -- search
  map("<leader>ss", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
  map("<leader>sS", telescope_builtin.lsp_dynamic_workspace_symbols, "Workspace [S]ymbols")

  -- actions
  map("<leader>cr", vim.lsp.buf.rename, "[R]ename Symbol")
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction") -- TODO: include visual mode ?

  local client = vim.lsp.get_client_by_id(event.data.client_id)

  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    map("<leader>th", toggle_inlay_hint, "[T]oggle Inlay [H]ints")
  end

  if client and clients_overrides[client.name] ~= nil then
    clients_overrides[client.name](client)
  end
end

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
    opts = {},
  },
  {
    -- Properly configures LuaLS for editing Neovim config.
    "folke/lazydev.nvim",
    ft = "lua",
    ---@type lazydev.Config
    opts = {
      ---@type lazydev.Library.spec[]
      library = {
        "lazy.nvim",
        "mason.nvim",
        "lazydev.nvim",
        "nvim-treesitter-context",
      },
    },
  },
  {
    -- Display Neovim LSP progress messages in the bottom right corner of the editor.
    "j-hui/fidget.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    ---@type { [string]: lspconfig.Config }
    opts = {
      ["ruff"] = {},
      ["pyright"] = {
        -- https://microsoft.github.io/pyright/#/settings
        settings = {
          pyright = {
            disableOrganizeImports = true, -- Using Ruff's import organizer
          },
        },
      },
      ["lua_ls"] = {
        -- https://github.com/LuaLS/lua-language-server/blob/master/doc/en-us/config.md
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            completion = {
              callSnippet = "Replace",
            },
            telemetry = { enable = false },
            codeLens = { enable = true },
          },
        },
      },
      ["yamlls"] = {
        -- https://github.com/redhat-developer/yaml-language-server
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
      },
      -- ["rust_analyzer"] = {},
      -- ["gopls"] = {},
      -- ["taplo"] = {},
    },

    ---@param _ LazyPlugin
    ---@param servers { [string]: lspconfig.Config }
    config = function(_, servers)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("tahv-lsp-attach", { clear = true }),
        callback = lsp_attach_callback,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_nvim_lsp = require("tahv.utils").prequire("cmp_nvim_lsp")
      if cmp_nvim_lsp then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
      end

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
    keys = {
      { "<leader>cR", ":LspRestart<CR>", desc = "LSP: [R]estart Server" },
    },
  },
}