local function open_root_dir()
  require("oil.actions").open_cwd.callback()
end

---@type LazySpec
return {
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
    float = {
      padding = 3,
    },
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
    { "<leader>e", "<cmd>Oil --float<cr>", desc = "[E]xplorer (Buffer Dir)" },
    {
      "<leader>E",
      function()
        require("oil.actions").open_cwd.callback()
      end,
      desc = "[E]xplorer (Root)",
    },
  },
}
