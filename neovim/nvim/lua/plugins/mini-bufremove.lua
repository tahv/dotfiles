-- Neovim Lua plugin to remove buffers. 
return {
  'echasnovski/mini.bufremove',
  version = '*', -- Stable version
  config = function()
    vim.keymap.set('n', '<leader>bd', function() require('mini.bufremove').delete(0, false) end, { desc = '[B]uffer [D]elete' })
    vim.keymap.set('n', '<leader>bD', function() require('mini.bufremove').delete(0, true) end, { desc = '[B]uffer [D]elete (Force)' })
  end,
}
