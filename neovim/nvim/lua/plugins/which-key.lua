return {
  'folke/which-key.nvim',
  config = function()
    local wk = require("which-key")
    wk.register({
      s = { name = "+[S]earch" },
      b = { name = "+[B]uffer" },
    }, { prefix = "<leader>" })
  end,
}
