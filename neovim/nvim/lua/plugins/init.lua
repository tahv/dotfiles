---@type LazySpec[]
return {
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  require("plugins.lsp"), -- LSP Configuration & Plugins
  require("plugins.markdown"),
  require("plugins.comment"), -- Comment line or block
  require("plugins.gitsigns"), -- Adds git signs to gutter and utilities for managing changes
  require("plugins.indent-blankline"), -- Add indentation guides even on blank lines
  require("plugins.lualine"), -- Set lualine as statusline
  require("plugins.mini-bufremove"), -- Remove buffers
  require("plugins.mini-pairs"),
  require("plugins.mini-surround"), -- Surround actions
  require("plugins.vim-illuminate"), -- Highlight symbol under cursor
  require("plugins.colorschemes"),
  require("plugins.telescope"), -- Fuzzy Finder (files, lsp, etc)
  require("plugins.which-key"), -- Show pending keybinds
  require("plugins.dressing"), -- Improve the default vim.ui interfaces
  require("plugins.nvim-cmp"), -- Autocompletion
  require("plugins.treesitter"),
  require("plugins.navigator-nvim"),
  {
    -- Buffer-lile file explorer
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Load the plugin eagerly so oil takes over netrw
    ---@type oil.setupOpts
    opts = {
      win_options = {
        winbar = "%{v:lua.require('oil').get_current_dir()}",
      },
      view_options = {
        show_hidden = true,
      },
      float = { padding = 3 },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["q"] = "actions.close",
      },
    },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "[E]xplorer (Buffer Dir)" },
      {
        "<leader>E",
        function()
          require("oil.actions").open_cwd.callback()
        end,
        desc = "[E]xplorer (Root)",
      },
    },
  },
}
