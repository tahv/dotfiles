return {
  'folke/which-key.nvim',
  config = function()
    local wk = require("which-key")
    wk.register({
      s = {
        name = "+[S]earch",
      }
    }, { prefix = "<leader>" })
  end,
}
