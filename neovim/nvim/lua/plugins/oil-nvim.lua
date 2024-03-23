return {
  'stevearc/oil.nvim',
  -- opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,
      }
    })

    vim.keymap.set("n", "<leader>e", require("oil").open, { desc = "Open file [E]xplorer" })
    -- vim.keymap.set("n", "<leader>e", require("oil").toggle_float, { desc = "Toggle file [E]xplorer" })
  end,
}
