-- Treesitter configurations and abstraction layer for Neovim. 
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',  -- When installed or updated, update all the installed parsers.
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function ()
    require('nvim-treesitter.configs').setup({
      highlight = { enable = true }, -- Enable syntax highlighting.
      indent = { enable = true }, -- Enable indendation based on the `=` operator.

      auto_install = true, -- Autoinstall languages.
      ensure_installed = {
        'bash',
        'dockerfile',
        'gitignore',
        'json',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        -- 'mermaid,'
        'python',
        -- 'regex',
        'requirements', -- pip requirements
        -- 'rust',
        'toml',
        'vim',
        'vimdoc',
        'yaml',
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>', -- Start incremental selection.
          node_incremental = '<c-space>', -- Increment to the upper named parent.
          scope_incremental = false, -- Decrement to the upper scope.
          node_decremental = '<C-BS>', -- Decrement to the previous named node.
        },
      },
    })
  end
}
