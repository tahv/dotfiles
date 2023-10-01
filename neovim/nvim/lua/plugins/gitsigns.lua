return {
  'lewis6991/gitsigns.nvim',
  opts = {
    -- TODO: show change in yellow ?
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

      -- don't override the built-in and fugitive keymaps
      vim.keymap.set({'n', 'v'}, ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() package.loaded.gitsigns.next_hunk() end)
        return '<Ignore>'
      end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})

      vim.keymap.set({'n', 'v'}, '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() package.loaded.gitsigns.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})

    end,
  },
}

