---@type LazySpec[]
return {
  {
    "linux-cultist/venv-selector.nvim",
    enabled = false,
    dependencies = {
      -- "neovim/nvim-lspconfig",
      { "folke/snacks.nvim" },
    },
    ft = "python",
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "select [v]env" },
    },
    opts = {
      ---@type venv-selector.Options
      options = {
        picker = "snacks",
        debug = true,
        notify_user_on_venv_activation = true,
      },
    },
  },
}
