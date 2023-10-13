return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'L3MON4D3/LuaSnip',  -- Snippet engine
    'rafamadriz/friendly-snippets',  -- Pre-configured snippets for different languages

    'saadparwaiz1/cmp_luasnip',  -- Source for LuaSnip snippets
    -- 'hrsh7th/cmp-buffer',  -- Source for text in current buffer
    -- 'hrsh7th/cmp-path',  -- Source for file system paths
    'hrsh7th/cmp-nvim-lsp',  -- Source for neovim builtin LSP client 
  },
  config = function ()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()
        
    -- luasnip.config.setup {}  -- TODO: remove
        
    -- See `:help cmp`
    cmp.setup({
      completion = {
        -- autocomplete = false,
        -- completeopt = 'menuone,preview,noselect',
      },

      -- Configure how nvim-cmp interacts with the snippet engine.
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      
      -- Sources for autocompletion, order matters.
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },

      mapping = cmp.mapping.preset.insert {
        ['<C-p>'] = cmp.mapping.select_prev_item(), -- Previous suggestion
        ['<C-n>'] = cmp.mapping.select_next_item(), -- Next suggestion
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(), -- Show completion suggestion
        ['<C-e>'] = cmp.mapping.abort(), -- Close the completion window
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace, -- Replace adjacent text with selected item.
          select = false, -- Automatically select the first item (`true`), or only confirm explicitly selected item (`false`)
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    })

  end,
}

