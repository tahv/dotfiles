-- Displays a popup with possible keybindings of the command you started typing.  
return {
  'folke/which-key.nvim',
  event = "VeryLazy",  -- Load later
  config = function()
    require("which-key").register({
      ["<leader>s"] = { name = "+[S]earch" },
      ["<leader>b"] = { name = "+[B]uffer" },
    })
  end,
}
