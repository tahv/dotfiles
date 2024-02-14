-- Extensible UI for Neovim notifications and LSP progress messages. 
return {
  'j-hui/fidget.nvim',
  config = function()
    require('fidget').setup({})
  end,
}
