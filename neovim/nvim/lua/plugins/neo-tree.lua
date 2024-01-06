-- Neovim plugin to manage the file system and other tree like structures. 
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()

    require('neo-tree').setup({
      popup_border_style = "rounded",
      window = {
        position = "float",
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    })

    vim.keymap.set("n", "<leader>e", function() require('neo-tree.command').execute({ toggle = true }) end, { desc = "Toggle file [E]xplorer" })
  end,
}
