-- Neovim Lua plugin to automatically manage character pairs.
return {
  'echasnovski/mini.pairs',
  event = "VeryLazy",
  version = '*',  -- stable
  config = function ()
    require('mini.pairs').setup()
  end,
}
