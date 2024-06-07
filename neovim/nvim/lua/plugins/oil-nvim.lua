return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
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
  },
  keys = {
    {
      "<leader>e",
      function()
        require("oil").open()
      end,
      desc = "[E]xplorer (Buffer Dir)",
    },
    {
      "<leader>E",
      function()
        require("oil").open(vim.uv.cwd())
      end,
      desc = "[E]xplorer (Root)",
    },
  },
}
