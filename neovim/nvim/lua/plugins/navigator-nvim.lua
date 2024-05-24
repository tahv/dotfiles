-- Smoothly navigate between neovim and terminal multiplexer(s)
return {
  "numToStr/Navigator.nvim",
  config = function()
    require('Navigator').setup()

    -- Navigate windows using <ctrl> hjkl keys
    vim.keymap.set('n', '<C-h>', '<CMD>NavigatorLeft<CR>', { desc = 'Go to left window' })
    vim.keymap.set('n', '<C-j>', '<CMD>NavigatorDown<CR>', { desc = 'Go to lower window' })
    vim.keymap.set('n', '<C-k>', '<CMD>NavigatorUp<CR>', { desc = 'Go to upper window' })
    vim.keymap.set('n', '<C-l>', '<CMD>NavigatorRight<CR>', { desc = 'Go to right window' })
  end,
}
