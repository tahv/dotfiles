-- Git integration for buffers.
return {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    current_line_blame_opts = {
      delay = 200,
    },
    current_line_blame_formatter = '<author_time:%d/%m/%y %H:%M:%S> <author> - <summary>',

    -- l = log --pretty='%C(yellow)%h %C(cyan)%ad %C(blue)%an%C(auto)%d %s' --date='format:%d/%m/%y %H:%M:%S'
    on_attach = function(bufnr)
      local gitsigns = package.loaded.gitsigns

      -- Navigation, extend the build-in vimdiff keymapp
      vim.keymap.set({'n', 'v'}, ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.next_hunk() end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })

      vim.keymap.set({'n', 'v'}, '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })

      -- Actions
      vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = '[p]review git hunk' })
      vim.keymap.set('n', '<leader>hb', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle line [b]lame' })

    end,
  },
}

