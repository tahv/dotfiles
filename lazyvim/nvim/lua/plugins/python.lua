return {
  -- add python to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },

  -- lsp config
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason install server
      servers = {
        ["pyright"] = {},
      },
    },
  },

  -- null-ls configuration
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.ruff,
        nls.builtins.diagnostics.mypy,
        nls.builtins.formatting.ruff,
        nls.builtins.formatting.black,
      })
    end,
  },
}
