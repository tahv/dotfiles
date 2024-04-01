return {
  'stevearc/oil.nvim',
  -- opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
      },
    })

    vim.keymap.set("n", "<leader>e", require("oil").open, { desc = "Open file [E]xplorer" })
    -- vim.keymap.set("n", "<leader>e", require("oil").toggle_float, { desc = "Toggle file [E]xplorer" })
  end,
}
