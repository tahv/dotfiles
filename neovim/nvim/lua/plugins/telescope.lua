return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Lib of lua functions
    'nvim-tree/nvim-web-devicons', -- Add file types icons
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available.
    { 'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function ()
    local telescope = require("telescope")

    -- See `:help telescope` and `:help telescope.setup()`
    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        file_ignore_patterns = { "^.git/" },
        mappings = {
          i = {
            -- Disable 'Next item' and 'Previous item' in insert mode
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })

    -- Enable telescope fzf native, if installed
    pcall(telescope.load_extension, 'fzf')

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sf', function() require('telescope.builtin').find_files({ hidden = true }) end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, { desc = '[S]earch [R]ecently opened files' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    -- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end, { desc = '[S]earch document [D]iagnostics' })
    vim.keymap.set('n', '<leader>sD', require('telescope.builtin').diagnostics, { desc = '[S]earch workspace [D]iagnostics' })

  end,
}

