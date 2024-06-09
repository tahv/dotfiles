-- Displays a popup with possible keybindings of the command you started typing.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    defaults = {
      ["<leader>b"] = { name = "+[B]uffer" },
      ["<leader>c"] = { name = "+[C]ode" },
      ["<leader>u"] = { name = "+[U]i" },
      ["<leader>s"] = { name = "+[S]earch" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
