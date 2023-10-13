-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install 'lazy.vim' package manager
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require('lazy').setup({
  -- Git related plugins
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful status updates for LSP
  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

  -- Additional lua configuration, makes nvim stuff amazing!
  -- { 'folke/neodev.nvim', config = function() require('neodev').setup({}) end },

  require('plugins.mason'), -- Automatically install LSPs to stdpath for neovim
  require('plugins.lspconfig'), -- LSP Configuration & Plugins

  require("plugins.comment"), -- Comment line or block
  require('plugins.gitsigns'), -- Adds git signs to gutter and utilities for managing changes
  require("plugins.indent-blankline"), -- Add indentation guides even on blank lines
  require("plugins.lualine"), -- Set lualine as statusline
  require('plugins.mini-bufremove'),  -- Remove buffers
  require('plugins.mini-pairs'),
  -- require('plugins.null-ls'),
  require('plugins.onedark'), -- Theme inspired by Atom
  require("plugins.telescope"), -- Fuzzy Finder (files, lsp, etc)
  require("plugins.which-key"),  -- Show pending keybinds
  require('plugins.dressing'), -- Improve the default vim.ui interfaces 
  require('plugins.nvim-tree'), -- File explorer

  -- Autocompletion
  require("plugins.nvim-cmp"),

  -- Highlight, edit, and navigate code
  require('plugins.nvim-treesitter'),
  require('plugins.nvim-treesitter-textobjects'),
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
require('config.options')

-- [[ Basic Keymaps ]]

vim.keymap.set('n', '<leader>bb', "<cmd>e #<cr>", { desc = 'Switch to other [B]uffer' })
-- vim.keymap.set('n', '<leader>e', ':Explore<cr>', { desc = 'Open [E]xplorer' })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
-- Move by screen line if no count was given, otherwise move by text line
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Manage windows using the tmux split keys 
vim.keymap.set('n', '<leader>w"', '<C-W>s', { desc = 'Split [W]indow below' })
vim.keymap.set('n', '<leader>w%', '<C-w>v', { desc = 'Split [W]indow right' })
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = '[W]indow [D]elete' })

-- Navigate windows using <ctrl> hjkl keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })  
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Center buffer when moving
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move half screen up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move half screen down' })
vim.keymap.set('n', 'gg', 'ggzz', { desc = 'Go to the first line of the document' })
vim.keymap.set('n', 'G', 'Gzz', { desc = 'Go to the last line of the document' })
vim.keymap.set('n', 'n', 'nzz', { desc = 'Repeat search in same direction' })
vim.keymap.set('n', 'N', 'Nzz', { desc = 'Repeat search in opposite direction' })
vim.keymap.set('n', '<C-o>', '<C-o>zz', { desc = 'Go to older position in jump list' })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { desc = 'Go to newer position in jump list' })

-- TODO: add autopairs + integration with cmp

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
