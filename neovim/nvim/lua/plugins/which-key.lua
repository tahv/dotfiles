-- Displays a popup with possible keybindings of the command you started typing.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    defaults = {
      ["<leader>b"] = { name = "+[B]uffer" },
      ["<leader>c"] = { name = "+[C]ode" },
      ["<leader>s"] = { name = "+[S]earch" },
      ["<leader>t"] = { name = "+[T]oggle" },
      -- ["<leader>u"] = { name = "+[U]i" },
      ["<leader>w"] = { name = "+[W]indow" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
