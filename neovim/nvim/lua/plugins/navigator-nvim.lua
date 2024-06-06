-- Smoothly navigate between neovim and terminal multiplexer(s)
return {
  "numToStr/Navigator.nvim",
  config = function(_, opts)
    require "Navigator".setup(opts)
  end,
  keys = {
    -- Navigate windows using <ctrl> hjkl keys
    { "<C-h>", "<CMD>NavigatorLeft<CR>",  desc = "Go to left window" },
    { "<C-j>", "<CMD>NavigatorDown<CR>",  desc = "Go to lower window" },
    { "<C-k>", "<CMD>NavigatorUp<CR>",    desc = "Go to upper window" },
    { "<C-l>", "<CMD>NavigatorRight<CR>", desc = "Go to right window" },
  },
}
