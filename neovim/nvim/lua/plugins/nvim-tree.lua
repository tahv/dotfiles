return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    -- disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local nvimtree = require('nvim-tree')

    nvimtree.setup({
      sort_by = "case_sensitive",
      view = {
        width = 35,
        -- float = { enable = true, },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      filters = {
        git_ignored = false,
      },

      renderer = {
        indent_markers = {
          enable = true,
          icons = {
            item = "├",
          },
        },
        icons = {
          git_placement = 'after',
          glyphs = {
            git = {
              unstaged  = "󰄱",
              staged    = "",
              unmerged  = "",
              renamed   = "󰁕",
              untracked = "★",
              deleted   = "✖",
              ignored   = "◌",
            }
          }
        },
      },
    })

    vim.keymap.set("n", "<leader>e", require('nvim-tree.api').tree.toggle, { desc = "Toggle file [E]xplorer" })
  end,
}
