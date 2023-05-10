return {
  -- add rust to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "rust" })
      end
    end,
  },

  -- lsp config
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason install server
      servers = {
        ["rust_analyzer"] = {},
      },
    },
  },

  -- null-ls configuration
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.rustfmt,
      })
    end,
  },
}
