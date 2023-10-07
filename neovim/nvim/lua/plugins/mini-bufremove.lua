-- Neovim Lua plugin to remove buffers. 
return {
  'echasnovski/mini.bufremove',
  version = '*', -- Stable version
  config = function()
    local bufremove = require('mini.bufremove')
    vim.keymap.set('n', '<leader>bd', function() bufremove.delete(0, false) end, { desc = '[B]uffer [D]elete' })
    vim.keymap.set('n', '<leader>bD', function() bufremove.delete(0, true) end, { desc = '[B]uffer [D]elete (force)' })
  end,
}
