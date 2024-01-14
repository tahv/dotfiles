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

if vim.fn.has('win32') then
  require('win').setup()
end

-- Install plugins
require('lazy').setup({
  -- Git related plugins
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  require('plugins.fidget'), -- Useful status updates for LSP
  require('plugins.mason'), -- Automatically install LSPs to stdpath for neovim
  require('plugins.lspconfig'), -- LSP Configuration & Plugins

  require('plugins.markdown-preview'), -- Useful status updates for LSP
  require("plugins.comment"), -- Comment line or block
  require('plugins.gitsigns'), -- Adds git signs to gutter and utilities for managing changes
  require("plugins.indent-blankline"), -- Add indentation guides even on blank lines
  require("plugins.lualine"), -- Set lualine as statusline
  require('plugins.mini-bufremove'),  -- Remove buffers
  require('plugins.mini-pairs'),
  require('plugins.mini-surround'),  -- Surround actions
  require('plugins.vim-illuminate'), -- Highlight symbol under cursor
  -- require('plugins.null-ls'),
  require('plugins.onedark'), -- Theme inspired by Atom
  -- require('plugins.solarized-osaka'), -- Theme
  require("plugins.telescope"), -- Fuzzy Finder (files, lsp, etc)
  require("plugins.which-key"),  -- Show pending keybinds
  require('plugins.dressing'), -- Improve the default vim.ui interfaces 
  -- require('plugins.nvim-tree'), -- File explorer
  require('plugins.neo-tree'), -- File explorer
  require("plugins.nvim-cmp"), -- Autocompletion
  require('plugins.nvim-treesitter'), -- Highlight, edit, and navigate code
  require('plugins.nvim-treesitter-textobjects')
}, {})


require('config.options')
require('config.keymaps')
require('config.autocmds')


-- TODO: add autopairs + integration with cmp

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
