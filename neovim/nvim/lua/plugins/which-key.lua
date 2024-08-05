-- Displays a popup with possible keybindings of the command you started typing.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  ---@type wk.Opts
  opts = {
    icons = {
      mappings = false,  -- TODO: supports icons
    },
    ---@type wk.Spec[]
    defaults = {
      { "<leader>b", group = "[B]uffer" },
      { "<leader>c", group = "[C]ode" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]oggle" },
      -- ["<leader>u"] = { name = "+[U]i" },
      { "<leader>w", group = "[W]indow" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add(opts.defaults)
  end,
}
